

module Parser


  def check_eng_capitals(plain)
    output = []
    [0,2,4].each do |offset|
      plain.chars.each do |letter|
        if letter == letter.upcase
          output << lookup(:capitalize, offset) << lookup(:capitalize, offset + 1)
          letter = letter.downcase
        end
        output << lookup(letter, offset) << lookup(letter, offset + 1)
      end
      output << "\n"
    end
    output
  end

  def format_braille(n, m, as_one_line)
    output = []
    should_capitalize_next = false
    (0..(n-1)).each_slice(2) do |column_offset|

      braille_character = []
      (0..(m-1)).each do |row_offset|
        braille_character << as_one_line[(row_offset * n) + column_offset[0]]
        braille_character << as_one_line[(row_offset * n) + column_offset[1]]
      end

      decoded_braille = @alphabet.braille_letter_hash.key(braille_character.join)

      if decoded_braille == :capitalize
        should_capitalize_next = true
      elsif should_capitalize_next
        output << decoded_braille.upcase
        should_capitalize_next = false
      else
        output << decoded_braille
        should_capitalize_next = false
      end
    end
    output.join

  end

  def format_to_one_line(braille)
    lines = braille.split("\n")
    n = lines[0].length
    m = 3
    lines.join
  end

end
