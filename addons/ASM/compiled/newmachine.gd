class_name test


var state_machine:StateMachine = StateMachine.new(self)

enum STATE_MAIN {}


func _initialize_machines(): 
	
	state_machine.register_state(STATE_MAIN.STATE_3161026589,"state_3161026589",false,false)

	state_machine.start()



func _ready(): 
	_initialize_machines()


func _process(delta): 
	state_machine.machine_update()


func st_update_state_3161026589(): 
	#TODO: action on update
	pass


