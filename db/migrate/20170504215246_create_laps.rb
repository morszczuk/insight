class CreateLaps < ActiveRecord::Migration[5.0]
  def change
    create_table :laps do |t|
      t.datetime :start_time
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
