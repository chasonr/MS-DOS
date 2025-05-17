#!/usr/bin/env ruby

if ARGV.size != 2 then
    STDERR.puts "Usage: #{$0} <input-file> <output-file>"
    exit 1
end

inp_path = ARGV[0] # e.g. usa.txt
out_path = ARGV[1] # e.g. select.hlp

# Structure for one help entry
class HelpTopic
    attr_accessor :topic
    attr_accessor :text
    attr_accessor :offset
end

# Pack a 16 bit integer into bytes
def pack16(num)
    b = [ nil, nil ]
    b[0] = num & 0xFF
    b[1] = (num >> 8) & 0xFF
    (b.map {|c| c.chr('ASCII-8BIT')}).join('')
end

# Pack a 32 bit integer into bytes
# The peculiar endian order is correct: the high word comes first
def pack32(num)
    b = [ nil, nil, nil, nil ]
    b[0] = (num >> 16) & 0xFF
    b[1] = (num >> 24) & 0xFF
    b[2] = (num >>  0) & 0xFF
    b[3] = (num >>  8) & 0xFF
    (b.map {|c| c.chr('ASCII-8BIT')}).join('')
end

# Read the help file
helpfile = []
helpid = nil
helptopic = nil
topiclen = nil
maxnumhlp = nil
File.foreach(inp_path, encoding: 'ASCII-8BIT') do |line|
    line.chomp!

    if helptopic.nil? or helptopic.text.nil? then
        # .HELPTEXT. is not in effect
        if line =~ /^\s*\.topiclen\./i then
            topiclen = $'.to_i
        elsif line =~ /^\s*\.maxnumhlp\./i then
            maxnumhlp = $'.to_i
        elsif line =~ /^\s*\.helpid\./i then
            helpid = $'.to_i
        elsif line =~ /^\s*\.topictext\./i then
            helptopic = HelpTopic.new
            helpfile[helpid-1] = helptopic
            helptopic.topic = $'.strip
        elsif line =~ /^\s*\.helptext\.\s/i then
            helptopic.text = $' + ' '
        end
        # Other lines are considered comments when .HELPTEXT. is not in effect
    else
        if line =~ /^\s*.helptend./i then
            helpid = nil
            helptopic = nil
        else
            helptopic.text += line + ' '
        end
    end
end

# Ensure that a topic length exists
if topiclen.nil? then
    topiclen = 0
    helpfile.each do |t|
        next if t.nil?
        len = t.topic.size
        topiclen = len if topiclen < len
    end
end

if maxnumhlp.nil? or maxnumhlp+1 < helpfile.size then
    maxnumhlp = helpfile.size - 1
    puts "maxnumhlp = #{maxnumhlp}"
end

pad = ' ' * topiclen

# Write the output file
File.open(out_path, 'wb', encoding: 'ASCII-8BIT') do |outfp|

    # Original ASC2HLP sets this to 20. Only 1 is actually written.
    num_objs = 20
    help_offset = num_objs*8 + 4

    # Write a file header
    outfp.write(pack16(0x1234))         # Magic number
    outfp.write(pack16(num_objs))       # Number of objects
    outfp.write(pack16(0x00FE))         # Indicates a help object
    outfp.write(pack32(help_offset))    # Where to find topics
    outfp.write(pack16(maxnumhlp))      # Number of topics
    outfp.seek(help_offset + 4 + maxnumhlp*8)

    # Write the topic strings
    helpfile.each do |t|
        outfp.write((t.topic + pad)[0...topiclen]) if t
    end

    # Write the text panels
    helpfile.each do |t|
        if t then
            t.offset = outfp.tell
            outfp.write(t.text)
        end
    end

    # Write the index array
    outfp.seek(help_offset)
    outfp.write(pack16(maxnumhlp))
    outfp.write(pack16(topiclen))
    0.upto(maxnumhlp-1) do |i|
        t = helpfile[i]
        if t then
            outfp.write(pack16(i+1))
            outfp.write(pack32(t.offset))
            outfp.write(pack16(t.text.size))
        else
            outfp.write(pack16(0))
            outfp.write(pack32(0))
            outfp.write(pack16(0))
        end
    end
end
