require_relative 'alphabet'
require_relative 'lookup_module'
require_relative 'encoder_module'

class Encoder

  include Lookup
  include Encoder_Helpers

  def initialize
    @alphabet = Alphabet.new
    @output =[]
    @offsets = [0,2,4]
  end

  def encode_to_braille(plain)
    offset_iterator(plain)
    @output.join
  end

end
