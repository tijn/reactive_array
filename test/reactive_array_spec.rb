require "rubygems"
require "test/spec"
require "#{File.dirname(__FILE__)}/../lib/reactive_array"


context "ReactiveArray" do
  specify "initializing(int)" do
    a = ReactiveArray.new(2)
    a.size.should == 2
  end

  specify "initializing(int, obj)" do
    a = ReactiveArray.new(2, "foo")
    a.size.should == 2
    a[0].should == "foo"
    a[1].should == "foo"
    a.last.should == "foo"
  end

  specify "initializing(array)" do
    a = ReactiveArray.new(["foo", :bar])
    a.size.should == 2
    a[0].should == "foo"
    a[1].should == :bar
    a.last.should == :bar
  end

  specify "initializing(int, block)" do
    a = ReactiveArray.new(2) do |array|
      array << "soup"
    end
    a.size.should == 3
    a.last.should == "soup"
  end

#   specify "react?" do
#     a = ReactiveArray.new(["foo", "baz"])
#     z = a.first
#     z = "bar"
#   end

  specify "to_s" do
    a = ReactiveArray.new(["foo", "bar"])
    a.to_s.should == "foobar"
  end

  specify "&, intersection" do
    a = ReactiveArray.new(["foo", "bar"])
    b = ReactiveArray.new(["foo", "baz"])
    c = a & b
    c.should.is_a? Array
    c.size.should == 1
    c.to_a.should == ["foo"]
  end

  specify "*, repetition" do
    a = ReactiveArray.new([:foo, :bar])
    b = a * 3
    b.should.is_a? ReactiveArray
    b.size.should == 6
    puts b.inspect
  end

  specify "+, concatenation" do
    a = ReactiveArray.new([:foo, :bar])
    b = ReactiveArray.new([:baz, :foz])
    c = a + b
    c.should.is_a? Array
    c.size.should == 4
    c.to_a.should == [:foo, :bar, :baz, :foz]
  end

  specify "[] slicing" do
    a = ReactiveArray.new([:foo, :bar, :baz, :foz])
    a[0].should == :foo
    a[1, 2].should == [:bar, :baz]
    a[1, 2].should.is_a? Array
  end

  specify "join and reject!" do
    a = ReactiveArray.new([:foo, :bar, :baz, :foz])
    a.join("-").should == "foo-bar-baz-foz"
    a.reject! {|x| [:bar, :baz].include? x }
    a.join("-").should == "foo-foz"
    a.should.is_a? ReactiveArray
  end

  specify "each" do
    a = ReactiveArray.new([:foo, :bar, :baz, :foz])
    yes = false
    a.each do |x|
      yes = true if x == :bar
    end
    yes.should == true
  end

  specify "each" do
    a = ReactiveArray.new([:foo, :bar, :baz, :foz])
    a.map! { |x| x == :bar ? "AAP" : x }
    a.should.include "AAP"
    a.should.include :foo
  end

end
