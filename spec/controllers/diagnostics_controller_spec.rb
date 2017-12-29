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

  describe '#create' do
    let!(:facilitator) { create(:facilitator) }
    let!(:admin) { create(:admin) }
    let!(:project) { create(:project) }
    let!(:student) { create(:student, project: project) }

    describe '#admin' do
      before { sign_in admin }

      context 'when diagnostic creation succeeds' do
        it 'should redirect to admin_project#show' do
          post :create, params: {
              id: student.id,
              diagnostic: attributes_for(:diagnostic)
          }
          expect(response).to redirect_to(admin_project_path(project.id))
        end
      end

      context 'when diagnostic creation fails' do
        let(:levels_attributes) do
          {
              levels_attributes: {
                  '0': attributes_for(:level),
                  '1': attributes_for(:level, :invalid)
              }
          }
        end

        let(:invalid_params) do
          {
              id: student.id,
              diagnostic: attributes_for(:diagnostic).merge(levels_attributes)
          }
        end

        it 'should render diagnostics#new' do
          post :create, params: invalid_params
          expect(response).to render_template(:new)
        end
      end
    end

    describe '#facilitator' do
      before { sign_in facilitator }

      context 'when diagnostic creation succeeds' do
        it 'should redirect to facilitator_project#show' do
          post :create, params: {
              id: student.id,
              diagnostic: attributes_for(:diagnostic)
          }
          expect(response).to redirect_to(facilitator_project_path(project.id))
        end
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