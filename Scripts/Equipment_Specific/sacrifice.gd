extends Equipment
class_name Sacrifice

var done = false
var multiplier = 5

func on_card_played(ingredient):
  if !done:
      for f in CardFunction.flavors_to_add.size():
			  CardFunction.flavors_to_add[f] *= multiplier
      Deck.deck.remove_at(Deck.deck.find(ingredient))
      done = true

func on_submit():
  done = false

func upgrade():
	pass
