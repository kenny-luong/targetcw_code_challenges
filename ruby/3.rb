# Custom Set Challenge
#
# Create a custom set type.
#
# Sometimes it is necessary to define a custom data structure of some
# type, like a set. In this exercise you will define your own set. How it
# works internally doesn't matter, as long as it behaves like a set of
# unique elements.
#
# * * * *
#
# For running the tests provided, you will need the Minitest gem.
#
#    gem install minitest
#
# If you would like color output, you can `require 'minitest/pride'` in
# the test file, or note the alternative instruction, below, for running
# the test file.
#
# Run the tests from the exercise directory using the following command:
#
#    ruby 3.rb
#
# To include color from the command line:
#
#    ruby -r minitest/pride 3.rb

require 'minitest/autorun'
require_relative 'custom_set'

# Common test data version: 1.0.1 4527635
class CustomSetTest < Minitest::Test
  def test_sets_with_no_elements_are_empty
    set = CustomSet.new []
    assert_empty set
  end

  def test_sets_with_elements_are_not_empty
    set = CustomSet.new [1]
    refute_empty set
  end

  def test_nothing_is_contained_in_an_empty_set
    set = CustomSet.new []
    element = 1
    refute set.member? element
  end

  def test_when_the_element_is_in_the_set
    set = CustomSet.new [1, 2, 3]
    element = 1
    assert set.member? element
  end

  def test_when_the_element_is_not_in_the_set
    set = CustomSet.new [1, 2, 3]
    element = 4
    refute set.member? element
  end

  def test_empty_set_is_a_subset_of_another_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new []
    assert set1.subset? set2
  end

  def test_empty_set_is_a_subset_of_non_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new [1]
    assert set1.subset? set2
  end

  def test_non_empty_set_is_not_a_subset_of_empty_set
    set1 = CustomSet.new [1]
    set2 = CustomSet.new []
    refute set1.subset? set2
  end

  def test_set_is_a_subset_of_set_with_exact_same_elements
    set1 = CustomSet.new [1, 2, 3]
    set2 = CustomSet.new [1, 2, 3]
    assert set1.subset? set2
  end

  def test_set_is_a_subset_of_larger_set_with_same_elements
    set1 = CustomSet.new [1, 2, 3]
    set2 = CustomSet.new [4, 1, 2, 3]
    assert set1.subset? set2
  end

  def test_set_is_not_a_subset_of_set_that_does_not_contain_its_elements
    set1 = CustomSet.new [1, 2, 3]
    set2 = CustomSet.new [4, 1, 3]
    refute set1.subset? set2
  end

  def test_the_empty_set_is_disjoint_with_itself
    set1 = CustomSet.new []
    set2 = CustomSet.new []
    assert set1.disjoint? set2
  end

  def test_empty_set_is_disjoint_with_non_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new [1]
    assert set1.disjoint? set2
  end

  def test_non_empty_set_is_disjoint_with_empty_set
    set1 = CustomSet.new [1]
    set2 = CustomSet.new []
    assert set1.disjoint? set2
  end

  def test_sets_are_not_disjoint_if_they_share_an_element
    set1 = CustomSet.new [1, 2]
    set2 = CustomSet.new [2, 3]
    refute set1.disjoint? set2
  end

  def test_sets_are_disjoint_if_they_share_no_elements
    set1 = CustomSet.new [1, 2]
    set2 = CustomSet.new [3, 4]
    assert set1.disjoint? set2
  end

  def test_empty_sets_are_equal
    set1 = CustomSet.new []
    set2 = CustomSet.new []
    assert_equal set1, set2
  end

  def test_empty_set_is_not_equal_to_non_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new [1, 2, 3]
    refute_equal set1, set2
  end

  def test_non_empty_set_is_not_equal_to_empty_set
    set1 = CustomSet.new [1, 2, 3]
    set2 = CustomSet.new []
    refute_equal set1, set2
  end

  def test_sets_with_the_same_elements_are_equal
    set1 = CustomSet.new [1, 2]
    set2 = CustomSet.new [2, 1]
    assert_equal set1, set2
  end

  def test_sets_with_different_elements_are_not_equal
    set1 = CustomSet.new [1, 2, 3]
    set2 = CustomSet.new [1, 2, 4]
    refute_equal set1, set2
  end

  def test_add_to_empty_set
    set = CustomSet.new []
    expected = CustomSet.new [3]
    assert_equal expected, set.add(3)
  end

  def test_add_to_non_empty_set
    set = CustomSet.new [1, 2, 4]
    expected = CustomSet.new [1, 2, 3, 4]
    assert_equal expected, set.add(3)
  end

  def test_adding_an_existing_element_does_not_change_the_set
    set = CustomSet.new [1, 2, 3]
    expected = CustomSet.new [1, 2, 3]
    assert_equal expected, set.add(3)
  end

  def test_intersection_of_two_empty_sets_is_an_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new []
    expected = CustomSet.new []
    assert_equal expected, set2.intersection(set1)
  end

  def test_intersection_of_an_empty_set_and_non_empty_set_is_an_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new [3, 2, 5]
    expected = CustomSet.new []
    assert_equal expected, set2.intersection(set1)
  end

  def test_intersection_of_a_non_empty_set_and_an_empty_set_is_an_empty_set
    set1 = CustomSet.new [1, 2, 3, 4]
    set2 = CustomSet.new []
    expected = CustomSet.new []
    assert_equal expected, set2.intersection(set1)
  end

  def test_intersection_of_two_sets_with_no_shared_elements_is_an_empty_set
    set1 = CustomSet.new [1, 2, 3]
    set2 = CustomSet.new [4, 5, 6]
    expected = CustomSet.new []
    assert_equal expected, set2.intersection(set1)
  end

  def test_intersection_of_two_sets_with_shared_elements_is_a_set_of_the_shared_elements
    set1 = CustomSet.new [1, 2, 3, 4]
    set2 = CustomSet.new [3, 2, 5]
    expected = CustomSet.new [2, 3]
    assert_equal expected, set2.intersection(set1)
  end

  def test_difference_of_two_empty_sets_is_an_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new []
    expected = CustomSet.new []
    assert_equal expected, set1.difference(set2)
  end

  def test_difference_of_empty_set_and_non_empty_set_is_an_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new [3, 2, 5]
    expected = CustomSet.new []
    assert_equal expected, set1.difference(set2)
  end

  def test_difference_of_a_non_empty_set_and_an_empty_set_is_the_non_empty_set
    set1 = CustomSet.new [1, 2, 3, 4]
    set2 = CustomSet.new []
    expected = CustomSet.new [1, 2, 3, 4]
    assert_equal expected, set1.difference(set2)
  end

  def test_difference_of_two_non_empty_sets_is_a_set_of_elements_that_are_only_in_the_first_set
    set1 = CustomSet.new [3, 2, 1]
    set2 = CustomSet.new [2, 4]
    expected = CustomSet.new [1, 3]
    assert_equal expected, set1.difference(set2)
  end

  def test_union_of_empty_sets_is_an_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new []
    expected = CustomSet.new []
    assert_equal expected, set1.union(set2)
  end

  def test_union_of_an_empty_set_and_non_empty_set_is_the_non_empty_set
    set1 = CustomSet.new []
    set2 = CustomSet.new [2]
    expected = CustomSet.new [2]
    assert_equal expected, set1.union(set2)
  end

  def test_union_of_a_non_empty_set_and_empty_set_is_the_non_empty_set
    set1 = CustomSet.new [1, 3]
    set2 = CustomSet.new []
    expected = CustomSet.new [1, 3]
    assert_equal expected, set1.union(set2)
  end

  def test_union_of_non_empty_sets_contains_all_unique_elements
    set1 = CustomSet.new [1, 3]
    set2 = CustomSet.new [2, 3]
    expected = CustomSet.new [3, 2, 1]
    assert_equal expected, set1.union(set2)
  end
end
