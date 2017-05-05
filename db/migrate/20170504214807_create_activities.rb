class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :sport
      t.datetime :activity_id
      t.attachment :gpx

      t.timestamps
    end
  end
end
