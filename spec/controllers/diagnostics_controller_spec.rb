require 'rails_helper'

RSpec.describe DiagnosticsController, type: :controller do
  describe '#new' do
    let!(:student) { create(:student) }

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
    let!(:student_1) { create(:student, project: project, name: 'a') }
    let!(:student_2) { create(:student, project: project, name: 'b') }

    describe '#admin' do
      before { sign_in admin }

      context 'when diagnostic custom validation fails' do
        let!(:levels_attributes) do
          {
              levels_attributes: {
                  '0': attributes_for(:level),
              }
          }
        end

        let!(:params) do
          {
              id: student_1.id,
              diagnostic: attributes_for(:diagnostic).merge(levels_attributes)
          }
        end

        it 'should render new template when custom validation fails' do
          mock_levels_validator = LevelsValidator.new
          allow(LevelsValidator).to receive(:new).and_return(mock_levels_validator)
          allow(mock_levels_validator).to receive(:get_validation_info).and_return({is_valid: false, message: 'invalid message'})
          post :create, params: params
          expect(response).to render_template(:new)
        end

        it 'should return a flash alert with custom validation message' do
          mock_levels_validator = LevelsValidator.new
          allow(LevelsValidator).to receive(:new).and_return(mock_levels_validator)
          allow(mock_levels_validator).to receive(:get_validation_info).and_return({is_valid: false, message: 'invalid message'})
          post :create, params: params
          expect(flash[:alert]).to eql('invalid message')
        end
      end

      context 'when diagnostic creation succeeds' do
        let!(:levels_attributes) do
          {
              levels_attributes: {
                  '0': attributes_for(:level, reading_level: 1),
              }
          }
        end

        let!(:params) do
          {
              id: student_1.id,
              diagnostic: attributes_for(:diagnostic).merge(levels_attributes)
          }
        end

        it 'should redirect to admin_project#show' do
          post :create, params: params
          expect(response).to redirect_to(admin_project_path(project.id))
        end

        context 'submit and go to next student' do
          let!(:first_student_params) do
            {
                id: student_1.id,
                diagnostic: attributes_for(:diagnostic).merge(levels_attributes),
                submit_and_go_to_next_student: true
            }
            end

          let!(:second_student_params) do
            {
                id: student_2.id,
                diagnostic: attributes_for(:diagnostic).merge(levels_attributes),
                submit_and_go_to_next_student: true
            }
          end

          context 'student is not the last student' do
            it 'should redirect to the next student diagnostic path' do
              post :create, params: first_student_params
              expect(response).to redirect_to(new_student_diagnostic_path(student_2.id))
            end
          end

          context 'student is the last student' do
            it 'should redirect the projects page' do
              post :create, params: second_student_params
              expect(response).to redirect_to(admin_project_path(project.id))
            end
          end

        end
      end

      context 'when diagnostic creation fails' do
        let!(:levels_attributes) do
          {
              levels_attributes: {
                  '0': attributes_for(:level),
                  '1': attributes_for(:level, :invalid)
              }
          }
        end

        let!(:invalid_params) do
          {
              id: student_1.id,
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
        let!(:levels_attributes) do
          {
              levels_attributes: {
                  '0': attributes_for(:level, reading_level: 1),
              }
          }
        end

        let!(:params) do
          {
              id: student_1.id,
              diagnostic: attributes_for(:diagnostic).merge(levels_attributes)
          }
        end

        it 'should redirect to facilitator_project#show' do
          post :create, params: params
          expect(response).to redirect_to(facilitator_project_path(project.id))
        end
      end
    end

  end

end
