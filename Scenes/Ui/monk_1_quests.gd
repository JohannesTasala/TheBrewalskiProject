extends Control


@onready var QuestScene = $"."
@onready var questLabel = $BoxContainer/QuestLabel
@onready var buttons = $BoxContainer/buttonContainer
@onready var yesB = $BoxContainer/buttonContainer/Yes

var tempQuestNumber
var tempQuestProgress
var tempQuestAccepted

var quest1Goal = 4
var quest2Goal = 30


func _ready():
	Quest.questCompleted.connect(completedQuest)
	Quest.updateQuest.connect(questUpdate)
	tempQuestNumber = Quest.currentQuest
	tempQuestProgress = Quest.questProgress
	tempQuestAccepted = Quest.questAccepted
	if tempQuestAccepted == true:
		QuestScene.show()
		questLabel.show()
		buttons.hide()
		if Quest.currentQuest == 0:
			questLabel.text = str(Quest.questProgress, "/", quest1Goal, " wheats")
		elif Quest.currentQuest == 1:
			questLabel.text = str(Quest.questProgress, "/", quest2Goal, " wheats")
		
	
	
	

	
func questUpdate():
	tempQuestNumber = Quest.currentQuest
	if tempQuestNumber == 0:
		quest1()
	elif tempQuestNumber == 1:
		quest2()
	else:
		QuestScene.show()
		questLabel.text = str("Sorry, no more quests!")
		questLabel.show()
		buttons.hide()
		await get_tree().create_timer(4).timeout
		questLabel.hide()
		
		
func quest1():
	if Quest.questAccepted == false:
		get_tree().paused = true
		QuestScene.show()
		questLabel.text = str("Can you get me ", quest1Goal," wheats?")
		questLabel.show()
		buttons.show()
		yesB.grab_focus()
	elif Quest.questAccepted == true:
		#this is quest 1 progress
		tempQuestProgress = Game.wheatAmountInventory + Quest.questProgress
		if tempQuestProgress < quest1Goal:
			#wheat deposited but still not enough to complete the quest
			Game.wheatAmountInventory = 0
			Quest.questProgress = tempQuestProgress
			tempQuestProgress = 0
			
		else :
			#wheat deposited and enough to complete the quest
			var tempInt = quest1Goal - Quest.questProgress
			Game.wheatAmountInventory = Game.wheatAmountInventory - absi(tempInt)
			Game.beerAmount = Game.beerAmount + 4
			completedQuest()
			return
		
		questLabel.text = str(Quest.questProgress, "/", quest1Goal, " wheats")
	
func quest2():
	if Quest.questAccepted == false:
		get_tree().paused = true
		QuestScene.show()
		questLabel.text = str("Can you get me ", quest2Goal, " wheats?")
		questLabel.show()
		buttons.show()
		yesB.grab_focus()
	elif Quest.questAccepted == true:
		#this is quest 2 progress
		tempQuestProgress = Game.wheatAmountInventory + Quest.questProgress
		if tempQuestProgress < quest2Goal:
			#wheat deposited but still not enough to complete the quest
			Game.wheatAmountInventory = 0
			Quest.questProgress = tempQuestProgress
			tempQuestProgress = 0
			
		else :
			#wheat deposited and enough to complete the quest
			var tempInt = quest2Goal - Quest.questProgress
			Game.wheatAmountInventory = Game.wheatAmountInventory - absi(tempInt)
			Game.beerAmount = Game.beerAmount + 15
			completedQuest()
			return
		
		questLabel.text = str(Quest.questProgress, "/", quest2Goal," wheats")
	
func completedQuest():
	print("Quest completed")
	questLabel.text = str("Quest completed")
	Quest.questProgress = 0
	Quest.currentQuest = Quest.currentQuest + 1
	Quest.questAccepted = false
	tempQuestProgress = 0


func _on_yes_pressed():
	print("quest accepted")
	buttons.hide()
	get_tree().paused = false
	Quest.questAccepted = true
	questUpdate()


func _on_no_pressed():
	QuestScene.hide()
	get_tree().paused = false
