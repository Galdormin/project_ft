extends GutTest

const DIALOGUE_FOLDER: String = "res://dialogue"

## Return all dialogue file within the dialogue folder.
func get_all_dialogue() -> PackedStringArray:
    return TestUtils.get_files_recursive(DIALOGUE_FOLDER, "dialogue")

## Test that all character names in dialogue exists and are well written
func test_character_names():
    var accepted_character := ["Narrateur", "Robin", "Hortense"]
    
    for dialogue_file in get_all_dialogue():
        var dialogue: DialogueResource = load(dialogue_file)
        for char in dialogue.character_names:
            assert_has(accepted_character, char, "dialogue '%s' has unsupported character '%s'" % [dialogue_file, char])
