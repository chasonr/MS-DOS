#!/usr/bin/env ruby

# Perform substitutions from the message file for C or assembly source code.
# A substitutable string is indicated by an E8 byte followed by four digits.
# The digits index a message in the message file which is substituted into
# the source code.

if ARGV.size != 3 then
    STDERR.puts "Usage: #{$0} <input-file> <message-file> <output-file>"
    exit 1
end

inp_path     = ARGV[0] # e.g. fdisk.msg
message_path = ARGV[1] # e.g. usa-ms.msg
out_path     = ARGV[2] # e.g. fdisk.c

# Split an input line into tokens
# Quoted strings are kept whole, so that comments can be ignored without
# breaking quoted strings
def split_line(line)
    # Match: quoted strings, whitespace, numbers, identifiers,
    # single characters
    tokens = line.scan(/".*?"|'.*?'|\s+|[-+]?[0-9A-Za-z_][0-9A-Za-z_:]*|./)
    # Delete comments
    comment = tokens.find_index(';')
    tokens = tokens[0...comment] if comment

    tokens
end

# Read the message file
messages = {}
util = nil
lastindex = nil
File.foreach(message_path, encoding: 'ASCII-8BIT') do |line|
    line.rstrip!
    tokens = split_line(line)
    if tokens[0] =~ /^[0-9]+$/ then
        if tokens.size == 1 then
            # Serial number at beginning; ignore this
        elsif tokens.size >= 7 then
            # Message specification
            if util.nil? then
                raise RuntimeError, "#{message_path}: Message without utility line"
            end
            lastindex = tokens[0].to_i
            # tokens[1] is whitespace
            # tokens[2] is "U"; the meaning of this is unknown
            # tokens[3] is whitespace
            # tokens[4] is a number; the meaning of this is unknown
            # tokens[5] is whitespace
            # the rest are the message text
            text = tokens[6..-1]
            messages[util] ||= []
            messages[util][lastindex] = text
        else
            raise RuntimeError, "#{message_path}: Invalid line \"#{line}\""
        end
    elsif tokens[0] =~ /^\s+$/ then
        # Continuation line
        if lastindex.nil? then
            raise RuntimeError, "#{message_path}: Invalid continuation line \"#{line}\""
        end
        messages[util][lastindex] += tokens
    elsif tokens.size >= 5 then
        # tokens[0] is the utility
        # tokens[1] is whitespace
        # tokens[2] is a number of unknown meaning
        # tokens[3] is whitespace
        # tokens[4] is the number of messages; ignore this
        util = tokens[0].downcase
        lastindex = nil
    else
        raise RuntimeError, "#{message_path}: Invalid line \"#{line}\""
    end
end

# This is the name from the message file that we will use
name = File.basename(inp_path, ".*").downcase

# Read the input text
text = File.read(inp_path, mode: 'rb', encoding: "ASCII-8BIT")

# Perform substitutions
# Can't use a Regexp literal, because the encoding must be ASCII-8BIT
rx = Regexp.new(String.new("\xE8([[:digit:]]{1,4})", encoding: 'ASCII-8BIT'))
text.gsub!(rx) do |match|

    # Retrieve the substitution
    index = match[1..-1].to_i
    sub = nil
    if messages[name] then
        sub = messages[name][index]
    end
    if sub.nil? and messages['common'] then
        sub = messages['common'][index]
    end

    # Form it into plain text
    if sub then
        sub = sub.map do |token|

            case token
            when /^"(.*)"$/ then
                # Single quoted string
                $1

            when /^'(.*)'$/ then
                # Double quoted string
                $1

            when /^\s*$/ then
                # Whitespace; ignore
                ''

            when "," then
                # Comma as separator; ignore
                ''

            when /^[-+]?[0-9]+$/ then
                # Decimal number
                token.to_i(10).chr('ASCII-8BIT')

            when /^([-+]?[0-9a-f]+)h/i then
                # Hex number
                $1.to_i(16).chr('ASCII-8BIT')

            when /^cr$/i then
                # CR
                "\r"

            when /^lf$/i then
                # LF
                "\n"

            else
                raise RuntimeError, "Substitution #{name}, #{index}: cannot parse token #{token}"
            end

        end
        sub = sub.join('')
    end

    sub || match
end

# Write the substituted text
File.write(out_path, text, mode: 'wb', encoding: 'ASCII-8BIT')
