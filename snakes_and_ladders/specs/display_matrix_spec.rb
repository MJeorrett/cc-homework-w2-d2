require('minitest/autorun')
require('minitest/rg')
require_relative('../display_matrix')

class TestDisplayMatrix < MiniTest::Test

  def setup()
    blank_cell = [
      "+-----+",
      "|     |",
      "|     |",
      "+-----+"
    ]
    @display_matrix = DisplayMatrix.new(blank_cell, 4, 4)
  end

  def test_empty_display_looks_good()
    expected =
"+-----+-----+-----+-----+
|     |     |     |     |
|     |     |     |     |
+-----+-----+-----+-----+
|     |     |     |     |
|     |     |     |     |
+-----+-----+-----+-----+
|     |     |     |     |
|     |     |     |     |
+-----+-----+-----+-----+
|     |     |     |     |
|     |     |     |     |
+-----+-----+-----+-----+"
    assert_equal(expected, @display_matrix.get_display_string())
  end

  def test_add_cell_looks_good()
    expected =
"+-----+-----+-----+-----+
|     |     |     |     |
|     |     |     |     |
+-----+-----+-----+-----+
|     |     |     |     |
|     |     |     |     |
+-----p-000-p-----+-----+
|     | 123 |     |     |
|     | 456 |     |     |
+-----p-000-p-----+-----+
|     |     |     |     |
|     |     |     |     |
+-----+-----+-----+-----+"
    cell_to_add = [
      "p-000-p",
      "| 123 |",
      "| 456 |",
      "p-000-p"
    ]
    @display_matrix.add_cell(cell_to_add, 1, 2)
    assert_equal(expected, @display_matrix.get_display_string())

    # puts "expeceted"
    # puts expected
    # puts "actual"
    # puts @display_matrix.get_display_string()
    # display_string_lines = @display_matrix.get_display_string().lines("\n")
    # for line_index in (0..(expected.lines("\n").length - 1))
    #   puts "line #{line_index}: #{display_string_lines[line_index] == expected.lines("\n")[line_index]}"
    # end
  end

  def test_add_cell_in_last_row_looks_good()
    expected =
  "+-----+-----+-----+-----+
  |     |     |     |     |
  |     |     |     |     |
  +-----+-----+-----+-----+
  |     |     |     |     |
  |     |     |     |     |
  +-----+-----+-----+-----+
  |     |     |     |     |
  |     |     |     |     |
  +-----p-000-p-----+-----+
  |     | 123 |     |     |
  |     | 456 |     |     |
  +-----p-000-p-----+-----+"
    cell_to_add = [
      "p-000-p",
      "| 123 |",
      "| 456 |",
      "p-000-p"
    ]
    @display_matrix.add_cell(cell_to_add, 1, 3)
    assert_equal(expected, @display_matrix.get_display_string())

  end

end
