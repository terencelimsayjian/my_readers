require 'rails_helper'
require Rails.root.to_s + '/app/utils/diagnostic_level_validator_util.rb'

RSpec.describe DiagnosticLevelValidator do

  describe '#validate' do
    it 'should be valid for a single valid level' do
      levels_attributes = {
          levels_attributes: {
              '0': attributes_for(:level),
          }
      }

      diagnostic_level_validator = DiagnosticLevelValidator.new
      validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
      expect(validation_info[:is_valid]).to be (true)
      expect(validation_info[:message]).to eq ('')
    end

    context 'reading_level_validations' do
      it 'should be invalid if the reading_level of the single level is not 1' do
        levels_attributes = {
            levels_attributes: {
                '0': attributes_for(:level, reading_level: 2),
            }
        }

        diagnostic_level_validator = DiagnosticLevelValidator.new
        validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
        expect(validation_info[:is_valid]).to be (false)
        expect(validation_info[:message]).to eq ('Invalid starting level.')
      end

      it 'should be invalid if there are two consecutive levels, and the first reading_level is not 1' do
        levels_attributes = {
            levels_attributes: {
                '0': attributes_for(:level, reading_level: 2),
                '1': attributes_for(:level, reading_level: 3),
            }
        }

        diagnostic_level_validator = DiagnosticLevelValidator.new
        validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
        expect(validation_info[:is_valid]).to be (false)
        expect(validation_info[:message]).to eq ('Invalid starting level.')
      end

      it 'should be invalid if there are two non-consecutive levels' do
        levels_attributes = {
            levels_attributes: {
                '0': attributes_for(:level, reading_level: 1),
                '1': attributes_for(:level, reading_level: 3),
                '2': attributes_for(:level, reading_level: 4),
            }
        }

        diagnostic_level_validator = DiagnosticLevelValidator.new
        validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
        expect(validation_info[:is_valid]).to be (false)
        expect(validation_info[:message]).to eq ('Non-consecutive levels.')
        end

      it 'should be invalid if the final reading level is greater than 11' do
        levels_attributes = {
            levels_attributes: {
                '0': attributes_for(:level, reading_level: 1),
                '1': attributes_for(:level, reading_level: 2),
                '2': attributes_for(:level, reading_level: 3),
                '3': attributes_for(:level, reading_level: 4),
                '4': attributes_for(:level, reading_level: 5),
                '5': attributes_for(:level, reading_level: 6),
                '6': attributes_for(:level, reading_level: 7),
                '7': attributes_for(:level, reading_level: 8),
                '8': attributes_for(:level, reading_level: 9),
                '9': attributes_for(:level, reading_level: 10),
                '10': attributes_for(:level, reading_level: 11),
                '11': attributes_for(:level, reading_level: 12),
            }
        }

        diagnostic_level_validator = DiagnosticLevelValidator.new
        validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
        expect(validation_info[:is_valid]).to be (false)
        expect(validation_info[:message]).to eq ('Invalid ending level.')
      end
    end

    context '#phonics_score_validations' do
      it 'should be invalid if an earlier level has below 99% words recognised' do
        levels_attributes = {
            levels_attributes: {
                '0': attributes_for(:level, number_of_tested_words: 100, phonics_score:98, reading_level: 1),
                '1': attributes_for(:level, number_of_tested_words: 100, phonics_score:99, reading_level: 2),
            }
        }

        diagnostic_level_validator = DiagnosticLevelValidator.new
        validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
        expect(validation_info[:is_valid]).to be (false)
        expect(validation_info[:message]).to eq ('Earlier levels must exceed 99% words recognised.')
        end

      it 'should be valid if all but the last level has above 99% words recognised' do
        levels_attributes = {
            levels_attributes: {
                '0': attributes_for(:level, number_of_tested_words: 100, phonics_score:99, reading_level: 1),
                '1': attributes_for(:level, number_of_tested_words: 100, phonics_score:80, reading_level: 2),
            }
        }

        diagnostic_level_validator = DiagnosticLevelValidator.new
        validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
        expect(validation_info[:is_valid]).to be (true)
        expect(validation_info[:message]).to eq ('')
        end

      it 'should round up 98.5% and above to meet the threshold' do
        levels_attributes = {
            levels_attributes: {
                '0': attributes_for(:level, number_of_tested_words: 1000, phonics_score:985, reading_level: 1),
                '1': attributes_for(:level, number_of_tested_words: 100, phonics_score:30, reading_level: 2),
            }
        }

        diagnostic_level_validator = DiagnosticLevelValidator.new
        validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
        expect(validation_info[:is_valid]).to be (true)
        expect(validation_info[:message]).to eq ('')
        end

      it 'should round up 98.49% and below to fail the threshold' do
        levels_attributes = {
            levels_attributes: {
                '0': attributes_for(:level, number_of_tested_words: 1000, phonics_score:984, reading_level: 1),
                '1': attributes_for(:level, number_of_tested_words: 100, phonics_score:30, reading_level: 2),
            }
        }

        diagnostic_level_validator = DiagnosticLevelValidator.new
        validation_info = diagnostic_level_validator.get_validation_info(get_params(levels_attributes))
        expect(validation_info[:is_valid]).to be (false)
        expect(validation_info[:message]).to eq ('Earlier levels must exceed 99% words recognised.')
      end

    end

  end
end

def get_params(levels_attributes)
  {
      id: 1,
      diagnostic: attributes_for(:diagnostic).merge(levels_attributes)
  }
end

# custom validations
  # phonics_validations
    # check if any before the last one is below 99%
    # check if except the last one is below 99%
  # reading_level_validations
    # check if there is more than 1 and no more than 11
    # check if there is one of each level going up