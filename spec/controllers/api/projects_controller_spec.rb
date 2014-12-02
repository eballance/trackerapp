require 'spec_helper'

describe Api::ProjectsController, type: :controller do
  context '#index' do
    it 'returns projects json array' do
      user, project = create_user_with_project

      get :index, token: user.token
      assert_response :success
      json_projects = JSON.parse(response.body)
      assert_json_project(json_projects.first, project)
    end
  end

  context '#show' do
    it 'returns project json object' do
      user, project = create_user_with_project

      get :show, id: project.id, token: user.token
      assert_response :success
      json_project = JSON.parse(response.body)
      assert_json_project(json_project, project)
    end
  end

  def assert_json_project(hash, project)
      expect(hash["id"]).to eql(project.id)
      expect(hash["name"]).to eql(project.name)
  end

  def create_user_with_project
    user = FactoryGirl.create(:user)
    project = FactoryGirl.create(:project, users: [user], account: user.account)
    return [user, project]
  end
end
