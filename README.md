# DeviseAuthorizable

DeviseAuthorizable adds user roles and user authorization to
[Devise](https://github.com/plataformatec/devise). You can assign roles like
*admin* or *moderator* to users and define what they can read, create, update
and/or destroy in your App.

```ruby
@user.can? :read, Post
=> true

@user.can? :manage, Post
=> false

@user.add_role :admin

@user.can? :manage, Post
=> true
```

DeviseAuthorizable supports Rails 4 and Devise 3.


## Installation

You must have installed and configured Devise first. Follow the guides on
https://github.com/plataformatec/devise.

Add DeviseAuthorizable to your Gemfile and run the bundle command to install it:

```ruby
gem 'devise_authorizable'
```

After the Gem is installed you need to run the install generator:

```console
rails generate devise_authorizable:install
```

This will include the DeviseAuthorizable module to Devise, create the ability
class that you use to setup abilities (aka permissions) and generate migrations.

Thats it. Read on for how to setup roles and add abilities.


## Add and manage user roles

At the moment roles can only be managed via the Rails console.
Someone who would like to add a browser based role manager is very welcome.

```ruby
# To get all roles of the current user:
@user.roles
=> [:guest]

# To check if the user has the specified role:
@user.has_role? :admin
=> true

# To add a role 'admin' to the user:
@user.add_role :admin

# To remove the 'admin' role from the user
@user.delete_role :admin
```

## Define abilities

DeviseAuthorizable uses [CanCan](https://github.com/ryanb/cancan) to define
and check abilities for users.

The install generator added a ability class to your application. If your Devise
model is called *User* the ability model name is *UserAbility*. This is where
you define the abilities for your application.

Based on the roles you use in your application you add methods of the same name
to the ability class. For example if you have three roles *guest*, *authenticated*
and *admin* this would look like:

```ruby
def guest
end

def authenticated
end

def admin
end
```

The roles *guest* and *authenticated* are system roles. That means they exist
without explicitly adding them to a user. Users have the *guest* role if they are
not signed in and the *authenticated* role if they are signed in.

Now you add abilities via the *can* method. For Example you want your guest users
to read everything, authenticated users to create posts and destroy their own
posts and admins to manage everything this would look like:

```ruby
def guest
  can :read, :all
end

def authenticated
  can :create, Post
  can [:update, :destroy], Post, user_id: user.id
end

def admin
  can :manage, :all
end
```

The first argument to *can* is the action you are giving the user
permission to do. If you pass <tt>:manage</tt> it will apply to every action.
Other common actions here are <tt>:read</tt>, <tt>:create</tt>, <tt>:update</tt>
and <tt>:destroy</tt>.

The second argument is the resource the user can perform the action on.
If you pass <tt>:all</tt> it will apply to every resource. Otherwise pass a
Ruby class of the resource.

The third argument is an optional hash of conditions to further filter the
objects. For example, here the user can only update published articles.

```ruby
can :update, Article, published: true
```

See the CanCan Wiki for details:
https://github.com/ryanb/cancan/wiki/Defining-Abilities


### Role inheritance

DeviseAuthorizable uses role inheritance. That means a user with
the *guest* role has only guest abilities. But a user with the *authenticated*
role has the abilities of a guest AND the abilities of a authenticated user.

Abilities defined later will override previous ones. For example,
let's say you want the user to be able to do everything to projects except
destroy them. This is the correct way.

```ruby
can :manage, Project
cannot :destroy, Project
```

It is important that the <tt>cannot :destroy</tt> line comes after the
<tt>can :manage</tt> line. If they were reversed, <tt>cannot :destroy</tt>
would be overridden by <tt>can :manage</tt>. Therefore, it is best to place
the more generic rules near the top.

https://github.com/ryanb/cancan/wiki/Ability-Precedence


## Licence

MIT-LICENSE. Copyright 2014 Kai Schneider.
