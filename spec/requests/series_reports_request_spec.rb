require 'rails_helper'

RSpec.describe "SeriesReports", type: :request do
  include ActiveSupport::Testing::TimeHelpers

  before :each do
    sign_in create(:user, kind: :user)
    create(:exercise)
    create(:training_routine)
    create(:workout)
    create(:workout_report)
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

  describe 'progression' do
    context 'when user has series reports to make a progression' do
      before :each do
        3.times do |index|
          series_report = create(:series_report, sequence_index: index + 1, weight_used: 10)
        end  
        travel_to 3.days.ago do
          create(:workout_report)
          3.times { |index| create(:series_report, sequence_index: index + 1, weight_used: 15) }
        end
        travel_back
        get "/series_reports/#{Exercise.last.id}/progression"
        response_body = JSON.parse response.body
        @weights_used = response_body["weights_used"]
      end
      it 'is expected to return status :ok' do
        expect(response).to have_http_status :ok
      end
      it 'is expected to return a list of hashes with date and mean_weight keys' do
        expect(@weights_used[0].key?("date")).to be_truthy
        expect(@weights_used[0].key?("mean_weight")).to be_truthy
      end
      it 'is expected to be order by created_at date' do
        first_date = @weights_used.first["date"].to_date
        last_date = @weights_used.last["date"].to_date
        expect(first_date < last_date).to be_truthy
      end
    end
  end

end
