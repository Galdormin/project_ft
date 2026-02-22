class_name CharacterPortrait
extends Resource

enum Emotion {
    HAPPY,
    ANGRY,
    SAD,
}

enum Orientaion {
    LEFT,
    RIGHT,
}

@export var name: String
@export var default_orientation: CharacterPortrait.Orientaion
@export var sprites: Dictionary[CharacterPortrait.Emotion, Texture2D]


static func is_emotion(emotion: String) -> bool:
    return emotion.to_lower() in ["happy", "angry", "sad"]

static func as_emotion(emotion: String) -> CharacterPortrait.Emotion:
    match emotion.to_lower():
        "happy":
            return Emotion.HAPPY
        "angry":
            return Emotion.ANGRY
        "sad":
            return Emotion.SAD
        _:
            Loggie.error("Cannot parse %s as CharacterPortrait.Emotion, HAPPY returned." % emotion)
            return Emotion.HAPPY
