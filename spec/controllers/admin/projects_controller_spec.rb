require 'rails_helper'

RSpec.describe Admin::ProjectsController, type: :controller do
  describe '#index' do
    context '#facilitators' do
      context 'facilitator tries viewing admin dashboard' do
        let!(:facilitator) { create(:facilitator) }

        before { sign_in facilitator }

        it 'redirects to unauthorised page' do
          get :index
          expect(response).to redirect_to(static_pages_index_path)
        end
      end
    end

    context 'admin views projects' do
      let!(:admin) { create(:admin) }
      let!(:project_1) { create(:project) }
      let!(:project_2) { create(:project) }
      let!(:project_3) { create(:project) }

      before { sign_in admin }

      it 'should render facilitators template' do
        get :index
        expect(response).to render_template(:index)
        expect(assigns(:projects)).to eq([project_1, project_2, project_3])
      end
    end
  end

  describe '#show' do
    context '#facilitators' do
      context 'facilitator tries viewing admin dashboard' do
        let!(:facilitator) { create(:facilitator) }
        let!(:project) { create(:project) }

        before { sign_in facilitator }

        it 'redirects to unauthorised page' do
          get :show, params: { id: project.id }
          expect(response).to redirect_to(static_pages_index_path)
        end
      end
    end

    context 'admin views project' do
      let!(:admin) { create(:admin) }
      let!(:project) { create(:project) }

      before { sign_in admin }

      it 'should render project' do
        get :show, params: { id: project.id }
        expect(response).to render_template(:show)
        expect(assigns(:project)).to eq(project)
      end
    end
  end

  describe '#new' do
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

  describe '#edit' do
    describe '#facilitators' do
      context 'facilitator tries viewing admin dashboard' do
        let!(:facilitator) { create(:facilitator) }
        let!(:project) { create(:project) }

        before { sign_in facilitator }

        it 'redirects to unauthorised page' do
          get :edit, params: { id: project.id }
          expect(response).to redirect_to(static_pages_index_path)
        end
      end
    end

    context 'admin views edit project page' do
      let!(:admin) { create(:admin) }
      let!(:project) { create(:project) }

      before { sign_in admin }

      it 'should render project' do
        get :edit, params: { id: project.id }
        expect(response).to render_template(:edit)
        expect(assigns(:project)).to eq(project)
      end
    end

  end

  describe '#create' do
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

  describe '#update' do
    let!(:facilitator) { create(:facilitator) }
    let!(:admin) { create(:admin) }
    let!(:project) { create(:project) }

    before { sign_in admin }

    context 'when project update succeeds' do
      it 'should redirect to admin_project#show' do
        patch :update, params: {
            id: project.id,
            project: attributes_for(:project)
        }
        expect(response).to redirect_to(admin_project_path(project.id))
      end
    end

    context 'when project update fails' do
      it 'should render projects#new' do
        patch :update, params: {
            id: project.id,
            project: attributes_for(:project, :invalid)
        }
        expect(response).to render_template(:edit)
      end
    end

    context 'when project update with 2 students succeeds' do
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
            id: project.id,
            project: attributes_for(:project).merge(students_attributes)
        }
      end

      it 'should redirect to facilitators#index' do
        patch :update, params: params
        expect(response).to redirect_to(admin_project_path(project.id))
      end

      it 'should create 2 students' do
        patch :update, params:params
        expect(Student.count).to eq(2)
      end
    end
  end
end
