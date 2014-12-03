require 'spec_helper'

describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  context 'POST /reset_token' do
    it 'resets user token' do
      old_token = user.token
      login_user(user)
      post :reset_token
      expect(old_token).not_to eql(user.token)
    end
  end
end
