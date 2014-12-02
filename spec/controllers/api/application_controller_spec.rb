require 'spec_helper'

describe Api::ApplicationController, type: :controller do
  controller(Api::ApplicationController) do
    def index; render nothing: true; end
  end

  it 'recognize token from params' do
    token = 'test'
    get :index, token: token
    expect(controller.send(:token)).to eql(token)
  end

  it 'returns 401 for invalid token' do
    get :index, token: 'invalid token'
    assert_response :unauthorized
  end

  it 'returns 400 for no token' do
    get :index
    assert_response :bad_request
  end
end
