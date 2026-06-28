extends Node

signal terminal_aberto
signal terminal_fechado
signal inventory_changed
signal slot_selected(slot_index:int)

const HOTBAR_SIZE := 8
var hotbar:Array[item_coletavel]
var selected_slot:int=0
var inventory_enabled := true

func _ready():
	add_to_group("persist")

func _init():
	for i in HOTBAR_SIZE:
		hotbar.append(null)

func add_item(item_novo: item_coletavel)->bool:
	for i in HOTBAR_SIZE:
		if hotbar[i]==null:
			hotbar[i]=item_novo
			inventory_changed.emit()
			selected_slot = clamp(i,0,HOTBAR_SIZE-1)
			slot_selected.emit(i)
			return true
	return false
	
func select_slot(index:int):
	selected_slot = clamp(index,0,HOTBAR_SIZE-1)
	slot_selected.emit(selected_slot)

func remove_item(item_usado: item_coletavel):
	for i in HOTBAR_SIZE:
		if hotbar[i] == item_usado:
			hotbar[i] = null
			inventory_changed.emit()
			if i == selected_slot:
				slot_selected.emit(selected_slot)

func get_selected_item():
	return hotbar[selected_slot]

func save():
	return {
		"path": get_path(),
		"hotbar": hotbar.map(func(e): return e.get_path() if e else null)
	}

func load_self(data: Dictionary):
	for item_salvo in data.get("hotbar"):
		if item_salvo != null: add_item(get_node(item_salvo));
