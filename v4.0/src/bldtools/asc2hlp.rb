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
def pack32(num)
    b = [ nil, nil, nil, nil ]
    b[0] = num & 0xFF
    b[1] = (num >> 8) & 0xFF
    b[2] = (num >> 16) & 0xFF
    b[3] = (num >> 24) & 0xFF
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

    # Write a file header
    outfp.write(pack16(0x1234))     # Appears to be a magic number
    outfp.write(pack16(20))         # Verion number?
    outfp.write(pack32(0x00FE))     # Unknown
    outfp.write(pack16(0x00A4))     # Header size
    outfp.write(pack16(maxnumhlp))
    outfp.seek(0x00A8 + maxnumhlp*8)

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
    outfp.seek(0x00A4)
    outfp.write(pack16(maxnumhlp))
    outfp.write(pack16(topiclen))
    0.upto(helpfile.size) do |i|
        t = helpfile[i]
        if t then
            outfp.write(pack32(i+1))
            outfp.write(pack16(t.offset))
            outfp.write(pack16(t.text.size))
        end
    end
end
