extends Area2D
signal hit

@export var speed = 400
var screen_size
var playable_area
var starting_area
# Called when the node enters the scene tree for the first time.
func _ready():
	print("makeplayer")
	screen_size = get_viewport_rect().size
	playable_area = screen_size
	starting_area = screen_size
	playable_area.x -= 100
	playable_area.y -= 100
	starting_area.x = 100
	starting_area.y = 100
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
			
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
			
	position += velocity * delta
	position = position.clamp(starting_area, playable_area)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	print("showplayer")
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
