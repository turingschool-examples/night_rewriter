require_relative 'alphabet'
require_relative 'lookup_module'
require_relative 'Decoder_module'
class Decoder

  include Lookup
  include Decoder_Helpers

  def initialize
    @alphabet = Alphabet.new
    @output = []
    @lines = []
    @should_capitalize_next = false
  end

  def encode_from_braille(braille)
    @lines = braille.split("\n")
    n = @lines[0].length
    column_iterator(n)
    @output.join
  end

end
