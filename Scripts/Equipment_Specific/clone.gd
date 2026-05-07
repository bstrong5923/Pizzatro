extends Equipment
class_name Clone

var last_played = null
var done = false

func on_card_played(ingredient):
  if !done and last_played:
    if last_played == ingredient:
      Deck.deck.push_back(last_played)
      done = true
	last_played = ingredient

func on_submit():
  done = false
  last_played = null

func upgrade():
	pass
