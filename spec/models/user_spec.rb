require 'rails_helper'

RSpec.describe User, type: :model do

  context 'is invalid when missing required values' do
    before(:each) { @user = build(:user) }
    after(:each) { expect(@user).to be_invalid }

    it 'email' do
      @user.email = ""
    end
    it 'password' do
      @user.password = ""
    end
    it 'kind' do
      @user.kind = nil
    end

  end

  it 'is invaluid when duplicated email' do
    first_user = create(:user)
    duplicated = build(:user, email: first_user.email)
    expect(duplicated).to be_invalid
    expect(first_user).to be_valid
  end

  it 'is valid when all values are ok' do
    user = build(:user, email: 'some@email.com', password: '123123', kind: :user)
  end

end
