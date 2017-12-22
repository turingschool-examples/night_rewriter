require_relative 'alphabet'

class TranslateToBraille
  include Alphabet

  attr_accessor :output

  def initialize
    @output = []
  end

  def translate(plain)
    encode(plain)

    encoded = output.join
  end

  def encode(plain)
    output = []
    [0,2,4].each do |offset|
      plain.chars.each do |letter|
        if letter == letter.upcase
          output << self.lookup(:capitalize, offset) << self.lookup(:capitalize, offset + 1)
          letter = letter.downcase
        end
        output << self.lookup(letter, offset) << self.lookup(letter, offset + 1)
      end
      output << "\n"
    end
  end

end
