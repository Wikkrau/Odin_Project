module FileSystem
  def format(file)
    words = []
    fname = file

    File.readlines(fname).each do |line|
      str_format = line.split("\n").join(', ')
      words.push(str_format)
    end

    words
  end
end
