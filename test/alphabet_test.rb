require "./test/test_helper"
require "./lib/alphabet"

class AlphabetTest < Minitest::Test
  def alphabet
    @alphabet ||= Alphabet.braille_translations
  end

	def test_number_of_characters
		assert_equal 35, alphabet.count
	end

	def test_hash_values_as_braille
		alphabet.each do | k, v|
			assert_equal 6, v.length
			v.chars.each do |c|
				assert c == '0' || c == '.'
			end
		end
	end
end
