require 'rails_helper'

RSpec.describe Workout, type: :model do

  describe 'when without required values' do
    it 'is invalid when without name'
    it 'is invalid when without training_routine'
  end

  it 'is invalid when training_routine already have a workout with same name'

  it 'ok case'

end
