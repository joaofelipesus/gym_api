require 'rails_helper'

RSpec.describe WorkoutReport, type: :model do

  before :each do
    create(:user, kind: :user)
    create(:training_routine)
    create(:exercise)
    create(:workout)
  end

  describe 'create' do
    it 'is invalid when without workout' do
      workout_report = build(:workout_report, workout: nil)
      expect(workout_report).to be_invalid
    end

    it 'is expected to have date value as Date.current' do
      workout_report = build(:workout_report, date: nil)
      expect(workout_report).to be_valid 
      expect(workout_report.date).to eq Date.current
    end

    it 'is expected to have default status as :progress' do
      workout_report = build(:workout_report, status: nil)
      expect(workout_report).to be_valid
      expect(workout_report.progress?).to be_truthy
    end

    it 'ok example' do
      workout_report = build(:workout_report)
      expect(workout_report).to be_valid
    end
  end

end
