require 'spec_helper'

describe Oga::CSS::Parser do
  context 'operators' do
    example 'parse the = operator' do
      parse_css('x[a="b"]').should == parse_xpath('descendant::x[@a="b"]')
    end

    example 'parse the ~= operator' do
      parse_css('x[a~="b"]').should == parse_xpath(
        'descendant::x[contains(concat(" ", @a, " "), ' \
          'concat(" ", "b", " "))]'
      )
    end

    example 'parse the ^= operator' do
      parse_css('x[a^="b"]').should == parse_xpath(
        'descendant::x[starts-with(@a, "b")]'
      )
    end

    example 'parse the $= operator' do
      parse_css('x[a$="b"]').should == parse_xpath(
        'descendant::x[substring(@a, string-length(@a) - ' \
          'string-length("b") + 1, string-length("b")) = "b"]'
      )
    end

    example 'parse the *= operator' do
      parse_css('x[a*="b"]').should == parse_xpath(
        'descendant::x[contains(@a, "b")]'
      )
    end

    example 'parse the |= operator' do
      parse_css('x[a|="b"]').should == parse_xpath(
        'descendant::x[@a = "b" or starts-with(@a, concat("b", "-"))]'
      )
    end
  end
end
