module PhoneNumber
  DIGIT_EXP  = /\d/
  WHITELIST = ['(', ')', '+', '.', '-', ' ']
  def self.clean(number)
    sanitized_number = ""

    number.split("").each do |n|
      if DIGIT_EXP.match?(n) || WHITELIST.include?(n)
        sanitized_number += n if DIGIT_EXP.match?(n)
      else
        return nil
      end
    end

    return nil if sanitized_number.length > 11
    if sanitized_number.length == 11

      return sanitized_number[1..-1] if sanitized_number[0] == "1"
      return nil
    end

    return sanitized_number if sanitized_number[0].to_i > 1 && sanitized_number[3].to_i > 1
    nil
  end
end

def number?(n)
  Integer(n) rescue false
end
