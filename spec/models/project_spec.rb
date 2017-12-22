require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:subject) { create(:project) }

  it { expect(subject).to belong_to(:facilitator) }
  it { expect(subject).to validate_presence_of(:name) }

  describe 'custom validations' do
    context 'when end date is later than start date' do
      it { expect(subject.valid?).to be(true) }
    end

    context 'when end date is earlier than start date' do
      let(:subject) { build(:project, :invalid) }
      it { expect(subject.valid?).to be(false) }
    end
  end
end
