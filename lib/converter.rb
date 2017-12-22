module Converter
  def self.to_braille(plain)
    output = []
    [0,2,4].each do |offset|
      encode_letter(plain, offset, output)
      output << "\n"
    end
    encoded = output.join
  end

  def encode_letter(plain, offset, output)
    plain.chars.each do |letter|
      handle_case(letter, output, offset)
    end
  end

  def handle_case(letter, output, offset)
    if letter == letter.upcase
      output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
      letter = letter.downcase
    end
    output << lookup(letter, offset) << lookup(letter, offset + 1)
  end
end
