class Bst
  attr_reader :data, :left, :right
  def initialize(data)
    @data = data
    @left, @right = nil
  end

  def >(n)
    @data > n
  end

  def insert(n)
    if n > @data
      if @right.nil?
        @right = Bst.new(n)
      else
        @right.insert(n)
      end
    else
      if @left.nil?
        @left = Bst.new(n)
      else
        @left.insert(n)
      end
    end
  end

  def inorder(node)
    return if node.nil?
    inorder(node.left)
    @block << node.data
    inorder(node.right)
  end

  def each(&block)
    @block = []
    if block.nil?
      inorder(self)
      @block.sort!.each
    else
      return if @data.nil?
      @left&.each(&block)
      yield(@data)
      @right&.each(&block)
    end
  end
end
