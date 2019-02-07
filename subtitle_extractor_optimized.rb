require 'pathname'
require 'open3'
require 'vips'

SRC_DIR = '/path/to/src/dir/'.freeze
TMP_DIR = '/path/to/tmp/dir/'.freeze

class TextReader
  def initialize(input_path, output_path)
    @input_path  = input_path
    @output_path = output_path
  end

  def read
    # prepare the image
    #
    # Read the image as grayscale
    img    = Vips::Image.new_from_file(@input_path, access: :sequential).colourspace('b-w')
    #
    # convert the image to binary; into black and white
    img_bw = img > 237  # that's the threshold
    img_bw.write_to_file(@output_path)

    # read the text and return it
    text, _,  _ =
      Open3.capture3("tesseract #{@output_path} stdout -l eng --oem 0 --psm 3")
    text.strip
  end
end

newly_renamed = 0
not_renamed   = 0

Dir.mkdir TMP_DIR unless File.exists?(TMP_DIR)

Pathname.new(SRC_DIR).children.each do |f|
  new_name = TextReader.new(f.realpath,
                            "#{TMP_DIR}/#{f.basename}")
    .read
    .downcase
    .gsub(/[[:punct:]]/, ' ')
    .split
    .join('-')

  # the 252 byte limit is for the ext4 file system limit of 255 bytes per filename
  # for some reason, the actual limit in Ruby's Pathname#rename is 252
  new_name = if !new_name.empty? && new_name.bytes.size < 252
               newly_renamed += 1
               new_name
             else
               not_renamed += 1
               f.basename
             end

  f.rename("#{SRC_DIR}/#{new_name}#{f.extname}")
end

puts "*" * 50
puts "#{newly_renamed} files newly renamed vs. #{not_renamed} still have the same old name."
