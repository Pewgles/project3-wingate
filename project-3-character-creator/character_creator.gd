extends Control

@onready var head_sprite = $TheDudeHimself/Head
@onready var body_sprite = $TheDudeHimself/Body
@onready var legs_sprite = $TheDudeHimself/Legs

@onready var head_slider = $UI/HeadSizeSlider
@onready var code_input = $UI/CodeInput

var head_options = []
var body_options = []
var legs_options = []
var head_index = 0
var body_index = 0
var legs_index = 0

func _ready():
	head_options = [
		preload("res://assets/head1.png"),
		preload("res://assets/head2.png"),
		preload("res://assets/head3.png")
	]
	body_options = [
		preload("res://assets/body1.png"),
		preload("res://assets/body2.png"),
		preload("res://assets/body3.png")
	]
	legs_options = [
		preload("res://assets/legs1.png"),
		preload("res://assets/legs2.png"),
		preload("res://assets/legs3.png")
	]
	update_character()

	$UI/HeadControls/HeadPrevButton.pressed.connect(prev_head)
	$UI/HeadControls/HeadNextButton.pressed.connect(next_head)
	$UI/BodyControls/BodyPrevButton.pressed.connect(prev_body)
	$UI/BodyControls/BodyNextButton.pressed.connect(next_body)
	$UI/LegsControls/LegsPrevButton.pressed.connect(prev_legs)
	$UI/LegsControls/LegsNextButton.pressed.connect(next_legs)
	head_slider.value_changed.connect(change_head_size)
	$UI/CodeInput/LoadButton.pressed.connect(load_code)

func update_character():
	head_sprite.texture = head_options[head_index]
	body_sprite.texture = body_options[body_index]
	legs_sprite.texture = legs_options[legs_index]
	update_code()

func update_code():
	var code = str(head_index) + str(body_index) + str(legs_index)
	code_input.text = code

func next_head():
	head_index += 1
	if head_index >= head_options.size():
		head_index = 0
	update_character()

func prev_head():
	head_index -= 1
	if head_index < 0:
		head_index = head_options.size() - 1
	update_character()

func next_body():
	body_index += 1
	if body_index >= body_options.size():
		body_index = 0
	update_character()

func prev_body():
	body_index -= 1
	if body_index < 0:
		body_index = body_options.size() - 1
	update_character()

func next_legs():
	legs_index += 1
	if legs_index >= legs_options.size():
		legs_index = 0
	update_character()

func prev_legs():
	legs_index -= 1
	if legs_index < 0:
		legs_index = legs_options.size() - 1
	update_character()

func change_head_size(value):
	head_sprite.scale = Vector2(value, value)

func load_code():
	var code = code_input.text
	if code.length() < 3:
		return
	head_index = int(code[0])
	body_index = int(code[1])
	legs_index = int(code[2])
	head_index = clamp(head_index, 0, head_options.size() - 1)
	body_index = clamp(body_index, 0, body_options.size() - 1)
	legs_index = clamp(legs_index, 0, legs_options.size() - 1)
	update_character()
