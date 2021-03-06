require 'spec_helper'

describe Oga::XPath::Evaluator do
  context 'ancestor-or-self axis' do
    before do
      @document = parse('<a><b><c></c></b></a>')

      @a1 = @document.children[0]
      @b1 = @a1.children[0]
      @c1 = @b1.children[0]
    end

    example 'return a node set containing the direct ancestor' do
      evaluate_xpath(@c1, 'ancestor-or-self::b').should == node_set(@b1)
    end

    example 'return a node set containing a higher ancestor' do
      evaluate_xpath(@c1, 'ancestor-or-self::a').should == node_set(@a1)
    end

    example 'return a node set containing the context node itself' do
      evaluate_xpath(@c1, 'ancestor-or-self::c').should == node_set(@c1)
    end

    example 'return a node set containing the first ancestor' do
      evaluate_xpath(@c1, 'ancestor-or-self::*[1]').should == node_set(@c1)
    end

    example 'return an empty node set for non existing ancestors' do
      evaluate_xpath(@c1, 'ancestor-or-self::foo').should == node_set
    end
  end
end
