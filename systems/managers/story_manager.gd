extends Node


var is_waiting_for_flower: bool = false
var try_amount: int = 0

var selected_flower: String
var given_flower: String


## Pre-select the flower to give to a customer 
func select_flower(flower: String) -> void:
    selected_flower = flower

## Give the pre-selected flower to the customer
func give_flower() -> void:
    is_waiting_for_flower = false
    given_flower = selected_flower
    selected_flower = ""
