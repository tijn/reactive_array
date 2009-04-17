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

#   def respond_to?(m)
#   end

  OPERATORS = ["&", "+", "-", "|", "<=>", "=="]
  OPERATORS.each do |operator|
    class_eval(<<-EOS, __FILE__, __LINE__)
      def #{operator}(other_array)
        @array #{operator} other_array.to_a
      end
    EOS
  end

  def method_missing(m, *args, &block)
    x = @array.send(m, *args, &block)
    react!(m)
    x
  end

  def react!(m)
#     raise "subclassresponsibility"
    puts "\treacting on #{m.inspect}"
  end
end


# calls #rewrite! upon any method that is not used for reading
class SerializingArray < ReactiveArray
  # these methods are only used for reading, not for writing so we don't have to #rewrite! when they are used.
  SAFE_METHODS = [:[], :abbrev, :assoc, :at, :collect, :compact, :empty?, :eql?, :first, :flatten, :frozen, :hash, :include?, :index, :inspect, :join, :last, :length, :map, :nitems, :pack, :reject, :reverse, :reverse_each, :rindex, :select, :size, :slice, :sort, :to_a, :to_s, :transpose, :uniq, :values_at, :zip, :all?,
  :any?, :detect, :each_cons, :each_slice, :each_with_index, :each, :entries, :find, :find_all, :grep, :member?, :inject, :max, :min, :partition, :to_set]

  def react!(m)
    rewrite! unless SAFE_METHODS.include? m
  end

#   def rewrite!
#     raise "subclassresponsibility"
#     puts "rewriting"
#   end
end
