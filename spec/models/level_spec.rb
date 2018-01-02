require 'rails_helper'

RSpec.describe Level, type: :model do
  let(:valid_level) { create(:level) }
  let(:invalid_level) { build(:level, phonics_score: 4, number_of_tested_words: 3) }

  it { expect(valid_level).to belong_to(:diagnostic) }
  it { expect(valid_level).to validate_presence_of(:reading_level) }
  it { expect(valid_level).to validate_presence_of(:fluency_score) }
  it { expect(valid_level).to validate_presence_of(:comprehension_score) }

  describe 'custom validations' do
    context 'when phonics score is less than number of tested words' do
      it { expect(valid_level.valid?).to be(true) }
    end

    context 'when phonics score is greater than number of tested words' do
      it { expect(invalid_level.valid?).to be(false) }
    end
  end
end
