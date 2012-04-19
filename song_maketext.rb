fname = "iidxacsongs_orig.txt"

open(fname) {|file|
  while line = file.gets
    puts line.scan(/(.*?)\t.*/)[0]
  end
}