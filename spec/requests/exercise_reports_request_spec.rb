require 'rails_helper'

RSpec.describe "ExerciseReports", type: :request do

  before :each do
    create(:exercise)
    sign_in create(:user, kind: :user)
    create(:training_routine)
    create(:workout)
    create(:workout_report)
  end

  describe 'show' do
    
    before :each do
      @exercise_report = ExerciseReport.last
      get "/exercise_reports/#{@exercise_report.id}"
    end

    context 'when exercise_report exist' do
      it 'is expected to return status :ok' do
        expect(response).to have_http_status :ok
      end
      it 'is expected to return a exercise_report' do
        response_body = JSON.parse response.body
        exercise_report = response_body["exercise_report"]
        expect(exercise_report["id"]).to match @exercise_report.id
      end
    end

  end

end
