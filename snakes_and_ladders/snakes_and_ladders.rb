require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'dice'
require_relative 'viewer'
require_relative 'board_viewer'

class SnakeAndLadders

  def initialize(dice, viewer)
    @dice = dice
    @viewer = viewer

    accessories = {
      81 => 63,
      57 => 24,
      32 => 52,
      77 => 97
    }
    board = Board.new(100, accessories)

    player_1_name = @viewer.get_player_name(1)
    player_2_name = @viewer.get_player_name(2)

    player1 = Player.new(player_1_name)
    player2 = Player.new(player_2_name)

    players = [player1,player2]
    @game = Game.new(players,board)

    board_viewer = BoardViewer.new(board)
    puts board_viewer.get_display_string

  end

  def run()
    while(!@game.is_won?)
      @viewer.start(@game.current_player.name)
      @game.next_turn(@dice.roll)
      @viewer.show_update(@game.log.last)
    end

    @viewer.end(@game.winner.name)
  end

end

game = SnakeAndLadders.new(Dice.new, Viewer.new)
game.run()
