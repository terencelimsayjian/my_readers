require 'rails_helper'

RSpec.describe Facilitator::ProjectsController, type: :controller do
  context 'non-logged in user tries viewing projects belonging to a facilitator' do
    it 'redirects to unauthorised page' do
      get :index
      expect(response).to redirect_to(static_pages_index_path)
    end
    end

  context 'admin cannot view projects belonging to a facilitator' do
    let!(:admin) { create(:admin) }

    before { sign_in admin }

    it 'redirects to unauthorised page' do
      get :index
      expect(response).to redirect_to(static_pages_index_path)
    end
    end

  context 'facilitator can view projects assigned to him' do
    let!(:facilitator) { create(:facilitator) }
    let!(:project_1) { create(:project, facilitator: facilitator) }
    let!(:project_2) { create(:project) }

    before { sign_in facilitator }

    it 'renders the index page' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'should return a list of projects with students' do
      get :index
      expect(assigns(:projects)).to eq([project_1])
    end
  end
end
