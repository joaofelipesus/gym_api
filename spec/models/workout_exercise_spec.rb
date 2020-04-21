require 'rails_helper'

RSpec.describe WorkoutExercise, type: :model do

  describe 'create new workout_exercise' do
    
    context 'when without required value is invalid' do
      before :each do
        user = create(:user, kind: :user)
        exercise = create(:exercise)
        training_routine = create(:training_routine)
        workout = create(:workout)
        @workout_exercise = build(:workout_exercise)
      end
      after :each do
        expect(@workout_exercise).to be_invalid
      end
      it 'is invalid when without exercise' do
        @workout_exercise.exercise = nil
      end
      it 'is invalid when without workout' do
        @workout_exercise.workout = nil
      end
      it 'is invalid when without rest_time' do
        @workout_exercise.rest_time = nil
      end
      it 'is invalid when without repetitions' do
        @workout_exercise.repetitions = nil
      end
    end

  end

end
