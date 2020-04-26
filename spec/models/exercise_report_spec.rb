require 'rails_helper'

RSpec.describe ExerciseReport, type: :model do

  describe '#create' do

    before :each do
      create(:user)
      create(:training_routine)
      create(:exercise)
      create(:workout)
      create(:workout_report)
      @exercise_report = build(:exercise_report)
    end
    
    it 'is invalid when without weight' do
      @exercise_report.weight = nil
      expect(@exercise_report).to be_invalid
    end
    it 'is invalid when without workout_report' do
      @exercise_report.workout_report = nil
      expect(@exercise_report).to be_invalid
    end
    it 'is invalid when without workout_exercise' do
      @exercise_report.workout_exercise = nil
      expect(@exercise_report).to be_invalid
    end
    it 'ok case' do
      expect(@exercise_report).to be_valid
    end

  end

end
