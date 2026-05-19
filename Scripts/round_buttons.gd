extends Node2D

@onready var container = $Container
const ROUND_BUTTON_TEXTURE := preload("res://Assets/Sprites/game scene items/round_buttons.png")
const ROUND_BUTTON_PRESSED_TEXTURE := preload("res://Assets/Sprites/game scene items/round_buttons_pressed.png")
const BUTTON_PRESS_TIME := 0.15


var mode = 0
var labels = ["Submit", "Shop", "Done"]
var clickable = true
var cooldown = false
var resolving_round = false
@onready
var equipment = load("res://Scenes/equipment.tscn")
var money_threshholds = [0.0, 1.0, 1.5, 2.0, 3.0, 5.0, 10.0, 100.0, 1000.0]
var true_base = 5 #this can change, amount of money someone is guaranteed a round
var selling_equipment = false
var shop_equips = []

func reset_run():
	mode = 0
	clickable = true
	cooldown = false
	selling_equipment = false
	shop_equips.clear()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if get_node("/root/Game/RemoveCardMenu").is_open():
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and clickable and !cooldown and !resolving_round:
		clickable = false
		
		
		var clicked_mode = mode
		await animate_button_press()
		if clicked_mode != 0:
			next_mode()
		
		if clicked_mode == 0 and get_node("/root/Game").is_playing():
			resolving_round = true
			get_node("/root/Game").playing_off()
			#money shit
			var score_node = get_node("/root/Game/Labels/Score")
			var total_score = await score_node.calc()
			await score_node.wait_for_calculation()
			await get_tree().create_timer(1.0).timeout
			if (total_score >= Deck.minimum):
				var score_ratio = total_score / Deck.minimum
				var thresh_index = 0
				for x in range(money_threshholds.size()):
					if score_ratio > money_threshholds[x]:
						thresh_index = x
				var threshold_value = money_threshholds[thresh_index]
				var base_money = (3 * thresh_index) + true_base
				var remaining_ingredients = Deck.hand.size()
				var flour_count = get_flour_multiplier(remaining_ingredients)
				var money_earned = base_money * flour_count
				Score.money += money_earned
				await get_end_round_sign().show_round_results(
					total_score,
					Deck.minimum,
					thresh_index,
					money_earned,
					threshold_value,
					[
						"Base: $" + Lib.num_to_string(base_money),
						"Bonus: x" + Lib.num_to_string(flour_count),
						"Left in hand: " + str(remaining_ingredients)
					]
				)
				get_node("/root/Game/Labels/money/Count").text = Lib.num_to_string(Score.money)
				
				cooldown = true
				await get_tree().create_timer(0.25).timeout
				cooldown = false
				resolving_round = false
				clickable = true
			else:
				get_node("/root/Game").game_over()
			
		elif !get_node("/root/Game/Camera2D").camera_locked:
			if clicked_mode == 1:
				get_end_round_sign().hide_sign()
				get_node("/root/Game/Camera2D").go_to_shop()
				await get_tree().create_timer(0.25).timeout # wait until I am offscreen and then teleport to shop
				position = Vector2(235.6,30)
				selling_equipment = false
				roll_shop_equipment()
				show_shop_equipment()
				
				var locations  = [Vector2(-320, -350), Vector2(-146, -350), Vector2(-320, -170), Vector2(-146, -170)]
				# equipments in shop
				var equips = []
				for i in range(0,4):
					var equip_instance = equipment.instantiate()
					equip_instance.scale = Vector2(4,4)
					equip_instance.position = locations[i]
					var e
					var again = true
					while again:
						again = false
						e = await Equip.generate_random_equipment()
						if Equip.my_equipment.has(e) and e.upgrade_count >= e.max_upgrades: # no equips that are already maxed
							again = true
						for eq in equips: # no dupes in shop or equips that are already max level/cant be upgraded
							if e == eq:
								again = true
					equips.push_back(e)
					if e != null: # if you are out of equipment to buy
						equip_instance.set_equipment(e)
						equip_instance.shop_mode_on()
						container.add_child(equip_instance)
				

				
			else: # DONE mode
				get_end_round_sign().hide_sign()
				get_node("/root/Game").new_round()
				get_node("/root/Game/Camera2D").go_to_game()
				get_node("/root/Game/Pack").visible = true
				await get_tree().create_timer(0.35).timeout # wait until I am offscreen and then teleport to game
				position = Vector2(-94.6,25)
				selling_equipment = false
				shop_equips.clear()
				clear_shop_equipment()

