class CreateBulks < ActiveRecord::Migration
  def change
    create_table :bulks do |t|
      t.references :user, index: true, foreign_key: true
      t.date :start_date
      t.text :values

      t.timestamps null: false
    end
  end
end
