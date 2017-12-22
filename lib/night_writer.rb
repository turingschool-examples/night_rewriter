require 'pry'
require_relative 'converter'
require_relative 'lookup'

class NightWriter
  include Lookup
  attr_reader :converter

  def initialize
    @converter = Converter.new
  end

  def encode_to_braille(plain)
    @converter.encode_to_braille(plain)
  end

  def encode_from_braille(braille)
    @converter.from_braille(braille)
  end
end

