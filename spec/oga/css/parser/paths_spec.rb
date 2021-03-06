require 'spec_helper'

describe Oga::CSS::Parser do
  context 'paths' do
    example 'parse a single path' do
      parse_css('foo').should == parse_xpath('descendant::foo')
    end

    example 'parse a path using a namespace' do
      parse_css('ns|foo').should == parse_xpath('descendant::ns:foo')
    end

    example 'parse a path using two selectors' do
      parse_css('foo bar').should == parse_xpath(
        'descendant::foo/descendant::bar'
      )
    end
  end
end
