require 'rails_helper'

RSpec.describe Admin::FacilitatorsController, type: :controller do
  describe '#facilitators' do
    context 'facilitator tries viewing admin dashboard' do
      let!(:facilitator) { create(:facilitator) }

      before { sign_in facilitator }

      it 'redirects to unauthorised page' do
        get :index
        expect(response).to redirect_to(static_pages_index_path)
      end
    end

    context 'admin views admin dashboard' do
      let!(:facilitator_1) { create(:facilitator) }
      let!(:facilitator_2) { create(:facilitator) }
      let!(:facilitator_3) { create(:facilitator) }
      let!(:admin) { create(:admin) }

      before { sign_in admin }

      it 'should render facilitators template' do
        get :index
        expect(response).to render_template(:index)
        expect(assigns(:facilitators).count).to eq(3)
      end
    end
  end
end
