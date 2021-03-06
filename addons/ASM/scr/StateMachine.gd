class_name StateMachine

var target
var parent:StateMachine = null
var id:int = -1
var machine:Dictionary = {
	state=null,
	funcs={
		init={},
		update={},
		exit={}
		}
	}

func _init(_target):
	self.target = _target

func register_state(state_const:int,name:String,has_init:bool=true,has_exit:bool=false):
#	machine.child_of[child_of].append({state=state_const,call_parent_update=call_parent_update})
	if (has_init):
		machine.funcs.init[state_const] = funcref(target,"st_init_"+name)
	machine.funcs.update[state_const] = funcref(target,"st_update_"+name)
	if (has_exit):
		machine.funcs.exit[state_const] = funcref(target,"st_exit_"+name)

func register_parent(p:StateMachine,state_const:int):
	parent = p
	self.id = state_const
	pass

func register_state_array(states_const:Array,names:Array):
	for i in states_const.size():
		register_state(states_const[i],names[i],true,true)

func machine_update():
	machine.funcs.update[machine.state].call_func()

func start():
	machine.state = 0

func change_state(to,first:bool=false):
	if !first:
		if machine.funcs.exit.has(machine.state):
			machine.funcs.exit[machine.state].call_func()
	machine.state = to
	check_parent()
	if machine.funcs.init.has(machine.state):
		machine.funcs.init[to].call_func() #call the init function from next state

func check_parent() -> bool:
	if parent == null: return false
	if parent.get_current_state() != self.id:
		parent.change_state(self.id)
		return true
	return false

func get_current_state() -> int: return machine.state

func state_is(state:int) -> bool: 
	if machine.state == state: 
		return true
	return false
