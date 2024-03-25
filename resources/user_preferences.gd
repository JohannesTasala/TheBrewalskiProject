class_name UserPreferences extends Resource

@export_range(0, 1, .05) var sfx_audio_level: float = 1.0
@export var input_type: Game.INPUT_SCHEMES =  Game.INPUT_SCHEMES.KEYBOARD_AND_MOUSE


func save():
	ResourceSaver.save(self, "user://user_prefs.tres")
	
static func load_or_create() -> UserPreferences:
	var res: UserPreferences = load("user://user_prefs.tres") as UserPreferences
	if !res:
		res = UserPreferences.new()
	return res
