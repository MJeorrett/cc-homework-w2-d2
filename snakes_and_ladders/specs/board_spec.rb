require 'minitest/autorun'
require 'minitest/rg'

require_relative '../board'

class TestBoard < Minitest::Test
  def setup
    accessories = {
      81 => 63,
      57 => 24,
      32 => 52,
      77 => 97
    }
    @board = Board.new(100, accessories)
  end

  def test_board_should_have_100_tiles
    assert_equal(100, @board.number_of_tiles)
  end

  def test_position_32_is_a_ladder
    assert_equal(20, @board.modifier_at_position(32))
  end

  def test_position_81_is_a_snake
    assert_equal(-18, @board.modifier_at_position(81))
  end

  def test_win_tile
    assert_equal(99, @board.win_tile)
  end

end
