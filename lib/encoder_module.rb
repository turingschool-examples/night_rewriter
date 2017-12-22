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
      letter_insert(:capitalize, offset)
      letter = letter.downcase
    end
    letter_insert(letter, offset)
  end

  def letter_insert(letter, offset)
    @output << lookup(letter, offset) << lookup(letter, offset + 1)
  end

end
