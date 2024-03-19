extends Node


const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerCurrentHP,
		"WheatInventory": Game.wheatAmountInventory,
		"WheatBrewery": Game.wheatAmountBrewery,
		"playerExp": Game.playerExp,
		"playerLevel": Game.playerLevel,
		"currentQuest": Quest.currentQuest,
		"questProgress": Quest.questProgress,
		"questAccepted": Quest.questAccepted,
		"beerAmount": Game.beerAmount,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerCurrentHP = current_line["playerHP"]
				Game.wheatAmountInventory = current_line["WheatInventory"]
				Game.wheatAmountBrewery = current_line["WheatBrewery"]
				Game.playerExp = current_line["playerExp"]
				Game.playerLevel = current_line["playerLevel"]
				Quest.currentQuest = current_line["currentQuest"]
				Quest.questProgress = current_line["questProgress"]
				Quest.questAccepted = current_line["questAccepted"]
				Game.beerAmount = current_line["beerAmount"]
