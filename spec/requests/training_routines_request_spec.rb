require 'rails_helper'

RSpec.describe "TrainingRoutines", type: :request do

  before :each do
    sign_in create(:user, kind: :user)
  end

  describe 'create' do
    
    context 'when without user_id' do
      before :each do
        post '/training_routines', params: { training_routine: { started_at: Date.current } }
      end
      it 'is expected to return unprocessable_entity status' do
        expect(response).to have_http_status :unprocessable_entity
      end
      it 'is expected to return error message' do
        response_body = JSON.parse response.body
        expect(response_body["errors"].first).to match "User é obrigatório(a)"
      end
    end

    context 'when with all attributes ok' do
      before :each do
        @user = create(:user, kind: :user)
        post '/training_routines', params: { training_routine: {user_id: @user.id }}
      end
      it 'is expected to return created status' do
        expect(response).to have_http_status :created
      end
      it 'is expected to return training_routine created' do
        response_body = JSON.parse response.body
        expect(response_body["training_routine"]["user_id"]).to eq @user.id
      end
    end

  end

end
