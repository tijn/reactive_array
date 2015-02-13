require "rspec"
require "#{File.dirname(__FILE__)}/../lib/reactive_array"


describe ReactiveArray do
  describe "initializing(int)" do
    let(:a) { ReactiveArray.new(2) }

    it 'has (int) elements' do
      a.size.should == 2
    end
  end

  describe "initializing(int, obj)" do
    let(:a) { ReactiveArray.new(2, "foo") }

    it 'has two elements' do
      a.size.should == 2
    end

    it 'contains foo at each position' do
      a[0].should == "foo"
      a[1].should == "foo"
      a.first.should == "foo"
      a.last.should == "foo"
    end
  end

  describe "initializing(array)" do
    let(:a) { ReactiveArray.new(["foo", :bar]) }

    it 'has two elements' do
      a.size.should == 2
    end

    it 'contains the elements of the array we fed it' do
      a[0].should == "foo"
      a[1].should == :bar
      a.first.should == 'foo'
      a.last.should == :bar
    end
  end

  describe "initializing(int, block)" do
    let(:a) do
      ReactiveArray.new(2) do |array|
        array << "soup"
      end
    end

    it 'has thre elements' do
      a.size.should == 3
    end

    it 'contains the element we added' do
      a.last.should == "soup"
    end
  end

#   describe "react?" do
#     a = ReactiveArray.new(["foo", "baz"])
#     z = a.first
#     z = "bar"
#   end

  describe "#to_s" do
    let(:array) { ["foo", "bar"] }
    let(:a) { ReactiveArray.new(array) }

    it 'does the same as Array' do
      a.to_s.should == array.to_s
    end
  end

  describe "&, intersection" do
    let(:a) { ReactiveArray.new(["foo", "bar"]) }
    let(:b) { ReactiveArray.new(["foo", "baz"]) }
    let(:c) { c = a & b }

    it 'is an Array' do
      c.should.is_a? Array
    end

    it 'contains precicely 1 element' do
      c.size.should == 1
    end

    it 'is ["foo"]' do
      c.to_a.should == ['foo']
    end
  end

  describe "*, repetition" do
    let(:a) { ReactiveArray.new([:foo, :bar]) }
    let(:b) { a * 3 }

    it 'is a ReactiveArray' do
      b.should.is_a? ReactiveArray
    end

    it 'has six elements (3 * 2)' do
      b.size.should == 6
    end
  end

  describe "+, concatenation" do
    let(:a) { ReactiveArray.new([:foo, :bar]) }
    let(:b) { ReactiveArray.new([:baz, :foz]) }
    let(:c) { a + b }

    it 'is an Array' do
      c.should.is_a? Array
    end

    it 'has four elements' do
      c.size.should == 4
    end

    it 'contains exactly array a and b' do
      c.to_a.should == [:foo, :bar, :baz, :foz]
    end
  end

  describe "[] slicing" do
    let(:a) { ReactiveArray.new([:foo, :bar, :baz, :foz]) }

    it 'can return one element' do
      a[0].should == :foo
    end

    it 'can return two elements as an Array' do
      a[1, 2].should.is_a? Array
      a[1, 2].should == [:bar, :baz]
    end
  end

  describe "#join and #reject!" do
    let(:a) { ReactiveArray.new([:foo, :bar, :baz, :foz]) }

    it 'can join with a given string' do
      a.join("-").should == "foo-bar-baz-foz"
    end

    it 'can reject certain elements' do
      a.reject! {|x| [:bar, :baz].include? x }
      a.join("-").should == "foo-foz"
    end
  end

  describe "#each" do
    let(:a) { ReactiveArray.new([:foo, :bar, :baz, :foz]) }

    it 'will encounter :bar while looping over the ReactiveArray' do
      yes = false
      a.each do |x|
        yes = true if x == :bar
      end
      yes.should == true
    end
  end

  describe "#map" do
    let(:a) { ReactiveArray.new([:foo, :bar, :baz, :foz]) }

    it 'works like with a normal array' do
      a.map! { |x| x == :bar ? "AAP" : x }
      expect { a.include? "AAP" }
      expect { a.include? :foo }
    end
  end

end
