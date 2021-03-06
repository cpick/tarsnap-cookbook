module DeepToHash
  extend self

  # to_yaml does not work on the attribute because it is an attribute object
  # converting it to a hash does not work because all nested hashes continue
  # to be Mash objects, which breaks the serialization
  def deep_to_hash(mash = self)
    out_hash = {}
    mash.each{|key,val|
      if val.is_a?(Hash)
        out_hash[key.to_s] = deep_to_hash(val)
      elsif val.is_a?(Array)
        out_hash[key.to_s] = val.to_a
      else
        out_hash[key.to_s] = val
      end
    }
    return out_hash
  end
end
