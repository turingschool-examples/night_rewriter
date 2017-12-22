require_relative 'alphabet'
require 'pry'


class Encoder

  def initialize
    @alphabet = Alphabet.new
  end

  def lookup(letter)
    @alphabet.braille_letter_hash[letter]
  end

  def encode(input)
    output = [[],[],[]]
    input.chars.each do |letter|
      append_character(letter, output)
    end
    format_output(output).join
  end

  def format_output(output)
    output.each do |row|
      row << "\n"
    end
  end

  def append_character(letter, output)
    letter = capitalize(letter, output)
    append_braille(letter, output)
  end

  def append_braille(letter, output)
    iterator = 0
    lookup(letter).chars.each_slice(2) do |this|
      output[iterator] << this.reduce(:+)
      iterator += 1
    end
  end

  def capitalize(letter, output)
    if letter == letter.upcase
      append_character(:capitalize, output)
      letter = letter.downcase
    else
      letter
    end
  end

end
