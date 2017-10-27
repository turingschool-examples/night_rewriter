class FileReader

  def read(file)
    File.read(ARGV[0])
  end

  def write(filename, text)
    File.write(ARGV[1], text)
  end
end
