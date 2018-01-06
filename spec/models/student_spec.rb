require 'rails_helper'

RSpec.describe Student, type: :model do

  let(:subject) { create(:student) }

  it { expect(subject).to belong_to(:project) }
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:class_name) }

  describe 'order' do
      let!(:student_3) { create(:student, name: 'b', class_name: 'b') }
      let!(:student_2) { create(:student, name: 'b', class_name: 'a') }
      let!(:student_1) { create(:student, name: 'a') }

      it 'should return students ordered by name (ascending), followed by class name (ascending)' do
        students = Student.all
        expect(students[0]).to be == student_1
        expect(students[1]).to be == student_2
        expect(students[2]).to be == student_3
      end
  end

end
