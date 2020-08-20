extends Camera2D


export(NodePath) var Player_Path
var player
var goalPoint
var velocity = 0
var screensize;

#Look ahead vars
export(float,0.1,32) var smoothSpeed = 0.6;
export(float,0,200) var boundH=100;
export(float,0,200) var boundV=80;
var marginL;
var marginR;
var marginU;
var marginD;
var lookAheadOffsetExtent = Vector2.ZERO;
export (Vector2) var lookAheadOffsetGoal = Vector2.ZERO;
export (Vector2) var lookAheadOffset = Vector2.ZERO;
export(float,0.001,10) var lookAheadSmoothTime = float(1);
var lookAheadSmoothSpeed = float(0);
export (float) var lookCoolTime = float(1);#time to cooldown before can recenter view
var lookHCooler = float(0);
var lookVCooler = float(0);
var wasInput = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(Player_Path)
	global_position = player.global_position
	goalPoint = global_position
	screensize=self.get_viewport_rect().size;
	marginR=screensize.x*0.5*drag_margin_right;
	marginL=screensize.x*0.5*drag_margin_left;
	marginU=screensize.y*0.5*drag_margin_top;
	marginD=screensize.y*0.5*drag_margin_bottom;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	checkPushMargins();
	moveToLookAheadGoal(_delta);
	applyLookAhead();
	boundOffset();
	lookHCooler = clamp(lookHCooler-_delta,0,lookCoolTime);
	lookVCooler = clamp(lookVCooler-_delta,0,lookCoolTime);
#	var dist = (player.global_position - global_position).length_squared()
#	if abs(dist) > 2000:
#		updateGoal(player.global_position - global_position)
#	var cur = global_position
#	var d = (goalPoint - cur) * 0.01
#	global_position += d
	#global_position = player.global_position;

func updateGoal(vec):
	goalPoint = player.global_position + (1 * vec)

#Check whether player is pushing the margin box
func checkPushMargins():
	var dist = get_camera_position()-(get_camera_screen_center()-offset);
	#print(dist);
	wasInput=false;
	if (dist.x>=0.7*marginR && Input.is_action_pressed('right')):
		lookAheadOffsetExtent.x = boundH;
		lookAheadOffsetGoal = lookAheadOffsetExtent;
		#lookAheadOffset += Vector2.RIGHT*smoothSpeed;
		lookHCooler=lookCoolTime;
		if(lookVCooler<=0):
			lookAheadOffsetGoal.y = 0;
		wasInput=true;
		#print("right")
	elif (dist.x<=-0.7*marginL && Input.is_action_pressed('left')):
		lookAheadOffsetExtent.x = -boundH;
		lookAheadOffsetGoal = lookAheadOffsetExtent;
		#lookAheadOffset += Vector2.LEFT*smoothSpeed;
		lookHCooler=lookCoolTime;
		if(lookVCooler<=0):
			lookAheadOffsetGoal.y = 0;
		wasInput=true;
		#print("left")
	elif Input.is_action_just_released("right") || Input.is_action_just_released("left"):
		var d = (lookAheadOffsetExtent-lookAheadOffset);
		if(abs(d.x)>2):
			lookAheadOffsetGoal = lookAheadOffset+d*0.25
			
	if (dist.y>=0.7*marginD && Input.is_action_pressed('down')):
		lookAheadOffsetExtent.y = boundV;
		lookAheadOffsetGoal = lookAheadOffsetExtent;
		#lookAheadOffset += Vector2.DOWN*smoothSpeed;
		lookVCooler=lookCoolTime;
		if(lookHCooler<=0):
			lookAheadOffsetGoal.x = 0;
		wasInput=true;
		#print("down")
	elif (dist.y<=-0.7*marginU &&  Input.is_action_pressed('up')):
		lookAheadOffsetExtent.y = -boundV;
		lookAheadOffsetGoal = lookAheadOffsetExtent;
		#lookAheadOffset += Vector2.UP*smoothSpeed;
		lookVCooler=lookCoolTime;
		if(lookHCooler<=0):
			lookAheadOffsetGoal.x = 0;
		wasInput=true;
		#print("up")
	elif Input.is_action_just_released("up") || Input.is_action_just_released("down"):
		var d = (lookAheadOffsetExtent-lookAheadOffset);
		if(abs(d.y)>2):
			lookAheadOffsetGoal = lookAheadOffset+d*0.25
			
	pass;
	
func boundOffset():
	lookAheadOffset.x =clamp(lookAheadOffset.x,-boundH,boundH);
	lookAheadOffset.y =clamp(lookAheadOffset.y,-boundV,boundV);

func moveToLookAheadGoal(_delta):
	#based on unity Smoothdamp algorithm
	var om = 2/self.lookAheadSmoothTime;
	var x = om*_delta;
	var ex = 1/(1+x+0.48*x*x+0.235*x*x*x);
	var diff = lookAheadOffset-lookAheadOffsetGoal;
	var te = (lookAheadSmoothSpeed*Vector2.ONE+om*diff)*_delta;
	lookAheadSmoothSpeed= (lookAheadSmoothSpeed*Vector2.ONE-om*te)*ex;
	var result = lookAheadOffsetGoal+(diff+te)*ex;
	#prevent overshoot
	###
	lookAheadOffset = result;
	pass;
	
func applyLookAhead():
	self.offset = lookAheadOffset;
	
