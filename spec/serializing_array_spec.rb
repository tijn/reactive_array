require "rspec"
require "#{File.dirname(__FILE__)}/../lib/reactive_array"

describe "SerializingArray" do

  class Stuff
    attr_accessor :name, :list
    def initialize(name, list)
      @name, @list = name, list
    end

    def word_list
      @word_list ||= WordList.new(self)
    end
  end

  class WordList < SerializingArray
    def initialize(stuff)
      @stuff = stuff
      super(@stuff.list.split(","))
    end

    def rewrite!
      @stuff.list = @array.join(",")
    end
  end

  let(:stuff) { Stuff.new("foo", "bar,baz,chunkey") }

  it "serializes immediately after adding an item" do
    stuff.word_list << "bacon"
    stuff.list.should == "bar,baz,chunkey,bacon"
  end

  describe 'chaining' do
    it "can add multiple items to the array" do
      stuff.word_list << "bacon" << "foo"
      stuff.list.should == "bar,baz,chunkey,bacon,foo"
    end
  end

  it "serializes immediately after removing an item" do
    (x = stuff.word_list.pop).should == "chunkey"
    stuff.list.should == "bar,baz"
    stuff.word_list.shift.should == "bar"
    stuff.list.should == "baz"
    stuff.word_list.unshift x
    stuff.list.should == "chunkey,baz"
  end

end
