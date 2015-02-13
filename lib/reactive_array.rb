# A wrapper around an array that calls #react! on any 'send'. This enables you to react to certain events or changes to the array.
class ReactiveArray

  def initialize(*args)
    @array = Array.new(*args)
    yield self if block_given?
  end

  def to_s
    react!(:to_s)
    @array.to_s
  end

  def to_a
    react!(:to_a)
    @array
  end
  alias_method :to_ary, :to_a

  OPERATORS = ["&", "+", "-", "|", "<=>", "=="]
  OPERATORS.each do |operator|
    class_eval <<-end_eval, __FILE__, __LINE__
      def #{operator}(other_array)
        @array #{operator} other_array.to_a
      end
    end_eval
  end

  def method_missing(m, *args, &block)
    x = @array.send(m, *args, &block)
    react!(m)
    # if the @array returned self, we return self too (but we will refer to our wrapper class of course)
    x.equal?(@array) ? self : x
  end

  def react!(m)
    raise NotImplemented, "responsibility of subclass"
    # puts "reacting on #{m.inspect}"
  end
end
