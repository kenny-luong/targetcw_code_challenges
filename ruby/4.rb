# Binary Search Tree Challenge
#
# insert and search for numbers in a binary tree.
#
# when we need to represent sorted data, an array does not make a good
# data structure.
#
# say we have the array `[1, 3, 4, 5]`, and we add 2 to it so it becomes
# `[1, 3, 4, 5, 2]` now we must sort the entire array again! We can
# improve on this by realizing that we only need to make space for the new
# item `[1, nil, 3, 4, 5]`, and then adding the item in the space we
# added. but this still requires us to shift many elements down by one.
#
# binary search trees, however, can operate on sorted data much more
# efficiently.
#
# a binary search tree consists of a series of connected nodes. Each node
# contains a piece of data (e.g. the number 3), a variable named `left`,
# and a variable named `right`. The `left` and `right` variables point at
# `nil`, or other nodes. Since these other nodes in turn have other nodes
# beneath them, we say that the left and right variables are pointing at
# subtrees. all data in the left subtree is less than or equal to the
# current node's data, and all data in the right subtree is greater than
# the current node's data.
#
# for example, if we had a node containing the data 4, and we added the
# data 2, our tree would look like this:
#
#      4
#     /
#    2
#
# if we then added 6, it would look like this:
#
#      4
#     / \
#    2   6
#
# if we then added 3, it would look like this
#
#       4
#     /   \
#    2     6
#     \
#      3
#
# and if we then added 1, 5, and 7, it would look like this
#
#          4
#        /   \
#       /     \
#      2       6
#     / \     / \
#    1   3   5   7

require 'minitest/autorun'
require_relative 'binary_search_tree'

class BstTest < Minitest::Test
  def test_data_is_retained
    assert_equal 4, Bst.new(4).data
  end

  def test_inserting_less
    four = Bst.new 4
    four.insert 2
    assert_equal 4, four.data
    assert_equal 2, four.left.data
  end

  def test_inserting_same
    four = Bst.new 4
    four.insert 4
    assert_equal 4, four.data
    assert_equal 4, four.left.data
  end

  def test_inserting_right
    four = Bst.new 4
    four.insert 5
    assert_equal 4, four.data
    assert_equal 5, four.right.data
  end

  def test_complex_tree
    four = Bst.new 4
    four.insert 2
    four.insert 6
    four.insert 1
    four.insert 3
    four.insert 7
    four.insert 5
    assert_equal 4, four.data
    assert_equal 2, four.left.data
    assert_equal 1, four.left.left.data
    assert_equal 3, four.left.right.data
    assert_equal 6, four.right.data
    assert_equal 5, four.right.left.data
    assert_equal 7, four.right.right.data
  end

  def record_all_data(bst)
    all_data = []
    bst.each { |data| all_data << data }
    all_data
  end

  def test_iterating_one_element
    assert_equal [4], record_all_data(Bst.new(4))
  end

  def test_iterating_over_smaller_element
    four = Bst.new 4
    four.insert 2
    assert_equal [2, 4], record_all_data(four)
  end

  def test_iterating_over_larger_element
    four = Bst.new 4
    four.insert 5
    assert_equal [4, 5], record_all_data(four)
  end

  def test_iterating_over_complex_tree
    four = Bst.new 4
    four.insert 2
    four.insert 1
    four.insert 3
    four.insert 6
    four.insert 7
    four.insert 5
    assert_equal [1, 2, 3, 4, 5, 6, 7], record_all_data(four)
  end

  def test_each_returns_enumerator_if_no_block
    tree = Bst.new 4
    [2, 1, 3, 6, 7, 5].each { |x| tree.insert x }
    each_enumerator = tree.each

    assert_kind_of Enumerator, each_enumerator

    (1..7).each { |x| assert_equal(x, each_enumerator.next) }

    assert_raises(StopIteration) { each_enumerator.next }
  end
end
