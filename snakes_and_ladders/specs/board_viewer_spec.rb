require('minitest/autorun')
require('minitest/rg')
require_relative('../board')
require_relative('../board_viewer')

class BoardViewerTest < MiniTest::Test

  def setup
    accessories = {
      81 => 63,
      57 => 24,
      32 => 52,
      77 => 97
    }
    @board = Board.new(100, accessories)
    @board_viewer = BoardViewer.new(@board)
  end

  def test_width_calculated_correctly()
    assert_equal(10, @board_viewer.width)
  end

  def test_translate_index_to_row_and_column()
    assert_equal({column: 2, row: 1}, @board_viewer.translate_index_to_row_and_column(82))
  end

end
