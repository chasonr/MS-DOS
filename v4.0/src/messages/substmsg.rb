#!/usr/bin/env ruby

if ARGV.size != 3 then
    STDERR.write("Usage: #{$0} <input-file> <output-file> <catalog>\n")
    exit 1
end

inp_path = ARGV[0]
out_path = ARGV[1]
catalog  = ARGV[2]

def line_lexer(line)
    matcher = /
        [A-Za-z0-9_]+ |         # Numbers and identifiers
        '(?:[^'\\]|\\.)*' |     # Single-quoted strings
        "(?:[^"\\]|\\.)*" |     # Double-quoted strings
        ;.* |                   # Comments
        \s+ |                   # Whitespace
        .                       # Everything else
    /x

    line.scan(matcher)
end

def subst_line(tokens)

    tokens2 = []

    i = 0
    while i < tokens.size do
        j = i
        string = catch(:done) {
            # _
            throw :done, nil unless tokens[j] == '_'
            j += 1

            # possible whitespace
            throw :done, nil if j >= tokens.size
            j += 1 if tokens[j] =~ /^\s+$/

            # (
            throw :done, nil if j >= tokens.size
            throw :done, nil unless tokens[j] == '('
            j += 1

            # possible whitespace
            throw :done, nil if j >= tokens.size
            j += 1 if tokens[j] =~ /^\s+$/

            # quoted string
            throw :done, nil if j >= tokens.size
            throw :done, nil unless tokens[j] =~ /^(?:".*"|'.*')$/
            str = tokens[j]
            j += 1

            # possible whitespace
            throw :done, nil if j >= tokens.size
            j += 1 if tokens[j] =~ /^\s+$/

            # )
            throw :done, nil if j >= tokens.size
            throw :done, nil unless tokens[j] == ')'

            str
        }
        if string then
            i = j
            # TODO: use the catalog to substitute the string
            tokens2 << string
        else
            tokens2 << tokens[i]
        end
        i += 1
    end

    tokens2
end

File.open(out_path, "w", encoding: 'ASCII-8BIT') do |out_file|

    File.foreach(inp_path, encoding: 'ASCII-8BIT') do |line|
        line.chomp!

        tokens = line_lexer(line)
        tokens = subst_line(tokens)
        line2 = tokens.join('')
        puts line2
    end

end
