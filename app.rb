require 'lexeme'

lexer = Lexeme.define do
  token :EQ       => /^=$/
  token :PLUS     => /^\+$/
  token :MINUS    => /^\-$/
  token :MULTI    => /^\*$/
  token :DIV      => /^\/$/
  token :NUMBER   => /^\d+\.?\d?$/
  token :RESERVED => /^(fin|print|func|عرف|)$/
  token :STRING   => /^".*"$/
  token :ID       => /^[\w_"]+$/
  token :AR_RESERVED => /^([\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc])*$/
  token :AR_STRING   => /^"[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]*"$/
end

tokens = lexer.analyze do
  from_file 'test-codes/arabic_code.src'
end

tokens.each_with_index do |t, index|
  # puts "#{t.line} => #{t.name}: #{t.value}"
  if t.name.to_s == "AR_RESERVED"
    if tokens[index+1].name.to_s == "AR_STRING"
      to_print = tokens[index+1].value
      puts to_print
    end
  end
end
