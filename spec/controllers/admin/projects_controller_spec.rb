require 'rails_helper'

RSpec.describe Admin::ProjectsController, type: :controller do
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
    end
  end

  describe "#create" do
    let!(:facilitator) { create(:facilitator) }
    let!(:admin) { create(:admin) }

    before { sign_in admin }

    context 'when project creation succeeds' do
      it 'should redirect to facilitators#index' do
        post :create, params: {
          facilitator_id: facilitator.id,
          project: attributes_for(:project)
        }
        expect(response).to redirect_to(admin_facilitators_path)
      end
    end

    context 'when project creation fails' do
      it 'should render projects#new' do
        post :create, params: {
          facilitator_id: facilitator.id,
          project: attributes_for(:project, :invalid)
        }
        expect(response).to render_template(:new)
      end
    end
  end
end
