extends Control

@export var suit: String
@export var rank: String
@export var value: int

func set_card_data(suit_name, rank_name, val, texture):
	suit = suit_name
	rank = rank_name
	value = val
	$TextureRect.texture = texture

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		var game = get_tree().get_root().get_node("Game")

		if game.current_turn != 1:
			return  # Not player's turn

		var play_area = game.get_node("PlayArea")

		get_parent().remove_child(self)
		play_area.add_child(self)

		await get_tree().process_frame  # Let the scene update

		# Center the card manually using the size of PlayArea
		var screen_size = get_viewport().get_visible_rect().size
		var card_size = self.size
		self.position = (screen_size - card_size) / 2

		game.current_turn = 2
		game.ai_play_card()
