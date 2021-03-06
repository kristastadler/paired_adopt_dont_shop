class Favorite
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents ||= Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(id)
    @contents[id.to_s] = 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def delete_pet(id)
    @contents[id.to_s] = 0
  end
  
  def reset
    @contents.map do |id, favorite_count|
      @contents[id] = 0
    end
  end
end
