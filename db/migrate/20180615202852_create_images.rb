class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :base_64
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
