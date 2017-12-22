module Encoder_Helpers

  def offset_iterator(plain)
    @offsets.map { |offset|
      letter_iterator(plain, offset)
      @output << "\n"
    }
  end

  def letter_iterator(plain, offset)
    plain.chars.map { |letter| check_letter(letter, offset) }
  end

  def check_letter(letter, offset)
    if letter == letter.upcase
      @output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
      letter = letter.downcase
    end
    @output << lookup(letter, offset) << lookup(letter, offset + 1)
  end

end
