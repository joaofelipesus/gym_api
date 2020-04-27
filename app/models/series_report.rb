class SeriesReport < ApplicationRecord
  belongs_to :exercise_report
  validates_presence_of :weight_used, :sequence_index
end
