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
        expect(assigns(:facilitator)).to eq(facilitator)
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

    context 'when project creation with 2 students succeeds' do
      let(:students_attributes) do
        {
          students_attributes: {
            '0': attributes_for(:student),
            '1': attributes_for(:student)
          }
        }
      end
      let(:params) do
        {
          facilitator_id: facilitator.id,
          project: attributes_for(:project).merge(students_attributes)
        }
      end

      it 'should redirect to facilitators#index' do
        post :create, params: params
        expect(response).to redirect_to(admin_facilitators_path)
      end
      it 'should create 2 students' do
        post :create, params: params
        expect(Student.count).to eq(2)
      end
    end

    context 'when project creation with students fails' do
      let(:students_attributes) do
        {
          students_attributes: {
            '0': attributes_for(:student, :invalid),
            '1': attributes_for(:student)
          }
        }
      end
      let(:params) do
        {
          facilitator_id: facilitator.id,
          project: attributes_for(:project).merge(students_attributes)
        }
      end

      it 'should render projects#new' do
        post :create, params: params
        expect(response).to render_template(:new)
      end
      it 'should not create any students' do
        post :create, params: params
        expect(Student.count).to eq(0)
      end
    end
  end
end
