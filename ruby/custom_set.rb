class CustomSet
  def initialize(arr)
    @arr = arr
  end

  def empty?
    @arr.length == 0
  end


  def member?(n)
    @arr.include?(n)
  end

  def subset?(set)
    return true if @arr.empty? && set.empty?
    return false if !@arr.empty? && set.empty?

    if @arr.length > set.length
      set.each do |n|
        return false unless @arr.include?(n)
      end
    else
      @arr.each do |n|
        return false unless set.member?(n)
      end
    end

    true
  end


  def each(&block)
    @arr.each(&block)
  end

  def disjoint?(set)
    return true if @arr.empty? && set.empty?
    return true if !@arr.empty? && set.empty? || @arr.empty? && !set.empty?

    if @arr.length > set.length
      set.sort.each do |n|
        return false if @arr.include?(n)
      end
    else
      @arr.each do |n|
        return false if set.member?(n)
      end
    end

    true
  end

  def ==(set)
    return @arr&.length == set&.length && subset?(set) && set.subset?(@arr)
  end

  def length
    @arr.length
  end

  def add(n)
    return self if @arr.include?(n)
    @arr.push(n).flatten.sort
    self
  end

  def intersection(set)
    return CustomSet.new([]) if @arr.empty? || set.empty?
    inter = []

    @arr.each do |n|
      inter.push(n) if set.member?(n)
    end

    CustomSet.new(inter.sort)

  end

  def difference(set)
    return CustomSet.new([]) if @arr.empty? || set.empty? && @arr.empty?

    diff = []

    @arr.each do |n|
      diff.push(n) unless set.member?(n)
    end
    CustomSet.new(diff.sort)
  end

  def union(set)
    CustomSet.new([]) if @arr.empty? && set.empty?

    _union = @arr

    set&.each do |n|
      _union.push(n)
    end

    CustomSet.new(_union.sort.uniq)
  end
end
