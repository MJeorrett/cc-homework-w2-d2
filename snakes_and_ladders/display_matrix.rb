require('pry-byebug')

class DisplayMatrix

  def initialize(blank_cell, number_of_columns, number_of_rows)
    @cell_height = blank_cell.length - 1
    @cell_width = blank_cell[0].length
    @number_of_rows = number_of_rows
    @number_of_columns = number_of_columns
    initialise_buffer(blank_cell)
  end

  def add_cell(cell_to_add, column, row)
    write_start_column = (column * (@cell_width - 1))
    # binding.pry
    for cell_row in (0..(@cell_height - 1))
      row_string = @buffer[row][cell_row]

      for cell_char in (0..(@cell_width - 1))
        row_string[cell_char + write_start_column] = cell_to_add[cell_row][cell_char]
      end
    end

    if row == @number_of_rows - 1
      last_string = @buffer[-1][-1]
    else
      last_string = @buffer[row + 1][0]
    end

    for cell_char in (0..(@cell_width - 1))
      last_string[cell_char + write_start_column] = cell_to_add[-1][cell_char]
    end

  end

  def initialise_buffer(blank_cell)
    @buffer = []

    @number_of_rows.times do
      a_row = []
      @cell_height.times do
        a_row.push("")
      end

      @number_of_columns.times do
        for cell_row in (0..(@cell_height - 1))
          a_row[cell_row] += blank_cell[cell_row][0..-2]
        end
      end

      for cell_row in (0..(@cell_height - 1))
        a_row[cell_row] += blank_cell[cell_row][-1, 1]
      end

      @buffer.push(a_row)
    end

    last_row = ""

    @number_of_columns.times do
      last_row += blank_cell[-1][0..-2]
    end

    last_row += blank_cell[-1][-1]

    @buffer[-1].push(last_row)
  end

  def get_display_string()
    @buffer.map { |row|
      row.join("\n")
    }.join("\n")
  end

end
