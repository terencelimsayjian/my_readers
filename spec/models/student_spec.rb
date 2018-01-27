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

  describe '#current_reading_level' do
    let!(:student) { create(:student) }
    let!(:student_2) { create(:student) }
    let!(:first_diagnostic) { create(:diagnostic, student: student)}
    let!(:second_diagnostic) { create(:diagnostic, student: student)}
    let!(:last_diagnostic) { create(:diagnostic, student: student)}
    let!(:level_1_first_diagnostic) { create(:level, diagnostic: first_diagnostic)}
    let!(:level_1_second_diagnostic) { create(:level, diagnostic: second_diagnostic)}

    context 'failure occurs before level 11' do
      describe 'when student fails reading level 3' do
        let!(:level_1) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_2) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_3) { create(:level, :failing_phonics_score, diagnostic: last_diagnostic)}

        it 'should return 2 as current reading level' do
          expect(student.current_reading_level).to be(2)
        end
      end

      describe 'when student fails reading level 3' do
        let!(:level_1) { create(:level, :failing_phonics_score, diagnostic: last_diagnostic)}

        it 'should return 0 as current reading level' do
          expect(student.current_reading_level).to be(0)
        end
      end

      describe 'when student passes all reading levels' do
        let!(:level_1) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_2) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_3) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_4) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_5) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_6) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_7) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_8) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_9) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_10) { create(:level, diagnostic: last_diagnostic)}
        let!(:level_11) { create(:level, phonics_score: 92, number_of_tested_words: 100, diagnostic: last_diagnostic)}

        it 'should return 11 as current reading level' do
          expect(student.current_reading_level).to be(11)
        end
      end

    end
  end

  describe '#beginning_reading_level' do
    let!(:student) { create(:student) }
    let!(:student_2) { create(:student) }
    let!(:first_diagnostic) { create(:diagnostic, index: 1, student: student)}
    let!(:second_diagnostic) { create(:diagnostic, index: 2, student: student)}
    let!(:last_diagnostic) { create(:diagnostic, index: 4, student: student)}
    let!(:level_1_second_diagnostic) { create(:level, :failing_phonics_score, reading_level: 1, diagnostic: second_diagnostic)}
    let!(:level_1_last_diagnostic) { create(:level, :failing_phonics_score, reading_level: 1, diagnostic: last_diagnostic)}

    context 'failure occurs before level 11' do
      describe 'when student fails reading level 3' do
        let!(:level_1) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_2) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_3) { create(:level, :failing_phonics_score, diagnostic: first_diagnostic)}

        it 'should return 2 as current reading level' do
          expect(student.beginning_reading_level).to be(2)
        end
      end

      describe 'when student fails reading level 1' do
        let!(:level_1) { create(:level, :failing_phonics_score, diagnostic: first_diagnostic)}

        it 'should return 0 as current reading level' do
          expect(student.beginning_reading_level).to be(0)
        end
      end

      describe 'when student has no diagnostics' do
        it 'should return 0 as current reading level' do
          expect(student_2.beginning_reading_level).to be(0)
        end
      end

      describe 'when student passes all reading levels' do
        let!(:level_1) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_2) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_3) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_4) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_5) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_6) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_7) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_8) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_9) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_10) { create(:level, diagnostic: first_diagnostic)}
        let!(:level_11) { create(:level, phonics_score: 92, number_of_tested_words: 100, diagnostic: first_diagnostic)}

        it 'should return 11 as current reading level' do
          expect(student.beginning_reading_level).to be(11)
        end
      end

    end



  end

end
