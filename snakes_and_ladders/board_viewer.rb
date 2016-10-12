require_relative('display_matrix')
require_relative('string__colorize.rb')

require('pry-byebug')

class BoardViewer

  @@cells = {
    blank: [
      "+-----+",
      "|     |",
      "|     |",
      "+-----+"
    ],
    snake_forward_top: [
      "+-----+",
      "|>~O  |",
      "|  oOo|",
      "+----oO"
    ],
    snake_forward_middle: [
      "Oo----+",
      "|oOo  |",
      "|  oOo|",
      "+----oO"
    ],
    snake_forward_bottom: [
      "Oo----+",
      "|oOo  |",
      "|  o  |",
      "+-----+"
    ],
    snake_backward_top: [
      "+-----+",
      "|  O~<|",
      "|oOo  |",
      "Oo----+"
    ],
    snake_backward_middle: [
      "+----Oo",
      "|  oOo|",
      "|oOo  |",
      "Oo----+"
    ],
    snake_backward_bottom: [
      "+----oO",
      "|  oOo|",
      "|  o  |",
      "+-----+"
    ],
    ladder_top: [
      "+-----+",
      "|     |",
      "| I=I |",
      "+-I=I-+"
    ],
    ladder_middle: [
      "+-I=I-+",
      "| I=I |",
      "| I=I |",
      "+-I=I-+"
    ],
    ladder_bottom: [
      "+-I=I-+",
      "| I=I |",
      "|     |",
      "+-----+"
    ]
  }

  attr_reader(:width)

  def initialize(board)
    @width = Math.sqrt(board.number_of_tiles).floor
    @display_matrix = DisplayMatrix.new(@@cells[:blank], @width, @width)

    for accesory_start_index, accessory_end_index in board.accessories

      accessory_start = translate_index_to_row_and_column(accesory_start_index)
      accessory_end = translate_index_to_row_and_column(accessory_end_index)

      # backward snake
      if (accessory_end[:column]) < (accessory_start[:column])
        top_cell = @@cells[:snake_backward_top]
        middle_cell = @@cells[:snake_backward_middle]
        bottom_cell = @@cells[:snake_backward_bottom]
        row_offset = 1
        column_offset = -1
      # forward snake
      elsif (accessory_end[:column]) > (accessory_start[:column])
        top_cell = @@cells[:snake_forward_top]
        middle_cell = @@cells[:snake_forward_middle]
        bottom_cell = @@cells[:snake_forward_bottom]
        row_offset = 1
        column_offset = 1
      # ladder
      else
        bottom_cell = @@cells[:ladder_top]
        middle_cell = @@cells[:ladder_middle]
        top_cell = @@cells[:ladder_bottom]
        row_offset = -1
        column_offset = 0
      end

      @display_matrix.add_cell(top_cell, accessory_start[:column], accessory_start[:row])
      number_middle_segments = (accessory_end[:row] - accessory_start[:row]).abs - 1

      # binding.pry

      for offset_count in (1..number_middle_segments)
        column = accessory_start[:column] + (column_offset * offset_count)
        row = accessory_start[:row] + (row_offset * offset_count)
        @display_matrix.add_cell(middle_cell, column, row)
      end

      @display_matrix.add_cell(bottom_cell, accessory_end[:column], accessory_end[:row])
    end
  end

  def translate_index_to_row_and_column(index)
    column = index % @width
    row = @width - index / @width - 1
    return {column: column, row: row}
  end

  def get_display_string()
    str = @display_matrix.get_display_string
    str.colourise_chars(['o', 'O'], 32, 49, true)
    str.colourise_chars(['>', '~', '<'], 31, 49, true)
    str.colourise_chars(['=', 'I', 'I'], 33, 49, true)
    return str
  end

end
