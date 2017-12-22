require_relative 'alphabet'

class Encoder

  attr_reader :input,
              :output

  def initialize(input)
    @input = input
    @output = []
    @alphabet = Alphabet.new
  end

  def encode
    build_lines(input)
    output.join
  end

  def build_lines(plain)
    [0,2,4].each do |offset|
      convert(plain, offset)
    end
  end

  def convert(plain, offset)
    append_line(plain, offset)
    append_line_break
  end

  def append_line_break
    output << "\n"
  end

  def append_line(plain, offset)
    plain.chars.each do |letter|
      letter = capitalize(letter, offset) if letter == letter.upcase
      append_braille_letter(letter, offset)
    end
  end

  def append_braille_letter(letter, offset)
    output << @alphabet.lookup(letter, offset) << @alphabet.lookup(letter, offset + 1)
  end

  def capitalize(letter, offset)
    output << @alphabet.lookup(:capitalize, offset) << @alphabet.lookup(:capitalize, offset + 1)
    letter.downcase
  end

end
