require 'rails_helper'

RSpec.describe "Workouts", type: :request do

  before :each do
    sign_in create(:user, kind: :user)
    create(:exercise)
    create(:exercise)
    create(:training_routine)
    @workout_hash = {
      name: 'Perna',
      training_routine_id: TrainingRoutine.last.id,
      workout_exercises_attributes: [
        {
          exercise_id: Exercise.last.id,
          repetitions: 15,
          rest_time: 30,
          series_number: 3,
        },
        {
          exercise_id: Exercise.first.id,
          repetitions: 15,
          rest_time: 30,
          series_number: 4,
        }
      ]
    }
  end

  describe 'create' do
    context 'when all fields were ok' do
      before :each do
        post '/workouts', params: { workout: @workout_hash }
      end
      it 'is expected to return status created' do
        expect(response).to have_http_status :created
      end
      it 'is expected to return workout created' do
        response_body = JSON.parse response.body
        expect(response_body["name"]).to match "Perna"
        expect(response_body["training_routine_id"]).to match TrainingRoutine.last.id
        expect(response_body["workout_exercises"].size).to match 2
      end
    end

    context 'when attributes has errors' do
      after :each do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'is invalid when without name' do
        @workout_hash.delete :name
        post '/workouts', params: { workout: @workout_hash }
        response_body = JSON.parse response.body
        expect(response_body["errors"].first).to match "Nome não pode ficar em branco"
      end
      it 'is invalid when without workout_exercises' do
        @workout_hash.delete :workout_exercises_attributes
        post '/workouts', params: { workout: @workout_hash }
        response_body = JSON.parse response.body
        expect(response_body["errors"].first).to match "Exercícios não pode ficar em branco"
      end
      it 'is invalid when without any of workout_exercise required params' do
        @workout_hash[:workout_exercises_attributes].first.delete :rest_time
        post '/workouts', params: { workout: @workout_hash }
        response_body = JSON.parse response.body
        expect(response_body["errors"].first).to match "Tempo de descanso não pode ficar em branco"
      end
      it 'is invalid when name is already in use to this training_routine' do
        create(:workout, name: @workout_hash[:name])
        post '/workouts', params: { workout: @workout_hash }
        response_body = JSON.parse response.body
        expect(response_body["errors"].first).to match "Nome já está em uso para esta rotina de treinos"
      end
    end
  end

  describe 'show' do
    
    context 'when workout doesnt exist' do
      before :each do
        get "/workouts/#{404}"
      end
      it 'is expected to return status :not_found' do
        expect(response).to have_http_status :not_found
      end
      it 'is expected to render not_found message' do
        response_body = JSON.parse response.body
        expect(response_body["error"]).to match "Não encontrado"
      end
    end

    context 'when workout exist' do

      before :each do
        @workout = create(:workout)
        get "/workouts/#{@workout.id}"
      end

      it 'is expected to return status :ok' do
        expect(response).to have_http_status :ok
      end
      it 'is expected to return workout object' do
        response_body = JSON.parse response.body
        workout = response_body["workout"]
        expect(workout["id"]).to match @workout.id
        expect(workout["name"]).to match @workout.name
        expect(workout["classes_to_attend"]).to match @workout.classes_to_attend
        expect(workout["workout_exercises"].size).to match @workout.workout_exercises.size
      end
    end
  end

end
