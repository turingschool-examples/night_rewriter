module Encoder

  def encode(plain)
    output = []
    [0,2,4].each do |offset|
      capitalize_letters(plain, offset, output)
      output << "\n"
    end
    output.join
  end

  def capitalize_letters(plain, offset, output)
    plain.chars.each do |letter|
      if letter == letter.upcase
        output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
        letter = letter.downcase
      end
      output << lookup(letter, offset) << lookup(letter, offset + 1)
    end
  end
end
