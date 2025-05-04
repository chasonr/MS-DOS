#!/usr/bin/env ruby

# This program builds the .cl? and .ctl files for national language support.
# It replaces the programs NOSRVBLD.EXE and BUILDMSG.EXE. It does not quite
# replace BUILDIDX.EXE, because MENUBLD.EXE still needs the index.
#
# The resulting files differ only in a bit of whitespace from those created
# by the Microsoft tools. There may be some other inputs that produce
# different output; this program is accurate enough to build the existing
# MS-DOS source.

if ARGV.size != 2 then
    STDERR.puts "Usage: #{$0} <message-file> <skeleton-file>"
    exit 1
end

message_path = ARGV[0]  # e.g. messages/usa-ms.msg
skeleton_path = ARGV[1] # e.g. cmd/command/command.skl

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

# Join whitespace entries in a token array
def join_spaces(tokens)
    tokens2 = []
    tokens.each do |t|
        if t =~ /^\s*$/ and not tokens2.empty? and tokens2[-1] =~ /^\s*$/ then
            tokens2[-1] += t
        else
            tokens2.push(t)
        end
    end
    tokens2
end

# Parse the skeleton file
def read_skeleton(path)

    parsed_line = nil

    File.foreach(path, encoding: 'ASCII-8BIT') do |line|
        tokens = split_line(line)

        # Find first non-blank token
        first = 0
        first += 1 while (first < tokens.size and tokens[first] =~ /^\s*$/)

        if first >= tokens.size then
            # Empty line ends a logical line
            yield join_spaces(parsed_line) if parsed_line
            parsed_line = nil
        elsif tokens[first] == ':' then
            # Colon begins a new logical line
            yield join_spaces(parsed_line) if parsed_line
            parsed_line = tokens[first..-1]
        else
            # Anything else continues a logical line
            if parsed_line then
                parsed_line.push(*tokens)
            else
                raise RuntimeError, "#{path}: Continuation without start of line"
            end
        end
    end
    # Pass any parsed line at the end
    yield join_spaces(parsed_line) if parsed_line
end

# For parsed line from the skeleton file, get the directive type
def get_directive(line)
    # Pass the colon
    if line[0] != ':' then
        # This shouldn't happen
        raise RuntimeError, "#{path}: Invalid directive"
    end
    i = 1

    # Find the directive
    if i < line.size and line[i] =~ /^\s*$/ then
        i += 1
    end
    if i >= line.size then
        raise RuntimeError, "#{path}: Empty directive"
    end
    dir = line[i]

    i += 1
    if i < line.size and line[i] =~ /^\s*$/ then
        i += 1
    end

    return [dir.downcase, line[i..-1]]
end

# Drop whitespace from parameter list
def drop_spaces(params)
    params.delete_if {|x| x =~ /^\s*$/}
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
            text = tokens[6..-1].join('')
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
        messages[util][lastindex] += "\r\n" + tokens.join('')
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

# Structure describing a message
class Message
    attr_accessor :index    
    attr_accessor :symbol
    attr_accessor :text
end

# Read the skeleton file
msgclass = nil
util = nil
next_msg = 1
name = File.basename(skeleton_path, ".*").downcase

skeleton = {}

