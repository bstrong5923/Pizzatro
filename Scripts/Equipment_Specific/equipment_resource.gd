extends Resource
class_name Equipment

@export var name : String
@export var texture : Texture2D
@export var rarity : String
@export var cost : int
@export var description : String
@export var upgrade_count : int = 0

@export var type : Array[String]
@export var index : int

@export_group("triggers") 
@export var card_played : bool
@export var bought : bool
@export var round_start : bool
@export var submit : bool

func on_card_played(input):
	pass

func on_bought(input):
	pass

func on_round_start(input):
	pass

func on_submit(input):
	pass

func apply_upgrade():
	upgrade_count += 1
	upgrade()

func get_display_name() -> String:
	return name + "+".repeat(upgrade_count)

func upgrade():
	pass
