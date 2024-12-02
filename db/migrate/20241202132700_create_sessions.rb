class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.integer :weekday
      t.time :start_time

      t.timestamps
    end
  end
end
