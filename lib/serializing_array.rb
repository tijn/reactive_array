# calls #rewrite! upon any method that is not used for reading
class SerializingArray < ReactiveArray
  # these methods are only used for reading, not for writing so we don't have to #rewrite! when they are used.
  SAFE_METHODS = [:[], :abbrev, :assoc, :at, :collect, :compact, :empty?, :eql?, :first, :flatten, :frozen, :hash, :include?, :index, :inspect, :join, :last, :length, :map, :nitems, :pack, :reject, :reverse, :reverse_each, :rindex, :select, :size, :slice, :sort, :to_a, :to_s, :transpose, :uniq, :values_at, :zip, :all?,
  :any?, :detect, :each_cons, :each_slice, :each_with_index, :each, :entries, :find, :find_all, :grep, :member?, :inject, :max, :min, :partition, :to_set]

  def react!(m)
    rewrite! unless SAFE_METHODS.include? m
  end

  def rewrite!
    raise NotImplemented, "responsibility of subclass"
    # puts "rewriting"
  end
end
