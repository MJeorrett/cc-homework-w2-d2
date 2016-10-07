require('pry-byebug')

class Board

  attr_reader(:accessories)

  def initialize(size, accessories)
    @state = Array.new(size,0)
    @accessories = accessories
    set_up_positions(accessories)
  end

  def set_up_positions(accessories)
    for square, target in accessories
      @state[square] = target - square
    end
  end

  def modifier_at_position(position)
    return @state[position]
  end

  def number_of_tiles
    return @state.length
  end

  def win_tile
    @state.size - 1;
  end

end
