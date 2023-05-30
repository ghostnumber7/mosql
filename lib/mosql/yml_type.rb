# Set the custom resolver as the default resolver
def process_object_id(value)
  case value
  when Hash
    value = value['$oid'] || value['data']
    return process_object_id(value)
  when Array
    if value.length == 12
      return BSON::ObjectId.from_data(value)
    else
      raise "Invalid ObjectId #{value.inspect}"
    end
  when String
    BSON::ObjectId.from_string(value)
  else
    raise "Invalid ObjectId #{value.inspect}"
  end
end

Psych.add_builtin_type 'ObjectId' do |type, value|
  process_object_id(value)
end

# TODO: Add tests for this
