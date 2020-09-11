extends CanvasLayer

onready var default_position = $DefaultPosition

const DEFAULT_DURATION = 1
const MESSAGE = preload("res://game/ui/Message.tscn")

var message_stack := []
var message_height : float


func _ready():
	var message = MESSAGE.instance()
	message_height = message.rect_size.y
	message.queue_free()
	set_process(false)


func _process(_delta):
	for i in range(message_stack.size()):
		message_stack[i].rect_position.y = lerp(message_stack[i].rect_position.y,
				message_height * i, .1)


func add_message(text: String, duration: float = DEFAULT_DURATION):
	var message : Message = MESSAGE.instance()
# warning-ignore:return_value_discarded
	message.connect("disappeared", self, "_on_message_disappeared")
	default_position.add_child(message)
	message.set_text(text)
	message.rect_position.y = message_height * message_stack.size()
	message.animate(duration)
	message_stack.append(message)
	set_process(true)


func _on_message_disappeared(message: Message):
	message_stack.erase(message)
	message.queue_free()
	if message_stack.empty():
		set_process(false)
