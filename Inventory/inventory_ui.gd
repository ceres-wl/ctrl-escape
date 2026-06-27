extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Inventory.terminal_aberto.connect(_on_terminal_aberto)
	Inventory.terminal_fechado.connect(_on_terminal_fechado)

func _on_barra_recolher_pressed() -> void:
	$inventory_hotbar.visible = false
	$barra_expandir.visible = true
	Inventory.inventory_enabled = false

func _on_barra_expandir_pressed() -> void:
	$inventory_hotbar.visible = true
	$barra_expandir.visible = false
	Inventory.inventory_enabled = true

func _on_terminal_aberto() -> void:
	$inventory_hotbar.visible = false
	$barra_expandir.visible = false
	Inventory.inventory_enabled = false

func _on_terminal_fechado() -> void:
	$inventory_hotbar.visible = true
	$barra_expandir.visible = false
	Inventory.inventory_enabled = true

func _on_x_pressed() -> void:
	$"Zoom_item".visible = false
