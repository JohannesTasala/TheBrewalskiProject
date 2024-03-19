extends Node

signal expChanged

var playerMaxHP = 100
var playerCurrentHP = 100

var wheatAmountInventory = 0
var wheatAmountBrewery = 0

var playerExp = 0
var playerLevel = 0
var playerMaxExp = 100

var playerLastPosition = Vector2(0, 0)

var beerAmount = 0


enum INPUT_SCHEMES { KEYBOARD_AND_MOUSE, GAMEPAD }
static var INPUT_SCHEME: INPUT_SCHEMES = INPUT_SCHEMES.KEYBOARD_AND_MOUSE

func AddExp(amount):
	playerExp = playerExp + amount
	expChanged.emit()
