require 'rails_helper'

RSpec.describe DiagnosticsController, type: :controller do
  let!(:student) { create(:student) }

  describe '#new' do
    context 'non logged in user' do
      it 'redirects to unauthorised page' do
        get :new, params: { id: student.id }
        expect(response).to redirect_to(static_pages_index_path)
      end
    end

    context '#facilitator' do
      let!(:facilitator) { create(:facilitator) }

      before { sign_in facilitator }

      it 'should render new diagnostics template' do
        get :new, params: { id: student.id }
        expect(response).to render_template(:new)
      end
      end

    context '#admin' do
      let!(:admin) { create(:admin) }

      before { sign_in admin }

      it 'should render new diagnostics template' do
        get :new, params: { id: student.id }
        expect(response).to render_template(:new)
      end
    end
  end

  # describe '#index' do
  #
  #   context 'admin views projects' do
  #     let!(:admin) { create(:admin) }
  #     let!(:project_1) { create(:project) }
  #     let!(:project_2) { create(:project) }
  #     let!(:project_3) { create(:project) }
  #
  #     before { sign_in admin }
  #
  #     it 'should render facilitators template' do
  #       get :index
  #       expect(response).to render_template(:index)
  #       expect(assigns(:projects)).to eq([project_1, project_2, project_3])
  #     end
  #   end
  # end


end
