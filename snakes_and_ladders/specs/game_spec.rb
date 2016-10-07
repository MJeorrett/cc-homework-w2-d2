require 'minitest/autorun'
require 'minitest/rg'
require_relative '../game'
require_relative '../player'
require_relative '../board'

class TestGame < Minitest::Test

  def setup
    accessories = {
      81 => 63,
      57 => 24,
      32 => 52,
      77 => 97
    }
    board = Board.new(100, accessories)

    @player1 = Player.new("Val")
    @player2 = Player.new("Rick")

    players = [@player1, @player2]

    @game = Game.new(players, board)
  end

  def test_game_starts_with_2_players
    assert_equal(2, @game.number_of_players)
  end

  def test_game_current_player_starts_as_player_1
    assert_equal(@player1, @game.current_player)
  end

  def test_can_update_current_player
    @game.update_current_player
    assert_equal(@player2, @game.current_player)
  end

  def test_can_take_turn
    @game.next_turn(1)
    assert_equal(@player2,@game.current_player)
    assert_equal(1,@player1.position)
  end

  def test_cannot_move_beyond_end
    @game.next_turn(110)
    assert_equal(99, @player1.position)
  end

  def test_can_take_turn_with_ladder
    @game.next_turn(32)
    assert_equal(@player2,@game.current_player)
    assert_equal(52, @player1.position)
  end

  def test_can_take_turn_with_snake
    @game.next_turn(57)
    assert_equal(@player2,@game.current_player)
    assert_equal(24, @player1.position)
  end

  def winner_starts_as_nil
    assert_equal(nil,@game.winner)
  end

  def test_game_is_won
    @game.next_turn(99)
    assert_equal(true,@game.is_won?)
  end

  def test_no_next_turn_on_win
    @game.next_turn(99)
    assert_equal(true,@game.is_won?)

    @game.next_turn(2)
    assert_equal(0,@player2.position)
  end

  def test_adds_turn_to_log
    @game.next_turn(1)
    assert_equal(1,@game.log.size)
    assert_equal("Val",@game.log[0].player.name)
    assert_equal(1,@game.log[0].roll)
    assert_equal(0,@game.log[0].modifier)
  end
end
