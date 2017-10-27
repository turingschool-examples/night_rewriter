
require_relative 'convert_from_braille'
require_relative 'convert_to_braille'

class NightWriter2
  def initialize
    @ToBraille = ConvertToBraille
    @FromBraille = ConvertFromBraille
  end
end


