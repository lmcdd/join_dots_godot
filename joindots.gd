extends Node2D

var dots = []
var backgroundColor =  "#222"
var dotsColor = "#fcfcfc"
var dotsAmount = 50
var h
var w

class Dot:
	var x 
	var y 
	var speed 
	var directionAngle 
	var color
	var radius 
	var d 
	var w
	var h
	var opts = { 
			'defaultSpeed': 1,
			'addedSpeed': 2,
			'defaultRadius': 2,
			'addedRadius': 2,
			'communicationRadius': 150, 
	}
	
	func _init(w,h): 
		self.w = w
		self.h = h
		
		self.x = randi() % int(self.w)
		self.y = randi() % int(self.h)
				
		self.speed = opts.defaultSpeed + randi() % opts.addedSpeed
		self.directionAngle = floor(randi() * 360)
		self.radius = opts.defaultRadius + randi() % opts.addedRadius
		self.d = Vector2(cos(self.directionAngle) * self.speed, sin(self.directionAngle) * self.speed)
		
	func update():
		self.border()
		self.x += self.d.x 
		self.y += self.d.y

	func border():
		if(self.x >= self.w || self.x <= 0):
			self.d.x *= -1
		
		if(self.y >= self.h || self.y <= 0):
			self.d.y *= -1
		
		if self.x > self.w:
			self.x = self.w
		else:
			self.x = self.x
		if self.y > self.h:
			self.y = self.h 
		else:
			self.y
		if self.x < 0: 
			self.x = 0
		else:  
			self.x=self.x
		if self.y < 0: 
			self.y = 0
		else:
			self.y = self.y 

func setup():
	var i = 0
	while i < dotsAmount:
		dots.append(Dot.new(w,h))
		i += 1

func _ready():
	w = get_viewport_rect().size.x
	h = get_viewport_rect().size.y
	setup()
	set_process(true)

func _process(delta):
	for d in dots:
		d.update()
		update()
		
func _draw():
	for d in dots:
		draw_circle(Vector2(d.x, d.y), d.radius, Color(dotsColor))
		var i = 0
		while i < dots.size():
			var distance = Vector2(d.x, d.y).distance_to(Vector2(dots[i].x, dots[i].y))
			var opacity = 1 - distance/d.opts['communicationRadius']
			if (opacity > 0):
				var color = Color(dotsColor)
				color.a = opacity
				draw_line(Vector2(d.x, d.y), Vector2(dots[i].x, dots[i].y), color, 0.5)
			i += 1
	