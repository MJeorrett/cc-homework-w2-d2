require_relative('display_matrix')

class BoardViewer

  CELLS = {
    blank: [
      "+-----+",
      "|     |",
      "|     |",
      "+-----+"
    ],
    snake_forward_top: [
      "+-----+",
      "|>-0. |",
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
      "|  ol |",
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
      "| |=| |",
      "+-|=|-+"
    ],
    ladder_middle: [
      "+-|=|-+",
      "| |=| |",
      "| |=| |",
      "+-|=|-+"
    ],
    ladder_bottom: [
      "+-|=|-+",
      "| |=| |",
      "|     |",
      "+-----+"
    ]
  }

  attr_reader(:width)

  def initialize(board)
    @width = Math.sqrt(board.number_of_tiles).floor
    @display_matrix = DisplayMatrix.new(CELLS[:blank], @width, @width)

    for accesory_start_index, accessory_end_index in board.accessories

      accessory_start = translate_index_to_row_and_column(accesory_start_index)
      accessory_end = translate_index_to_row_and_column(accessory_end_index)

      # backward snake
      if (accessory_end[:column]) < (accessory_start[:column])
        top_cell = CELLS[:snake_backward_top]
        middle_cell = CELLS[:snake_backward_middle]
        bottom_cell = CELLS[:snake_backward_bottom]
        row_offset = 1
        column_offset = -1
      # forward snake
      elsif (accessory_end[:column]) > (accessory_start[:column])
        top_cell = CELLS[:snake_forward_top]
        middle_cell = CELLS[:snake_forward_middle]
        bottom_cell = CELLS[:snake_forward_bottom]
        row_offset = 1
        column_offset = 1
      # ladder
      else
        bottom_cell = CELLS[:ladder_top]
        middle_cell = CELLS[:ladder_middle]
        top_cell = CELLS[:ladder_bottom]
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
    return @display_matrix.get_display_string
  end

end
