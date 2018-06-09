class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :work_field, :string
    add_column :users, :job_title, :string
    add_column :users, :work_place, :string
  end
end
