require 'pry'
require_relative 'encoder'
require_relative 'decoder'
require_relative 'lookup'

class NightWriter
  include Lookup

  def initialize
    @encoder = Encoder.new
    @decoder = Decoder.new
  end

  def encode_to_braille(plain)
    @encoder.encode_to_braille(plain)
  end

  def encode_from_braille(braille)
    @decoder.from_braille(braille)
  end
end

