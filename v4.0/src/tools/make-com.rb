#!/usr/bin/env ruby

if ARGV.size != 2 then
    STDERR.write("Usage: #{$0} <exe-file> <com-file>\n")
    exit 1
end

inp_file = ARGV[0]
out_file = ARGV[1]

# Check the tail code and update if needed
my_dir = File.dirname($0)
tail_src = File.join(my_dir, "com-tail.asm")
tail_bin = File.join(my_dir, "com-tail.bin")
if !File.file?(tail_bin) || (File.mtime(tail_bin) < File.mtime(tail_src)) then
    tail_obj = File.join(my_dir, "com-tail.obj")
    system("jwasm -q -Fo#{tail_obj} #{tail_src}")
    exit $? if $? != 0
    system("wlink option quiet format raw bin name #{tail_bin} file #{tail_obj}")
end

# Read the input file
inp_text = File.read(inp_file, 65536, mode: "rb")

# Read the tail code
tail = File.read(tail_bin, mode: "rb")
# Skip over the uninitialized data at the start
i = 0
i += 1 while (i < tail.size and tail[i].ord == 0)
tail = tail[i+1..]

# Build the head
displacement = inp_text.size + 13 + 8
head = ([ 0xE9, displacement & 0xFF, (displacement >> 8) & 0xFF ].map {|x| x.chr('ASCII-8BIT')}).join('') \
    + "Converted\0\0\0\0"
head.force_encoding('ASCII-8BIT')

# Build the complete output
out_text = head + inp_text + tail
# Set a maximum output size, allowing a bit for the stack
if out_text.size > 0xFE00 then
    STDERR.write("#{$0}: #{inp_file} is too large\n")
    exit 1
end

File.write(out_file, out_text, mode: "wb")
