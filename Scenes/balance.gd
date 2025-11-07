extends Label

var balance = 0

func set_balance(v):
	balance = v
	display_balance()

func change_balance(v):
	balance += v
	display_balance()

func display_balance():
	text = str(balance)
