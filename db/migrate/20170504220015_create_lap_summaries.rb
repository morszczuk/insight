class CreateLapSummaries < ActiveRecord::Migration[5.0]
  def change
    create_table :lap_summaries do |t|
      t.references :lap, foreign_key: true
      t.float :total_time_seconds
      t.float :distance_meters
      t.float :maximum_speed
      t.float :calories
      t.integer :average_heart_rate_bmp
      t.integer :maximum_heart_rate_bmp
      t.string :intensity
      t.integer :cadence
      t.string :trigger_method

      t.timestamps
    end
  end
end
