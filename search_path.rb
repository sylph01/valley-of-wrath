fname = "songs.txt"

open(fname) {|file|
  # create path data
  target_char = []
  for a in "A".."Z" do
    target_char << a.to_s
  end
  for a in 0 .. 9 do
    target_char << a.to_s
  end
  
  path = {}
  target_char.each do |t|
    path[t] = []
  end
  
  songdb = {}
  
  while line = file.gets
    line.chomp!
    # get string length
    len = line.length
    upper = line.upcase
    first = upper[0]
    last = upper[len - 1]
    if first =~ /[A-Z0-9]/ && last =~ /[A-Z0-9]/
      # add path
      if !path[first].include?(last)
        path[first] << last
      end
      # add song to songdb
      key = first + last
      if songdb[key] == nil
        songdb[key] = [line]
      else 
        songdb[key] << line
      end
      # puts "#{first} -> #{last}"
    end
  end
  
  # 全パス探索
  solutions = []
  
  target_char.each do |first_char|
    path[first_char].each do |second_char|
      path[second_char].each do |third_char|
        path[third_char].each do |fourth_char|
          if path[fourth_char].include?(first_char)
            solutions << [first_char, second_char, third_char, fourth_char]
          end
        end
      end
    end
  end
  
  # パス出力
  patterns = {}
  target_char.each do |ch|
    patterns[ch] = []
  end
  
  solutions.each do |sol|
    key1 = sol[0] + sol[1]
    key2 = sol[1] + sol[2]
    key3 = sol[2] + sol[3]
    key4 = sol[3] + sol[0]
    
    # flatten tree
    songdb[key1].each do |s1|
      songdb[key2].each do |s2|
        songdb[key3].each do |s3|
          songdb[key4].each do |s4|
            if [s1, s2, s3, s4].uniq.length == 4
              patterns[key1[0]] << [s1, s2, s3, s4]
            end
          end
        end
      end
    end
    
    # old version  
    # songs1 = "(" + songdb[key1].join(" / ") + ")"
    # songs2 = "(" + songdb[key2].join(" / ") + ")"
    # songs3 = "(" + songdb[key3].join(" / ") + ")"
    # songs4 = "(" + songdb[key4].join(" / ") + ")"
    # puts songs1 + " -> " + songs2 + " -> " + songs3 + " -> " + songs4
  end
  
  # print
  target_char.each do |ch|
    f = File.open(ch.to_s + ".txt","w")
    f.puts "**#{ch}**"
    patterns[ch].each do |ptn|
      f.puts ptn.join(" -> ")
    end
  end
}