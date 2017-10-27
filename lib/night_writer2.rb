
require_relative 'convert_from_braille'
require_relative 'convert_to_braille'

class NightWriter2
  def initialize
    @toBraille = ConvertToBraille
    @fromBraille = ConvertFromBraille
  end

  def convert_to_braille(word)
    @toBraille.convert(word)
  end

  def covert_from_braille(word)
    @fromBraille.covert(word)
  end
end


