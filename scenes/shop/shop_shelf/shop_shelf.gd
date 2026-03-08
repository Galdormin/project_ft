extends Node2D

@onready var flower_container: Node2D = %FlowerContainer
@onready var flower_description: FlowerDescriptionPanel = %FlowerDescription

func _ready() -> void:
    for child in flower_container.get_children():
        if child is not Flower:
            Loggie.warn("Non Flower node found in FlowerContainer.")
            continue
        
        var flower = child as Flower
        flower.pressed.connect(flower_description.open.bind(flower.flower_data))
