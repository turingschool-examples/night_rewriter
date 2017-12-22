require_relative 'alphabet'
require 'pry'

module Lookup
  def self.lookup(character, position)
    alphabet = Alphabet.new
    alphabet.braille_letter_hash[character].chars[position]
  end
end
