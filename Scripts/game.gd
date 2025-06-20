extends Node2D

const SUITS = ["hearts", "spades", "diamonds", "clubs"]
const RANKS = ["02", "03", "04", "05", "06", "07", "08", "09", "10", "J", "Q", "K", "A"]
const CARD_SCENE = preload("res://scenes/card.tscn")

@onready var player_hand = $PlayerHand

var deck = []

func _ready():
	create_deck()
	shuffle_deck()
	deal_cards(13)

func create_deck():
	deck.clear()
	for suit in SUITS:
		for rank in RANKS:
			var texture = load("res://Assets/Cards/card_%s_%s.png" % [suit, rank])
			var value = RANKS.find(rank) + 1
			deck.append({ "suit": suit, "rank": rank, "value": value, "texture": texture })
	print("Created deck")

func shuffle_deck():
	deck.shuffle()
	print("Shuffled Deck")

func deal_cards(count):
	for i in range(count):
		var card_data = deck.pop_front()
		var card = CARD_SCENE.instantiate()
		card.set_card_data(card_data.suit, card_data.rank, card_data.value, card_data.texture)
		player_hand.add_child(card)
		print("Added card: ", card_data.rank, " Of ", card_data.suit)
	print("Cards Dealt")
