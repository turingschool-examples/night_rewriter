require "./test/test_helper"
require "./lib/alphabet"

class AlphabetTest < Minitest::Test
  def alphabet
    @alphabet ||= Alphabet.new
  end

	def test_number_of_characters
		assert_equal 35, alphabet.braille_letter_hash.count
	end

	def test_hash_values_as_braille
		alphabet.braille_letter_hash.each do | k, v|
			assert_equal 9, v.length
			v.chars.each do |c|
				assert c == "0" || c == "." || c == "\n"
			end
		end
	end
end
