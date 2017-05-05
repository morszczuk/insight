class Lap < ApplicationRecord
  belongs_to :activity
  has_one :lap_summary
end
