class CreateDurations < ActiveRecord::Migration
  def change
    create_table :durations do |t|
      t.references :user, index: true, foreign_key: true
      t.date :day
      t.integer :minutes

      t.timestamps null: false
    end
  end
end
