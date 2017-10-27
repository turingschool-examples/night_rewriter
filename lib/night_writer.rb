require_relative 'braille_reader'
require_relative 'braille_writer'
require_relative 'file_reader'

class NightWriter
  attr_reader :file

  def initialize
    @file = FileReader.new
  end

  def encode_from_braille(input_file, output_file) # take braille.txt ARGV[0] and parse into message.txt ARGV[1]
    # open exisiting braille file and save text to variable
    text = @file.read(input_file)
    # parse it thru translator method to turn it to english
    braille = parse_from_braille(text)
    # write a new file
    file_in_english = @file.write(braille, output_file) # arguments are text and file to write to
  end

  def parse_from_braille(text)
    BrailleReader.new.encode_from_braille(text)
  end

  def encode_to_braille(input_file, output_file)
    read_to_translate = @file.read(input_file)
    english = parse_to_english(text)
    file_in_braille = @file_writer.write(output_file, english)
  end

  def parse_to_english(text)
    BrailleWriter.new.encode_to_braille(text)
  end
end
