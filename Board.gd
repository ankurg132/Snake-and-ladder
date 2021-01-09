extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pname = 1
var dicePose = [79.46,958.187]
var playerRun = [0,0]
var DiceFace = 0
var localPos = [29.707,833.983]
var countp1 = -1
var countp2 = -1
var snakeStart = [26]
var snakeEnd = [5]
var ladderStart = [2]
var ladderEnd = [24]
onready var pathFinder = [$Path2D/Blue/Sprite,$Path2D/Red/Sprite]

# Called when the node enters the scene tree for the first time.
func _ready():
	$DiceFaces.show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	$DiceMusic.play()
	randomize()
	DiceFace = randi() % 6 +1
	$DiceFaces.set_frame(DiceFace - 1) # Replace with function body.
	pname = !pname
	var pathpos = $Path2D.get_curve().get_point_position(0)
	if not pname:
		$Label.text = "PLAYER 2"
		if countp2==-1:
			countp2=0
			countp2 = checkCount(countp2)
			pathpos = $Path2D.get_curve().get_point_position(countp2)
			pathpos.x -= localPos[0]
			pathpos.y -= localPos[1]
			pathpos.y += 15
			pathFinder[1].position = pathpos
		else:
			countp2 += DiceFace
			countp2 = checkCount(countp2)
			pathpos = $Path2D.get_curve().get_point_position(countp2)
			pathpos.x -= localPos[0]
			pathpos.y -= localPos[1]
			pathpos.y += 15
			pathFinder[1].position = pathpos
		checkwin(countp2)
	else:
		$Label.text = "PLAYER 1"
		if countp1==-1:
			countp1=0
			countp1 = checkCount(countp1)
			pathpos = $Path2D.get_curve().get_point_position(countp1)
			pathpos.x -= localPos[0]
			pathpos.y -= localPos[1]
			pathFinder[0].position = pathpos
		else:
			countp1 += DiceFace
			countp1 = checkCount(countp1)
			pathpos = $Path2D.get_curve().get_point_position(countp1)
			pathpos.x -= localPos[0]
			pathpos.y -= localPos[1]
			pathFinder[0].position = pathpos
		checkwin(countp1)

func checkCount(c):
	for i in len(snakeStart):
		if c == snakeStart[i]:
			return snakeEnd[i]
	for j in len(ladderStart):
		if c == ladderStart[j]:
			return ladderEnd[j]	
	return c

func checkwin(c):
	if c>=100:
		if c == countp1:
			$Label.text = "PLAYER 1 HAS WON THE GAME"
		else:
			$Label.text = "PLAYER 2 HAS WON THE GAME"
		$DiceFaces/Button.disabled = true


func _on_Quit_pressed():
	get_tree().quit()
	
func _on_Restart_pressed():
	get_tree(). reload_current_scene()  # Replace with function body.
