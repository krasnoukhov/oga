require 'spec_helper'

describe Oga::CSS::Lexer do
  context 'namespaces' do
    example 'lex a path containing a namespace name' do
      lex_css('foo|bar').should == [
        [:T_IDENT, 'foo'],
        [:T_PIPE, nil],
        [:T_IDENT, 'bar']
      ]
    end

    example 'lex a path containing a namespace wildcard' do
      lex_css('*|foo').should == [
        [:T_IDENT, '*'],
        [:T_PIPE, nil],
        [:T_IDENT, 'foo']
      ]
    end
  end
end
