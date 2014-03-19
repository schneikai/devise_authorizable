class Create<%= table_name.camelize %> < ActiveRecord::Migration
  def change
    create_table(:<%= table_name %>) do |t|
      t.integer :authorizable_id
      t.string :authorizable_type
      t.string :name

      t.timestamps
    end

    add_index :<%= table_name %>, [:authorizable_id, :authorizable_type], name: '<%= table_name %>_index'
  end
end
