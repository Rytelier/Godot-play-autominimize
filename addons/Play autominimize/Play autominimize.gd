@tool
extends EditorPlugin

var autoMinimizae : bool = true
var isRunning : bool
var screenModePrevious

var switch

func _enter_tree():
	switch = CheckBox.new()
	switch.text = "Auto minimize"
	switch.button_pressed = true
	switch.toggled.connect(Switch.bind())
	add_control_to_container(CONTAINER_TOOLBAR, switch)

func  _exit_tree():
	remove_control_from_container(CONTAINER_TOOLBAR, switch)
	switch.queue_free()

func  _process(delta):
	if not autoMinimizae: return
	
	if EditorInterface.is_playing_scene() and not isRunning:
		isRunning = true
		screenModePrevious = get_window().mode
		get_window().mode = Window.MODE_MINIMIZED
	elif not EditorInterface.is_playing_scene() and isRunning:
		isRunning = false
		get_window().mode = screenModePrevious

func Switch(b):
	autoMinimizae = b
	if(not b): isRunning = false
