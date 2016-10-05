class Board

  attr_reader(:snakes, :ladders)

  def initialize(size, snakes, ladders)
    @state = Array.new(size,0)
    @snakes = snakes
    @ladders = ladders
    set_up_positions(snakes, ladders)
  end

  def set_up_positions(snakes, ladders)
    for square, target in snakes.merge(ladders)
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
