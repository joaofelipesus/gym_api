require 'rails_helper'

RSpec.describe TrainingRoutine, type: :model do

  context 'creating a new training_routine' do

    before(:each) { create(:user, kind: :user) }

    context 'is invalid when without' do
      before(:each) { @training_routine = build(:training_routine) }
      after(:each) { expect(@training_routine).to be_invalid }
      it 'user' do
        @training_routine.user = nil
      end
      it 'has_class_limit' do
        @training_routine.has_class_limit = nil
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

end
