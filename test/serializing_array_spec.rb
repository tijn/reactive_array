require "rubygems"
require "test/spec"
require "#{File.dirname(__FILE__)}/../lib/reactive_array"

context "SerializingArray" do

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

  before :each do
    @stuff = Stuff.new("foo", "bar,baz,chunkey")
  end

  specify "adding an item to the array should serialize it immediately" do
    @stuff.word_list << "bacon"
    @stuff.list.should == "bar,baz,chunkey,bacon"
  end

  specify "adding multiple items to the array (chaining)" do
    @stuff.word_list << "bacon" << "foo"
    @stuff.list.should == "bar,baz,chunkey,bacon,foo"
  end

  specify "removing an item from the array should trigger serialization" do
    (x = @stuff.word_list.pop).should == "chunkey"
    @stuff.list.should == "bar,baz"
    @stuff.word_list.shift.should == "bar"
    @stuff.list.should == "baz"
    @stuff.word_list.unshift x
    @stuff.list.should == "chunkey,baz"
  end

end
