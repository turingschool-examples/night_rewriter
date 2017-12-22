require_relative 'alphabet'
require_relative 'encoder'
require_relative 'decoder'
require_relative 'lookup_module'

class NightWriter

  attr_reader :encoder, :decoder

  include Lookup

  def initialize
    @alphabet = Alphabet.new
    @encoder = Encoder.new
    @decoder = Decoder.new
  end

end
