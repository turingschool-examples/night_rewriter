module Lookup

  def lookup(character, position)
    @alphabet.braille_letter_hash[character].chars[position]
  end

end
