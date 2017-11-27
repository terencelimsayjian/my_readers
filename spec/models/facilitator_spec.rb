require 'rails_helper'

RSpec.describe Facilitator, type: :model do

  describe "validations" do
    let(:facilitator) {
      Facilitator.new(
          email: "a@b.com",
          password: "test1234",
          full_name: "Sample Facilitator",
          school: "SMK school",
          district: "Petaling Jaya",
          state: 14,
          phone_number: "019-1234123"
      )
    }

    it 'fails when facilitator does not have a email' do
      facilitator.email = "       "
      expect(facilitator.valid?).to be(false)
    end

    context 'fails when email does not follow a valid format' do
      it '' do
        facilitator.email = "asdf.com"
        expect(facilitator.valid?).to be(false)
        end

      it '' do
        facilitator.email = "asdf@.com"
        expect(facilitator.valid?).to be(false)
        end

      it '' do
        facilitator.email = "asdf@a."
        expect(facilitator.valid?).to be(false)
      end
    end

    it 'fails when facilitator does not have a full name' do
      facilitator.full_name = "       "
      expect(facilitator.valid?).to be(false)
    end

    it 'fails when facilitator does not have a school' do
      facilitator.school = "       "
      expect(facilitator.valid?).to be(false)
    end

    it 'fails when facilitator does not have a district' do
      facilitator.district = "       "
      expect(facilitator.valid?).to be(false)
    end

    it 'fails when facilitator does not have a state' do
      facilitator.state = "       "
      expect(facilitator.valid?).to be(false)
      end

    it 'fails when facilitator does not have a phone number' do
      facilitator.phone_number = "       "
      expect(facilitator.valid?).to be(false)
      end

    it 'fails when phone number does not have valid characters' do
      facilitator.phone_number = "1234!@"
      expect(facilitator.valid?).to be(false)
    end

  end
end
