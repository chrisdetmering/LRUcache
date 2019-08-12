class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hashingNum = 0
    if self.empty?
      return nil.hash
    else
      self.each.with_index do |num, i| 
        hashingNum += (num ^ i)
      end 
    end
    hashingNum.hash
  end
end

class String
    def hash
    hashingNum = 0
    if self.empty?
      return nil.hash
    else
      self.chars.each.with_index do |char, i| 
        hashingNum += (char.ord ^ i)
      end 
    end
    hashingNum.hash
  end
end

class Hash
  
  def hash
    hashingNum = 0 
    if self.empty? 
      return nil.hash 
    else
      hashArr = self.to_a.sort.flatten 
      hashArr.each.with_index do |ele, i|
        if ele.is_a?(Symbol)
          num = ele.to_s.ord ^ i
          hashingNum += num  
        elsif ele.is_a?(String)
          num = ele.ord ^ i
          hashingNum += num
        else
          num = ele ^ i 
          hashingNum += num
        end
      end 
    end
    hashingNum.hash
  end
end
