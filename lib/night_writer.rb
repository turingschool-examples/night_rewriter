require_relative 'alphabet'

class NightWriter
  include Alphabet

  def initialize
    @output = []
  end

  def encode_to_braille(plain)
    [0,2,4].each do |offset|
      plain_chars(plain, offset)
      output << "\n"
    end
    output.join
  end

  private
    attr_reader :output

    def plain_chars(plain, offset)
      plain.chars.each {|letter| if_block(letter, offset)}
    end

    def if_block(letter, offset)
      if letter == letter.upcase
        output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
        letter = letter.downcase
      end
      output << lookup(letter, offset) << lookup(letter, offset + 1)
    end

end
