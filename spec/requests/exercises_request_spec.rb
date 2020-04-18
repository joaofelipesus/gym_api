require 'rails_helper'
require 'json'

RSpec.describe "Exercises", type: :request do

  before :each do
    sign_in create(:user)
  end

  describe 'index' do
    
    context 'when a request is done to index' do
      it 'is expected to return all exercises' do
        5.times { create(:exercise) }
        get '/exercises'
        response_body = JSON.parse response.body
        expect(response_body["exercises"].size).to eq 5
      end
      it 'is expected to return status ok' do
        get '/exercises'
        expect(response).to have_http_status :ok
      end
      it 'is expected to be order by name' do
        create(:exercise, name: 'Agachamento terra')
        create(:exercise, name: 'Supino')
      end
    end
    
  end

  describe 'create' do
    
    context 'create with success' do
      before :each do
        @exercise = build(:exercise)
      end
      it 'is expected to return status created' do
        post '/exercises', params: { exercise: { name: @exercise.name } }
        expect(response).to have_http_status :created
      end
      it 'is expected to create exercise' do
        post '/exercises', params: { exercise: { name: @exercise.name } }
        expect(Exercise.count).to eq 1
      end
    end

    context 'when request has errors' do
      it 'returns error message when without name' do
        post '/exercises', params: { exercise: { name: ''} }
        response_body = JSON.parse(response.body)["errors"]
        expect(response_body.first).to match 'Nome não pode ficar em branco'
      end
      it 'returns error message when duplicated name' do
        exercise = create(:exercise)
        post '/exercises', params: { exercise: { name: exercise.name } }
        response_body = JSON.parse(response.body)["errors"]
        expect(response_body.first).to match 'Nome já está em uso'
      end
    end

  end


  describe 'update' do
    
    context 'changing status' do
      
      before :each do
        @exercise = create(:exercise)
      end

      it 'is expected to return ok status' do
        patch "/exercises/#{@exercise.id}", params: { exercise: { status: :inactive.to_s }}
        expect(response).to have_http_status :ok
      end

      it 'is expected to save its value' do
        expect(@exercise.inactive?).to be_falsey
        patch "/exercises/#{@exercise.id}", params: { exercise: { status: :inactive.to_s }}
        expect(@exercise.reload.inactive?).to be_truthy
      end
      
    end

    context "changing name" do
      
      context 'duplicated name' do
        before :each do
          first = create(:exercise, name: 'Azuka')
          @exercise = create(:exercise)
          patch "/exercises/#{@exercise.id}", params: { exercise: { name: 'Azuka'} }
        end
        it 'is expected to return unprocessable_entity' do
          expect(response).to have_http_status :unprocessable_entity
        end
        it 'is expected to return "Nome já está em uso"' do
          response_body = JSON.parse response.body
          expect(response_body["errors"].first).to match "Nome já está em uso"
        end
      end

      context 'ok' do
        before :each do
          @exercise = create(:exercise)
          patch "/exercises/#{@exercise.id}", params: { exercise: { name: 'Azuka'} }
        end
        it 'is expected to return status ok' do
          expect(response).to have_http_status :ok
        end
        it 'is expected to return exercise' do
          expect(@exercise.reload.name).to match 'Azuka'
        end
      end

      context 'when id passed is invalid' do
        it 'is expected to return not_found status' do
          patch '/exercises/7615237625', params: { exercise: {name: 'some name' }}
          expect(response).to have_http_status :not_found
        end
      end

    end

  end

  describe 'show' do
    
    context 'when resource exist' do
      before :each do
        @exercise = create(:exercise)
        get "/exercises/#{@exercise.id}"
      end
      it 'is expected to return the exercise' do
        response_body = JSON.parse response.body
        expect(response_body["exercise"]["name"]).to match @exercise.name
      end
      it 'is expected to return status ok' do
        expect(response).to have_http_status :ok
      end
    end

    context 'when resource doesnt exist' do
      before :each do
        get '/exercises/12312327615237'
      end
      it 'is expected to return error message "Exercício não encontrado"' do
        response_body = JSON.parse response.body
        expect(response_body["error"]).to match I18n.t :exercise_not_found
      end
      it 'is expected to return status :not_found' do
        expect(response).to have_http_status :not_found
      end
    end

  end

end
