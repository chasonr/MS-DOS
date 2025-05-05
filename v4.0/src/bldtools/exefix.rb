#!/usr/bin/env ruby

if ARGV.size != 3 then
    STDERR.puts "Usage: #{$0} <file> <max-alloc> <min-alloc>"
    exit 1
end

exe_path = ARGV[0]
max_alloc = ARGV[1].to_i(16)
min_alloc = ARGV[1].to_i(16)

# Pack a 16 bit integer into bytes
def pack16(num)
    b = [ nil, nil ]
    b[0] = num & 0xFF
    b[1] = (num >> 8) & 0xFF
    (b.map {|c| c.chr('ASCII-8BIT')}).join('')
end

# Unpack a 16 bit integer from bytes
def unpack16(bytes)
    case bytes.size
    when 0 then
        0
    when 1 then
        bytes[0].ord
    else
        bytes[0].ord | (bytes[1].ord << 8)
    end
end

File.open(exe_path, "r+b", encoding: 'ASCII-8BIT') do |exefp|

    # Check EXE signature
    sig = exefp.read(2)
    if sig != 'MZ' then
        STDERR.puts "#{exe_path} is not an EXE file"
        exit 1
    end

    # Set minimum and maximum allocations
    exefp.seek(0x0A)
    exefp.write(pack16(min_alloc))
    exefp.write(pack16(max_alloc))

    # Reset the checksum
    exefp.seek(0)
    sum = 0
    9.times do |i|
        word = exefp.read(2)
        break if word.nil?
        sum += unpack16(word)
    end
    exefp.seek(0x14)
    while true
        word = exefp.read(2)
        break if word.nil?
        sum += unpack16(word)
    end
    exefp.seek(0x12)
    exefp.write(pack16((0x10000-sum) & 0xFFFF))

end
