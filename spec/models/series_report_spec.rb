require 'rails_helper'

RSpec.describe SeriesReport, type: :model do

  before :each do
    create(:exercise)
    create(:user, kind: :user)
    create(:training_routine)
    create(:workout, workout_exercises: [build(:workout_exercise, series_number: 1)])
    create(:workout_report)
    create(:exercise_report)
  end

  describe 'create new series_report' do

    context 'series report is invalid when' do
      before :each do
        @series_report = build(:series_report)
      end
      after :each do
        expect(@series_report).to be_invalid
      end
      it 'is invalid when without exercise_report' do
        @series_report.exercise_report = nil
      end
      it 'is invalid when without wheight_used' do
        @series_report.weight_used = nil
      end
      it 'is invalid when without sequence_index' do
        @series_report.sequence_index = nil
      end
    end
    
    it 'ok' do
      series_report = build(:series_report, weight_used: 15.5, sequence_index: 1, exercise_report: ExerciseReport.last)
      expect(series_report).to be_valid
    end

    it 'change exercise_report after all series_reports are created' do
      series_report = create(:series_report)
      expect(series_report).to be_valid
      expect(ExerciseReport.last.complete?).to be_truthy
    end

  end

end
