#!/usr/bin/env ruby

if ARGV.size != 4 then
    STDERR.write "Usage: #{$0} <input-file> <output-file> <start_addr> <size>\n"
    STDERR.write "start_addr and size are in hex"
    exit 1
end

inpfile = ARGV[0]
outfile = ARGV[1]
start = ARGV[2].to_i(16)
size = ARGV[3].to_i(16)

# Read the input file
image = nil
File.open(inpfile, "rb", encoding: 'ASCII-8BIT') do |inp|
    inp.seek(start)
    image = inp.read(size)
end
if image.nil? or image.size < size then
    raise RuntimeError, "#{inpfile}: unexpected end of file"
end

# Write as hex
begin
    File.open(outfile, "w") do |out|
        size.times do |i|
            out.write("\tdb\t") if i%8 == 0
            out.write("0%02XH%c" % [ image[i].ord, (i%8 == 7) ? "\n" : "," ])
        end
        out.write("\n") if size % 8 != 0
    end
rescue
    File.delete(outfile) if File.file?(outfile)
    raise
end
