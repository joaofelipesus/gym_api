require 'rails_helper'
require 'json'

RSpec.describe "Exercises", type: :request do

  before :each do
    sign_in create(:user)
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
        response_body = JSON.parse(response.body).first
        expect(response_body).to match 'Nome não pode ficar em branco'
      end
      it 'returns error message when duplicated name' do
        exercise = create(:exercise)
        post '/exercises', params: { exercise: { name: exercise.name } }
        response_body = JSON.parse response.body
        expect(response_body.first).to match 'Nome já está em uso'
      end
    end

  end

end
