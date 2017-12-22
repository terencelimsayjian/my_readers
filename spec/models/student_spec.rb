require 'rails_helper'

RSpec.describe Student, type: :model do

  let(:subject) { create(:student) }

  it { expect(subject).to belong_to(:project) }
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_presence_of(:class_name) }

end
