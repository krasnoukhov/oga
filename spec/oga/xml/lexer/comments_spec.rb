require 'spec_helper'

describe Oga::XML::Lexer do
  context 'comments' do
    example 'lex a comment' do
      lex('<!-- foo -->').should == [[:T_COMMENT, ' foo ', 1]]
    end

    example 'lex a comment containing --' do
      lex('<!-- -- -->').should == [[:T_COMMENT, ' -- ', 1]]
    end

    example 'lex a comment containing ->' do
      lex('<!-- -> -->').should == [[:T_COMMENT, ' -> ', 1]]
    end

    example 'lex a comment followed by text' do
      lex('<!---->foo').should == [
        [:T_COMMENT, '', 1],
        [:T_TEXT, 'foo', 1]
      ]
    end

    example 'lex text followed by a comment' do
      lex('foo<!---->').should == [
        [:T_TEXT, 'foo', 1],
        [:T_COMMENT, '', 1]
      ]
    end

    example 'lex an element followed by a comment' do
      lex('<p></p><!---->').should == [
        [:T_ELEM_START, nil, 1],
        [:T_ELEM_NAME, 'p', 1],
        [:T_ELEM_END, nil, 1],
        [:T_COMMENT, '', 1]
      ]
    end

    example 'lex two comments following each other' do
      lex('<a><!--foo--><b><!--bar--></b></a>').should == [
        [:T_ELEM_START, nil, 1],
        [:T_ELEM_NAME, 'a', 1],
        [:T_COMMENT, 'foo', 1],
        [:T_ELEM_START, nil, 1],
        [:T_ELEM_NAME, 'b', 1],
        [:T_COMMENT, 'bar', 1],
        [:T_ELEM_END, nil, 1],
        [:T_ELEM_END, nil, 1]
      ]
    end
  end
end
