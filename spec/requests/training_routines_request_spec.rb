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

  describe 'progress' do
    
    before(:each) { @user = create(:user, kind: :user) }

    context 'when user doesnt have a training routine' do
      it 'is expected to return 404 status' do
        get "/training_routines/#{@user.id}/progress"
        expect(response).to have_http_status :not_found
      end
    end

    context 'when user have a training_routine in progress' do
      before :each do
        @training_routine = create(:training_routine, user: @user)
        get "/training_routines/#{@user.id}/progress"
      end
      it 'is expected to return ok status' do
        expect(response).to have_http_status :ok
      end
      it 'is expected to return a training_routine object' do
        response_body = JSON.parse response.body
        training_routine = TrainingRoutine.new response_body["training_routine"]
        expect(training_routine).to match @training_routine
      end
    end

  end

  describe 'update' do
    before :each do
      create(:exercise)
      @training_routine = create(:training_routine)
      create(:workout)
      patch "/training_routines/#{@training_routine.id}", params: { training_routine: { status: "complete" } }
    end
    it 'is expected to return ok status' do
      expect(response).to have_http_status :ok
    end
    it 'is expected to return a training_routine' do
      response_body = JSON.parse response.body
      expect(response_body.key?("training_routine")).to be_truthy
    end
    it 'is expected to save values' do
      expect(@training_routine.reload.complete?).to be_truthy
    end
  end

  describe 'can_be_complete' do

    context 'when user has a active training_routine' do
      before :each do
        create(:exercise)
        create(:training_routine)
        create(:workout, classes_to_attend: 1)
      end
      after(:each) { expect(response).to have_http_status :ok }
      after(:each) do 
        response_body = JSON.parse response.body
        expect(response_body.key?("can_be_complete")).to be_truthy
      end
      context 'when all workouts have as many workout_reports as classes_to_attend' do
        it 'is expected to return true' do
          create(:workout_report, status: :complete)
          get "/training_routines/can_be_complete"
          response_body = JSON.parse response.body
          expect(response_body["can_be_complete"]).to be_truthy
        end
      end  
      context 'when not all workouts has as many workout_report as requested' do
        it 'is expected to return false' do
          get "/training_routines/can_be_complete"
          response_body = JSON.parse response.body
          expect(response_body["can_be_complete"]).to be_falsey
        end
      end
    end

    context 'when user does not have a progress training_routine' do
      it 'is expected to return :not_found status' do
        get "/training_routines/can_be_complete"
        expect(response).to have_http_status :not_found
      end
    end

  end

end