func animate_button_press() -> void:
	$button.texture = ROUND_BUTTON_PRESSED_TEXTURE
	await get_tree().create_timer(BUTTON_PRESS_TIME).timeout
	$button.texture = ROUND_BUTTON_TEXTURE
		
		
func next_mode():
	mode += 1
	if mode == 3:
		mode = 0
	$button.region_rect.position.y = mode * 10
	$Label.text = labels[mode]
	clickable = !resolving_round

func clear_shop_equipment():
	for child in container.get_children():
		child.queue_free()

func roll_shop_equipment():
	shop_equips.clear()
	for i in range(0,4):
		var e
		var again = true
		while again:
			again = false
			e = Equip.generate_random_equipment()
			if Equip.my_equipment.has(e) and e.upgrade_count >= e.max_upgrades: # no equips that are already maxed
				again = true
			for eq in shop_equips: # no dupes in shop or equips that are already max level/cant be upgraded
				if e == eq:
					again = true
			print(e.name + " - " + str(again))
			print(e.upgrade_count)
			print(e.max_upgrades)
		shop_equips.push_back(e)

func show_shop_equipment():
	clear_shop_equipment()
	var locations  = [Vector2(-320, -350), Vector2(-146, -350), Vector2(-320, -170), Vector2(-146, -170)]
	for i in range(shop_equips.size()):
		var equip_instance = equipment.instantiate()
		equip_instance.scale = Vector2(4,4)
		equip_instance.position = locations[i]
		var e = shop_equips[i]
		if e != null: # if you are out of equipment to buy
			equip_instance.set_equipment(e)
			equip_instance.shop_mode_on()
			container.add_child(equip_instance)

func remove_shop_equipment(equipment_to_remove: Equipment):
	shop_equips.erase(equipment_to_remove)

func show_sell_equipment():
	clear_shop_equipment()
	var locations := [
		Vector2(-125, -320), Vector2(-15, -320), Vector2(95, -320),
		Vector2(-125, -200), Vector2(-15, -200), Vector2(95, -200),
		Vector2(-125, -80), Vector2(-15, -80), Vector2(95, -80)
	]
	var owned_equipment = Equip.get_my_equipment()
	for i in range(min(owned_equipment.size(), locations.size())):
		var equip_instance = equipment.instantiate()
		equip_instance.scale = Vector2(2.5, 2.5)
		equip_instance.tooltip_scale(.35,-180, -320)
		equip_instance.position = locations[i]
		equip_instance.sell_mode_on()
		equip_instance.set_equipment(owned_equipment[i])
		container.add_child(equip_instance)

func toggle_sell_equipment():
	if mode != 2 or get_node("/root/Game/Camera2D").camera_locked:
		return
	selling_equipment = !selling_equipment
	if selling_equipment:
		show_sell_equipment()
	else:
		show_shop_equipment()

func refresh_sell_equipment():
	if selling_equipment:
		show_sell_equipment()

func get_end_round_sign():
	return get_node("/root/Game/EndRoundSign")

func get_flour_multiplier(remaining_ingredients: int) -> float:
	var total_multiplier := 1.0
	for current_equipment in Equip.get_my_equipment():
		if current_equipment is Flour:
			total_multiplier *= pow(current_equipment.get_money_multiplier_per_remaining_ingredient(), remaining_ingredients)
	return total_multiplier
