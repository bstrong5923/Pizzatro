extends Resource
class_name Equipment

@export var name : String
@export var texture : Texture2D
@export var rarity : String
@export var cost : int
@export var description : String

@export var type : Array[String]
@export var index : int

@export_group("triggers") 
@export var card_played : bool

func on_card_played(input):
	pass