read_skeleton(skeleton_path) do |line|
    dir, params = get_directive(line)
    case dir
    when "util" then
        # Will generate .cl? files and a .ctl file if this directive is present
        drop_spaces(params)
        if params.size != 1 then
            raise RuntimeError, "#{skeleton_path}: :util directive takes one parameter"
        end
        util = params[0].downcase
        next_msg = 1

    when "class" then
        # Message class to look up in the index
        drop_spaces(params)
        if params.size != 1 then
            raise RuntimeError, "#{skeleton_path}: :class directive takes one parameter"
        end
        msgclass = params[0].downcase
        next_msg = 1

    when "use" then
        # Retrieve a string from the index
        if msgclass.nil? then
            raise RuntimeError, "#{skeleton_path}: Need a :class directive before :use"
        end
        drop_spaces(params)
        case params.size
        when 1 then
            # One parameter: a symbol such as EXTEND15. This will look up
            # string 15 in the EXTEND section, and index it as string 15.
            if util.nil? then
                raise RuntimeError, "#{skeleton_path}: Need a :util directive or three parameters in :use"
            end
            if params[0] =~ /[0-9]+$/ then
                symbol = $`
                index = $&.to_i
            else
                symbol = params[0]
                index = -1
            end
            symbol = symbol.downcase
            text = nil
            if messages[symbol] then
                text = messages[symbol][index]
            end
            if text.nil? and messages['common'] then
                text = messages['common'][index]
            end
            if text.nil? then
                text = %q["???"]
            end
            msg = Message.new
            msg.index = index & 0xFFFF
            msg.symbol = symbol
            msg.text = text.rstrip
            skeleton[msgclass] ||= []
            skeleton[msgclass] << msg

        when 2 then
            # Two parameters: e.g. :use 24 EXTEND2. This will look up
            # string 2 in the EXTEND section, and index it as string 24.
            if util.nil? then
                raise RuntimeError, "#{skeleton_path}: Need a :util directive or three parameters in :use"
            end
            index1 = params[0].to_i
            if params[1] =~ /[0-9]+$/ then
                symbol = $`
                index2 = $&.to_i
            else
                symbol = params[1]
                index2 = index1
            end
            symbol = symbol.downcase
            text = nil
            if messages[symbol] then
                text = messages[symbol][index2]
                if text and (symbol == 'extend' or symbol == 'parse') and (text !~ /\bCR\s*,\s*LF\s*$/) then
                    text += ",CR,LF"
                end
            end
            if text.nil? and messages['common'] then
                text = messages['common'][index2]
            end
            if text.nil? then
                case params[1].downcase
                when "extend999" then
                    text = %q["Extended Error %1",CR,LF]
                when "parse999" then
                    text = %q["Parse Error %1",CR,LF]
                else
                    text = %q["???"]
                end
            end
            msg = Message.new
            msg.index = index1 & 0xFFFF
            msg.symbol = symbol
            msg.text = text.rstrip
            skeleton[msgclass] ||= []
            skeleton[msgclass] << msg

        when 3 then
            # Three parameters: e.g. :use OO1 BOOT SYSMSG. This will look up
            # string 1 in the BOOT section, and output the symbol SYSMSG to
            # the .cl? file.
            index = params[0].to_i
            name2 = params[1].downcase
            symbol = params[2]
            text = nil
            if messages[name2] then
                text = messages[name2][index]
            end
            if text.nil? and messages['common'] then
                text = messages['common'][index]
            end
            if text then
                text2 = text.split(/\r\n/)
                text2.size.times {|i| text2[i] = "\tDB    " + text2[i]}
                text = text2.join("\n")
            else
                text = 'DB "???"'
            end
            msg = Message.new
            msg.index = index
            msg.symbol = symbol
            msg.text = text
            skeleton[msgclass] ||= []
            skeleton[msgclass] << msg

        else
            raise RuntimeError, "#{skeleton_path}: :use directive takes one to three parameters"
        end

    when "def" then
        # Retrieve a string from the index, or use a string provided here
        # if the index does not have the string
        if msgclass.nil? then
            raise RuntimeError, "#{skeleton_path}: Need a :class directive before :def"
        end
        index = params[0].to_i
        text = nil
        if util then
            if messages[util] then
                text = messages[util][index]
            end
            if text.nil? and messages['common'] then
                text = messages['common'][index]
            end
            if text.nil? then
                text = params[1..-1].join('')
            end
            symbol = nil
        else
            symbol = params[2]
            if messages[name] then
                text = messages[name][index]
            end
            if text.nil? and messages['common'] then
                text = messages['common'][index]
            end
            if text then
                text2 = text.split(/\r\n/)
                text2.size.times {|i| text2[i] = "\tDB    " + text2[i]}
                text = text2.join("\n")
            else
                text = params[4..-1].join('')
            end
        end
        msg = Message.new
        msg.index = index & 0xFFFF
        msg.symbol = symbol
        msg.text = text.strip
        skeleton[msgclass] ||= []
        skeleton[msgclass] << msg

    when "end" then
        # End the skeleton file
        drop_spaces(params)
        if not params.empty? then
            raise RuntimeError, "#{skeleton_path}: :end directive takes no parameters"
        end
        break

    else
        raise RuntimeError, "#{skeleton_path}: Unknown directive #{dir}"
    end
end

