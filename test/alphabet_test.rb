require "./test/test_helper"
require "./lib/alphabet"

class ModuleTest
  include Alphabet
end

class AlphabetTest < Minitest::Test
  def module_test
    @module_test ||= ModuleTest.new
  end

	def test_number_of_characters
		assert_equal 35, module_test.braille_letter_hash.count
	end

	def test_hash_values_as_braille
		module_test.braille_letter_hash.each do | k, v|
			assert_equal 6, v.length
			v.chars.each do |c|
				assert c == '0' || c == '.'
			end
		end
	end
end
