require_relative 'alphabet'
require_relative 'parser'

class NightWriter
   include Parser

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

  def encode_to_braille(plain)
    output = check_eng_capitals(plain)
    output.join
  end

  def encode_from_braille(braille)
    lines = braille.split("\n")
    n = lines[0].length
    m = 3
    as_one_line = lines.join
    format_braille(n, m, as_one_line)
  end
end

