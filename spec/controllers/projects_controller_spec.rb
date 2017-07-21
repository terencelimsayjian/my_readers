require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "#new" do
    describe '#facilitators' do
      context 'facilitator tries viewing admin dashboard' do
        let!(:facilitator) { create(:facilitator) }

        before { sign_in facilitator }

        it 'redirects to unauthorised page' do
          get :new, params: { facilitator_id: facilitator.id }
          expect(response).to redirect_to(static_pages_index_path)
        end
      end
    end

    context 'admin views admin dashboard' do
      let!(:facilitator) { create(:facilitator) }
      let!(:admin) { create(:admin) }

      before { sign_in admin }

      it 'should render facilitators template' do
        get :new, params: { facilitator_id: facilitator.id }
        expect(response).to render_template(:new)
      end

      # expect(assigns(:facilitators).count).to eq(3)
    end



  end
end
