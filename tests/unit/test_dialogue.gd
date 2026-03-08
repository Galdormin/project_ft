extends GutTest

const DIALOGUE_FOLDER: String = "res://dialogue"

## Return all dialogue file within the dialogue folder.
func get_all_dialogue() -> PackedStringArray:
    return TestUtils.get_files_recursive(DIALOGUE_FOLDER, "dialogue")

## Test that all character names in dialogue exists and are well written
func test_character_names():
    var accepted_character := CharacterManager.all_characters() + ["Narrateur"]
    
    for dialogue_file in get_all_dialogue():
        var dialogue: DialogueResource = load(dialogue_file)
        for char in dialogue.character_names:
            assert_has(accepted_character, char, "dialogue '%s' has unsupported character '%s'" % [dialogue_file, char])


## Test that all emotions tags (e.g. #[mood=Angry]) are correctly written
func test_emotion_metadata():
    for dialogue_file in get_all_dialogue():
        var dialogue: DialogueResource = load(dialogue_file)
        for line_data in dialogue.lines.values():
            if line_data["type"] != "dialogue" or "tags" not in line_data:
                continue
            
            var line = DialogueLine.new(line_data)
            var mood = line.get_tag_value("mood")
            if mood != "":
                assert_true(CharacterPortrait.is_mood(mood), "Tag: '%s' should be parsed as Emotion." % mood)