if util then

    # Classes 1 and 2 are always present, but are empty if not specified
    skeleton["1"] ||= []
    skeleton["2"] ||= []

    # Template for a .cl? file
    cl_template = [
        %q[],
        %q[; ----------------------------------------------------------],
        %q[],
        %q[        PUBLIC  %{pubname}],
        %q[        IF1],
        %q[        %%out    ... Including message Class %{msgclass}],
        %q[        ENDIF],
        %q[],
        %q[; ----------------------------------------------------------],
        %q[],
        %q[$M_CLASS_%{msgclass}_STRUC LABEL BYTE],
        %q[        $M_CLASS_ID <%{class_id},EXPECTED_VERSION,Class_%{msgclass}_MessageCount>],
        %q[],
        %q[; ----------------------------------------------------------],
        %q[],
        %q[],
        :section_3,
        :section_4,
        %q[; ----------------------------------------------------------],
        %q[],
        %q[],
        :section_5,
        :section_6,
        %q[; ----------------------------------------------------------],
        %q[],
        %q[Class_%{msgclass}_MessageCount EQU     %{num_msgs}],
        %q[],
        %q[; ----------------------------------------------------------],
        %q[],
        %q[        IF      FARmsg],
        %q[%{pubname} PROC FAR],
        %q[        ELSE],
        %q[%{pubname} PROC NEAR],
        %q[        ENDIF],
        %q[],
        %q[        PUSH    CS],
        %q[        POP     ES],
        %q[        LEA     DI,$M_CLASS_%{msgclass}_STRUC],
        %q[        ADD     CX,$-$M_CLASS_%{msgclass}_STRUC],
        %q[        RET],
        %q[],
        %q[%{pubname} %{endp}],
        %q[],
        %q[; ----------------------------------------------------------],
        %q[]
    ];

    # Each pass through the outer loop creates one .cl? file
    count = 0
    skeleton.keys.sort.each do |msgclass|
        msglist = skeleton[msgclass]
        params = {
            :msgclass => msgclass.upcase,
            :num_msgs => msglist.size
        }
        num_msgs = msglist.size
        if msgclass == "1" or msgclass == "2" then
            # Message classes 1 and 2 are special
            params[:pubname] = '$M_MSGSERV_%s' % msgclass
            params[:num_msgs] += 1
            params[:class_id] = "00%sH" % msgclass
            params[:error] = (msgclass == "2") ? "Parse Error" : "Extended Error"
            params[:endp] = "Endp"
        else
            count += 1
            params[:pubname] = '$M_CLS_%u' % count
            params[:class_id] = "0FFH"
            params[:endp] = "ENDP"
        end
        File.open(name.downcase + (".cl%s" % msgclass), "w", encoding: "ASCII-8BIT") do |fp|

            # Fill in the template
            cl_template.each do |line|
                case line
                when :section_3 then
                    msglist.each do |msg|
                        params[:index] = "%04X" % (msg.index & 0xFFFF)
                        fp.write("$M_%{msgclass}_0%{index}H_STRUC LABEL BYTE\n" % params)
                        fp.write("        $M_ID   <0%{index}H,$M_%{msgclass}_0%{index}H_MSG-$M_%{msgclass}_0%{index}H_STRUC>\n" % params)
                        fp.write("\n")
                    end
                when :section_4 then
                    if msgclass == "1" or msgclass == "2" then
                        [ %q[; ----------------------------------------------------------],
                          %q[],
                          %q[$M_%{msgclass}_FF_STRUC LABEL BYTE],
                          %q[        $M_ID <0FFFFH,$M_%{msgclass}_FF_MSG-$M_%{msgclass}_FF_STRUC>],
                          %q[] ].each do |line2|
                            fp.write(line2 % params)
                            fp.write("\n")
                        end
                    end
                when :section_5 then
                    msglist.each do |msg|
                        params[:index] = "%04X" % (msg.index & 0xFFFF)
                        fp.write(%Q[$M_%{msgclass}_0%{index}H_MSG LABEL BYTE\n] % params)
                        fp.write(%Q[        DB      $M_%{msgclass}_0%{index}H_END-$M_%{msgclass}_0%{index}H_MSG-1\n] % params)
                        if msg.text !~ /^"",?$/ then
                            msg.text.split(/\r?\n/).each do |line3|
                                params[:text] = line3
                                fp.write(%Q[        DB      %{text}\n] % params)
                            end
                        end
                        fp.write(%Q[$M_%{msgclass}_0%{index}H_END LABEL BYTE\n] % params)
                        fp.write(%Q[  \n])
                    end
                when :section_6 then
                    if msgclass == "1" or msgclass == "2" then
                        [ %q[; ----------------------------------------------------------],
                          %q[],
                          %q[$M_%{msgclass}_FF_MSG LABEL BYTE],
                          %q[        DB      $M_%{msgclass}_FF_END-$M_%{msgclass}_FF_MSG-1],
                          %q[        DB      "%{error} %%1"],
                          %q[$M_%{msgclass}_FF_END LABEL BYTE],
                          %q[  ] ] \
                        .each do |line2|
                            fp.write(line2 % params)
                            fp.write("\n")
                        end
                    end
                else
                    fp.write(line % params)
                    fp.write("\n")
                end
            end
        end
    end
    File.open(name.downcase + ".ctl", "w", encoding: "ASCII-8BIT") do |fp|
        fp.write("$M_NUM_CLS  EQU %d\n" % count)
    end

else

    # .cl? files where :util is not specified
    skeleton.each do |msgclass, msglist|
        File.open(name.downcase + (".cl%s" % msgclass), "w", encoding: "ASCII-8BIT") do |fp|
            fp.write("; %s.cl%s \n" % [name.upcase, msgclass])
            fp.write("\n")
            msglist.each do |message|
                fp.write("\n")
                fp.write(";_______________________\n")
                fp.write("\n%s %s\n" % [message.symbol, message.text])
            end
        end
    end

end
