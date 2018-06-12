class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :work_field, :string
    add_column :users, :job_title, :string
    add_column :users, :work_place, :string
    add_column :users, :latitude, :decimal, { precision: 10, scale: 6 }
    add_column :users, :longitude, :decimal, { precision: 10, scale: 6 }
    add_column :users, :gender_preference, :string
  end
end
