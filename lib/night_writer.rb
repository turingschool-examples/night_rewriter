require_relative 'translate_to_braille'
require_relative 'translate_from_braille'

class NightWriter

  def initialize
    @braille_encoder = TranslateToBraille.new
    @braille_decoder = TranslateFromBraille.new
  end

  def encode_to_braille(plain)
    @braille_encoder.translate(plain)
  end

  def encode_from_braille(braille)
    @braille_decoder.translate(braille)
  end

end
