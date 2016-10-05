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
      "| ol  |",
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
      "| |=| |",
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
      "| |=| |",
      "+-----+"
    ]
  }

  attr_reader(:width)

  def initialize(board)
    @width = Math.sqrt(board.number_of_tiles).floor
    @display_matrix = DisplayMatrix.new(CELLS[:blank], @width, @width)

    for snake_start_index, snake_end_index in board.snakes

      snake_start = translate_index_to_row_and_column(snake_start_index)
      snake_end = translate_index_to_row_and_column(snake_end_index)

      # backward snake
      if (snake_end[:column]) < (snake_start[:column])
        # binding.pry
        @display_matrix.add_cell(CELLS[:snake_backward_top], snake_start[:column], snake_start[:row])
        number_middle_segments = snake_end[:row] - snake_start[:row] - 1
        for offset in (1..number_middle_segments)
          @display_matrix.add_cell(CELLS[:snake_backward_middle], snake_start[:column] - offset, snake_start[:row] + offset)
        end
        @display_matrix.add_cell(CELLS[:snake_backward_bottom], snake_end[:column], snake_end[:row])
      # forward snake
      else

      end
    end
    puts @display_matrix.get_display_string()
  end

  def translate_index_to_row_and_column(index)
    column = index % @width
    row = @width - index / @width - 1
    return {column: column, row: row}
  end

end
