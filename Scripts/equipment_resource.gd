extends Resource
class_name Equipment

@export var name : String
@export var texture : Texture2D
@export var rarity : String
@export var cost : int
@export var description : String

@export var type : Array[String]

func effect(context, moreContext):
	print("bruh")
	pass
