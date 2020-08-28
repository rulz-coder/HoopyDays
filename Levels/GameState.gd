extends Node2D


var lives = 1000
var coins = 0

func _ready():
  add_to_group("Gamestate")
  update_GUI()

func hurt():
  update_GUI()
  lives -= 1
  $Player.hurt()
  if lives < 0:
	  end_game()


func update_GUI():
  get_tree().call_group("GUI", "update_lives", lives)

func coin_up():
  coins += 1
  get_tree().call_group("GUI", "update_coins", coins)


func end_game():
  # $AudioStreamPlayer.stream = load("res://SFX/game_over_bad_chest.wav")
  # $AudioStreamPlayer.play()
  get_tree().change_scene("res://Levels/GameOver.tscn")
