# Phone Number Challenge
#
# Clean up user-entered phone numbers so that they can be sent SMS messages.
#
# The **North American Numbering Plan (NANP)** is a telephone numbering system used by many countries in North America like the United States, Canada or Bermuda. All NANP-countries share the same international country code: `1`.
#
# NANP numbers are ten-digit numbers consisting of a three-digit Numbering Plan Area code, commonly known as *area code*, followed by a seven-digit local number. The first three digits of the local number represent the *exchange code*, followed by the unique four-digit number which is the *subscriber number*.
#
# The format is usually represented as
#
# (NXX)-NXX-XXXX
#
# where `N` is any digit from 2 through 9 and `X` is any digit from 0 through 9.
#
# Your task is to clean up differently formatted telephone numbers by removing punctuation and the country code (1) if present.
#
# For example, the inputs
# +1 (613)-995-0253
# 613-995-0253
# 1 613 995 0253
# 613.995.0253
#
# should all produce the output
#
# 6139950253
#
# **Note:** As this exercise only deals with telephone numbers used in NANP-countries, only 1 is considered a valid country code.

require 'minitest/autorun'
require_relative 'phone_number'

# Common test data version: 1.2.0 39cba0d
class PhoneNumberTest < Minitest::Test
  def test_cleans_the_number
    assert_equal "2234567890", PhoneNumber.clean("(223) 456-7890")
  end

  def test_cleans_numbers_with_dots
    assert_equal "2234567890", PhoneNumber.clean("223.456.7890")
  end

  def test_cleans_numbers_with_multiple_spaces
    assert_equal "2234567890", PhoneNumber.clean("223 456   7890   ")
  end

  def test_invalid_when_9_digits
    assert_nil PhoneNumber.clean("123456789")
  end

  def test_invalid_when_11_digits_does_not_start_with_a_1
    assert_nil PhoneNumber.clean("22234567890")
  end

  def test_valid_when_11_digits_and_starting_with_1
    assert_equal "2234567890", PhoneNumber.clean("12234567890")
  end

  def test_valid_when_11_digits_and_starting_with_1_even_with_punctuation
    assert_equal "2234567890", PhoneNumber.clean("+1 (223) 456-7890")
  end

  def test_invalid_when_more_than_11_digits
    assert_nil PhoneNumber.clean("321234567890")
  end

  def test_invalid_with_letters
    assert_nil PhoneNumber.clean("123-abc-7890")
  end

  def test_invalid_with_punctuations
    assert_nil PhoneNumber.clean("123-@:!-7890")
  end

  def test_invalid_if_area_code_does_not_start_with_2_9
    assert_nil PhoneNumber.clean("(123) 456-7890")
  end

  def test_invalid_if_exchange_code_does_not_start_with_2_9
    assert_nil PhoneNumber.clean("(223) 056-7890")
  end
end
