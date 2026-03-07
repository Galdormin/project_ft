class_name CharacterPortrait
extends Resource

enum Mood {
    NEUTRAL,
    HAPPY,
    ANGRY,
    SAD,
}

enum Orientaion {
    LEFT,
    RIGHT,
}

@export var default_orientation: CharacterPortrait.Orientaion
@export var sprites: Dictionary[CharacterPortrait.Mood, Texture2D]
@export var recap_portrait: Texture2D


static func is_mood(mood: String) -> bool:
    return mood.to_lower() in ["neutral", "happy", "angry", "sad"]

static func as_mood(mood: String) -> CharacterPortrait.Mood:
    match mood.to_lower():
        "neutral":
            return Mood.NEUTRAL
        "happy":
            return Mood.HAPPY
        "angry":
            return Mood.ANGRY
        "sad":
            return Mood.SAD
        _:
            Loggie.error("Cannot parse %s as CharacterPortrait.Mood, NEUTRAL returned." % mood)
            return Mood.NEUTRAL
