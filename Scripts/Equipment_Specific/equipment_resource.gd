extends Resource
class_name Equipment

@export var name : String
@export var texture : Texture2D
@export var rarity : String
@export var cost : int
@export var description : String

@export var type : Array[String]
@export var index : int

func effect(context, moreContext):
	pass
