extends Reference
class_name Dot

var x
var y 
var speed 
var dir_angle 
var color
var radius 
var d 
var w
var h

var opts = { 
		'default_speed': 1,
		'added_speed': 2,
		'default_r': 2,
		'added_r': 2,
		'communication_r': 150, 
}


func _init(width:int, height:int, c: Color) -> void: 
	w = width
	h = height
	color = c
		
	x = randi() % int(w)
	y = randi() % int(h)
				
	speed = opts.default_speed + randi() % opts.added_speed
	dir_angle = floor(randi() * 360)
	radius = opts.default_r + randi() % opts.added_r
	d = Vector2(cos(dir_angle) * speed, sin(dir_angle) * speed)


func border() -> void:
	if(x >= w || x <= 0):
		d.x *= -1

	if(y >= h || y <= 0):
		d.y *= -1
		
	if x > w:
		x = w

	if y > h:
		y = h 
	
	if x < 0: 
		x = 0

	if y < 0: 
		y = 0


func update() -> void:
	border()
	x += d.x 
	y += d.y
