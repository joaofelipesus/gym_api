require 'rails_helper'

RSpec.describe "SeriesReports", type: :request do

  before :each do
    sign_in create(:user, kind: :user)
    create(:exercise)
    create(:training_routine)
    create(:workout)
    create(:workout_report)
    create(:exercise_report)
    @series_reports = [
      {
        exercise_report_id: ExerciseReport.last.id,
        weight_used: 15.5,
        sequence_index: 1,
      },
      {
        exercise_report_id: ExerciseReport.last.id,
        weight_used: 18,
        sequence_index: 2,
      },
      {
        exercise_report_id: ExerciseReport.last.id,
        weight_used: 20,
        sequence_index: 3,
      },
    ]
  end

  describe 'create' do
    
    context 'when required data is missing' do

      def send_request_and_get_error_message
        post '/series_reports', params: { series_reports: @series_reports }
        response_body = JSON.parse response.body
        @error_message = response_body["errors"].first
      end

      after :each do
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'is expected to return "Peso utilizado não pode ficar em branco" when without weight_used' do
        @series_reports.first.delete :weight_used
        send_request_and_get_error_message
        expect(@error_message).to match "Peso utilizado não pode ficar em branco"
      end
      it 'is expected to return "Exercício é obrigatório(a)" when without exercise_report_id' do
        @series_reports.first.delete :exercise_report_id
        send_request_and_get_error_message
        expect(@error_message).to match "Exercício é obrigatório(a)"
      end
      it 'is expected to return "Seqência não pode ficar em branco" when without sequence_index"' do
        @series_reports.first.delete :sequence_index
        send_request_and_get_error_message
        expect(@error_message).to match "Sequência não pode ficar em branco"
      end
    end

    context 'when params are ok' do
      before :each do
        post '/series_reports', params: { series_reports: @series_reports }
      end
      it 'is expected to return created status' do
        expect(response).to have_http_status :created
      end
      it 'is expected to return series_report created' do
        response_body = JSON.parse response.body
        series_reports = response_body["series_reports"]
        expect(series_reports.first["weight_used"]).to match @series_reports.first[:weight_used]
        expect(series_reports.first["sequence_index"]).to match @series_reports.first[:sequence_index]
        expect(series_reports.first["exercise_report_id"]).to match @series_reports.first[:exercise_report_id]
        expect(series_reports.first["id"]).to match SeriesReport.first.id
      end
    end

  end

end
