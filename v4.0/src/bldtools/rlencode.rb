#!/usr/bin/env ruby

# Run-length encoder for SELECT's panel display function
# Replaces the COMPRESS.COM program

if ARGV.size != 2 then
    STDERR.puts "Usage: #{$0} <input-file> <output-file>"
    exit 1
end

inp_path = ARGV[0]
out_path = ARGV[1]

# Read the entire input
inp_text = File.read(inp_path, mode: 'rb', encoding: 'ASCII-8BIT')

# Build the compressed output
File.open(out_path, 'wb', encoding: 'ASCII-8BIT') do |out_fp|
    i = 0
    while i < inp_text.size do
        # Determine the end of the current run
        j = i + 1
        j += 1 while (j < inp_text.size and j < i+254 and inp_text[j] == inp_text[i])

        # Do not allow runs of length 2 (too short), 0x0D (CR) or 0x1A (CTRL-Z)
        rlen = j - i
        if rlen == 2 or rlen == 0x0D or rlen == 0x1A then
            rlen -= 1
        end

        # Write a run marker if needed
        if rlen != 1 then
            out_fp.write("\xFF")
            out_fp.write(rlen.chr('ASCII-8BIT'))
        end

        # Write the output byte; escape CR, CTRL-Z and 0xFF
        case inp_text[i].ord
        when 0x0D then
            out_fp.write("\xFF\x01")
        when 0x1A then
            out_fp.write("\xFF\x02")
        when 0xFF then
            out_fp.write("\xFF\xFF")
        else
            out_fp.write(inp_text[i])
        end

        i += rlen
    end
end
