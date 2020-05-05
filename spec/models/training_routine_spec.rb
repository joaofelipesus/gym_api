require 'rails_helper'

RSpec.describe TrainingRoutine, type: :model do

  before(:each) { create(:user, kind: :user) }

  context 'creating a new training_routine' do

    context 'is invalid when without' do
      before(:each) { @training_routine = build(:training_routine) }
      after(:each) { expect(@training_routine).to be_invalid }
      it 'user' do
        @training_routine.user = nil
      end
    end

    context 'default values' do
      it 'is expected to have progress status as default status' do
        training_routine = create(:training_routine)
        expect(training_routine.progress?).to be_truthy
      end
    end

    it 'ok example' do
      training_routine = create(:training_routine)
      expect(training_routine).to be_valid
    end

  end

  describe "can_be_complete?" do
    before :each do
      create(:exercise)
      create(:training_routine)
      create(:workout, classes_to_attend: 1)
    end
    context 'when all workouts have as many workout_reports as classes_to_attend' do
      it 'is expected to return true' do
        create(:workout_report, status: :complete)
        training_routine = TrainingRoutine.last 
        expect(training_routine.can_be_complete?).to be_truthy
      end
    end
    context 'when not all workouts have as many workout_reports as classes_to attend' do
      it 'is expected to return false' do
        training_routine = TrainingRoutine.last
        expect(training_routine.can_be_complete?).to be_falsey
      end
    end
  end

  describe 'complete' do
    before :each do
      @training_routine = create(:training_routine)
      create(:exercise)
      create(:workout, classes_to_attend: 1)
      create(:workout_report, status: :complete)
      @training_routine.complete
    end
    it 'is expected to change training_routine status to :complete' do
      expect(@training_routine.reload.complete).to be_truthy
    end
    it 'is expected to set finished_at to current date' do
      expect(@training_routine.reload.finished_at).to match Date.current
    end
    it 'is expected to change its workouts status to :complete' do
      workout = @training_routine.reload.workouts.first
      expect(workout.complete?).to be_truthy
    end
  end

end
