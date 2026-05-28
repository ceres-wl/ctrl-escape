extends HBoxContainer

@onready var icon = $"../../Zoom_item/imagem_item"
@onready var title = $"../../Zoom_item/nome_item"
var slots:Array

func _ready():
	get_slots()
	#Inventory.inventory_changed.connect(_update_hotbar)
	Inventory.slot_selected.connect(_highlight_slot)
	#_update_hotbar()

func get_slots():
	slots = get_children()
	for slot : TextureButton in slots:
		slot.pressed.connect(Inventory.select_slot.bind(slot.get_index()))
'''
func _update_hotbar():
	for slot:TextureButton in slots:
		var item = Inventory.hotbar[slot.get_index()]
		slot.texture_normal = item.icon if item else null
'''
func _highlight_slot(slot_index:int):
	for i in range(8):
		slots[i].modulate = Color(1,1,1)
		var label = slots[i].get_node("Label")
		label.visible = false
	slots[slot_index].modulate = Color(1.2,1.2,1.2)
	var selected_label = slots[slot_index].get_node("Label")
	selected_label.visible = true
'''
func show_item(item: Nome do tipo de item):
	icon.texture = item.icon
	title.text = item.item_name
	$"../../Zoom_item".visible = true

func _input(event):
	if event.is_action_pressed("usar_item"):
		var item = Inventory.get_selected_item()
		if item:
			show_item(item)
'''
