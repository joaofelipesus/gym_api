require 'rails_helper'

RSpec.describe Exercise, type: :model do

  describe 'new exercise' do
    
    context 'is invalid when without' do
      before(:each) { @exercise = build(:exercise) }
      after(:each) { expect(@exercise).to be_invalid }
      it 'name' do
        @exercise.name = ''
      end
    end

    it 'is active when set no status' do
      exercise = build(:exercise, status: nil)
      expect(exercise).to be_valid
      expect(exercise.active?).to be_truthy
    end

    it 'is invalid when duplicated name' do
      first_exercise = create(:exercise)
      duplicated = build(:exercise, name: first_exercise.name)
      expect(duplicated).to be_invalid
    end

    it 'is valid when name and status are ok' do
      exercise = build(:exercise, name: 'Supino', status: :active)
      expect(exercise).to be_valid
    end

  end

end
