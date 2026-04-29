extends Equipment
class_name Pepsi

var milk_texture = preload("res://Assets/Sprites/card_comps/big_ingredients/milk.png")
var pilk_texture = preload("res://Assets/Sprites/card_comps/big_ingredients/pilk.png")
var milk_minis = preload("res://Assets/Sprites/ingredient_minis/milk_minis.png")
var pilk_minis = preload("res://Assets/Sprites/ingredient_minis/pilk_minis.png")
var milk_resource = load("res://Assets/cards/Milk.tres")

var milk_desc = milk_resource.description
var pilk_desc = "PILK! PIIIIIIIIILK!!!! GIVE ME MORE PILK!!!!!!"
func on_bought(g): # main function
	change_to("Pilk",[16.0,16.0,16.0,16.0,16.0], pilk_texture, pilk_desc, pilk_minis)

func on_sold():
	change_to("Milk",[0.0,0.0,0.0,7.0,2.0], milk_texture, milk_desc, milk_minis)

func change_to(n, flavors, t, desc, minis):
	milk_resource.name = n
	for i in milk_resource.flavors.size():
		milk_resource.flavors[i] = flavors[i]
	milk_resource.texture = t
	milk_resource.description = desc
	milk_resource.minis = minis
	for c in Deck.deck.size():
		if Deck.deck[c].name == "Milk":
			Deck.deck[c] = milk_resource
	#for c in Deck.shop_hand.size():
		#if Deck.shop_hand[c].name == "Milk":
			#Deck.shop_hand[c] = milk_resource
			
	print(Deck.deck)
	print(Deck.shop_hand)
	
func on_submit(score): # boring milkless function
	score.flavor_values[0] += 7
