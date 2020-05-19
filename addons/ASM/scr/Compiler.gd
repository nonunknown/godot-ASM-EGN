class_name Compiler

var source_code = ""
var all_states = []
var source:Dictionary = {
	cn = "class_name %class_name%",
	#	state machines declaration
	smd = "var %machine_name%:StateMachine = StateMachine.new(self)",
	# eum declarations
	ed = "enum STATE_%type% {%names%}",
	# parent declarations (if any)
	pd = "%machine_name%.register_parent(%parent_machine_ref%,%child_id%)",
	# states declaration
	sd = "%machine_name%.register_state(%state_enum%,\"%func_name%\",%has_init%,%has_exit%)",
	# start machines
	sm = "%machine_name%.start()",
	# state functions
	sf = "func st_%type%_%state_name%(): \n\t%action%\n\tpass\n\n\n",
	# possible actions
	pa = {
		update="%machine_name%.machine_update()",
		change_state="%machine_name%.change_state(%state_enum%)"
	}
	
	
}

func compile_state_machine(target:Node):
	source_code = ""
	var containers = []
	var states = []
	containers  = target.get_tree().get_nodes_in_group("ASM_CONTAINER")
	states = target.get_tree().get_nodes_in_group("ASM_STATE")
	all_states = target.get_tree().get_nodes_in_group("ASM_GN")
	_generate_script(containers,states)
	_save_script()

func _generate_script(containers:Array, states:Array):
	var cn = source.cn
	source_code += cn.replace("%class_name%","test")
	_jump_lines(3)
	
	#main state machine
	var smd =  source.smd
	smd = smd.replace("%machine_name%","state_machine")
	source_code += smd
	_jump_lines(1)
	
	#other states
	for container in containers:
		var state_declaration = source.smd
		var state:State = container.get_state()
		var name = state.name.to_lower()
		state_declaration = state_declaration.replace("%machine_name%","machine_"+name)
		source_code += state_declaration
		_jump_lines(1)
	_jump_lines(1)
	
	#main enum
	var ed = source.ed
	ed = ed.replace("%type%","MAIN")
	var names = ""
	for i in range(containers.size()):
		if containers[i].get_parent_id() != 0: continue
		var name = containers[i].get_state().name.to_upper()
		if i == 0:
			names += "%s" % name
		else: names += ", %s" % name
	ed = ed.replace("%names%",names)
	source_code += ed
	_jump_lines(1)
	
	#containers enums
	for container in containers:
		var state:State = container.get_state()
		var ce = source.ed
		ce = ce.replace("%type%",state.name.to_upper())
		print("Get children of ID: "+str(state.ID))
		var children = _get_states_child_of( state.ID)
		
		
#		print("children: "+str(children))
#		print("child of: "+state.name+"/ "+str(children))
		names = ""
		for i in range(children.size()):
			var sub_state:State = children[i].get_state()
			print("children of: "+str(state.ID)+": "+str(sub_state.ID))
			var name = sub_state.name
			if i != children.size()-1:
				names += "%s, " % name
			else: names += name
		ce = ce.replace("%names%", names.to_upper())
		source_code += ce
		_jump_lines(1)
	_jump_lines(2)
	
	#initialize function
	source_code += "func _initialize_machines(): \n\t"
	
	#Parents registers
	for container in containers:
		var state:State = container.get_state()
		var machine_name = "machine_" + state.name.to_lower()
		var pd = source.pd
		pd = pd.replace("%machine_name%", machine_name)
		if state.parent_id == 0:
			pd = pd.replace("%parent_machine_ref%", "state_machine")
			pd = pd.replace("%child_id%","STATE_MAIN."+state.name.to_upper())
			pass
		else:
			var parent = _get_state_by_id(state.parent_id)
			pd = pd.replace("%parent_machine_ref%", "machine_"+parent.name.to_lower())
			pd = pd.replace("%child_id%", "STATE_%s.%s" % [parent.name.to_upper(), state.name.to_upper()])
			pass
		source_code += pd
		_jump_lines(1)
		_tab_lines(1)
	
	# states registers
	for state_graphs in all_states:
		var state:State = state_graphs.get_state()
		var sd =  source.sd
		_jump_lines(1)
		_tab_lines(1)
		if state.parent_id == 0:
			sd = sd.replace("%machine_name%","state_machine")
			sd = sd.replace("%state_enum%", "STATE_MAIN."+state.name.to_upper())
			print("read 1")
		else:
			print("read 2")
			print("looking for parent: "+str(state.parent_id))
			var parent_name = _get_state_by_id(state.parent_id).get_state().name
			sd = sd.replace("%machine_name%", "machine_"+parent_name)
			sd = sd.replace("%state_enum%", "STATE_"+parent_name.to_upper()+"."+state.name.to_upper())
		sd = sd.replace("%func_name%", state.name)
		sd = sd.replace("%has_init%", str(state.has_init).to_lower())
		sd = sd.replace("%has_exit%", str(state.has_exit).to_lower())
		source_code += sd
	_jump_lines(2)
	_tab_lines(1)
	# start all machines
	for container in containers:
		var state:State = container.get_state()
		var sm = source.sm
		sm = sm.replace("%machine_name%","machine_"+state.name)
		source_code += sm
		_jump_lines(1)
		_tab_lines(1)
	
	#start main machine
	var sm = source.sm
	sm = sm.replace("%machine_name%","state_machine")
	source_code += sm
	_jump_lines(4)
	
	#ready function
	var r = "func _ready(): \n\t_initialize_machines()\n\n\n"
	source_code += r

	#process function
	var p = "func _process(delta): \n\tstate_machine.machine_update()\n\n\n"
	source_code += p
	
	#state functions
	for gn_state in all_states:
		var state:State = gn_state.get_state()
		var sf = source.sf
		if state.has_init:
			sf = sf.replace("%type%","init")
			sf = sf.replace("%state_name%", state.name)
			sf = sf.replace("%action%","")
			source_code += sf
		sf = source.sf
		sf = sf.replace("%type%", "update")
		sf = sf.replace("%state_name%", state.name)
		sf = sf.replace("%action%","#TODO: action on update")
		source_code += sf
		if state.has_exit:
			sf = source.sf
			sf = sf.replace("%type%","exit")
			sf = sf.replace("%state_name%", state.name)
			sf = sf.replace("%action%","")
			source_code += sf
		
		
	
func _save_script():
	var file = File.new()
	file.open("res://addons/ASM/compiled/newmachine.gd",file.WRITE)
	file.store_string(source_code)
	file.close()
	

func _jump_lines(n:int):
	for i in range(n):
		source_code += "\n"

func _tab_lines(n:int):
	for i in range(n):
		source_code += "\t"

func _get_state_by_id(id:int) -> State:
	for state in all_states:
		if state.get_state_id() == id:
			return state
	return null

func _get_states_child_of(parent_id:int) -> Array:
	var result = []
	
	for state in all_states:
		print("stateID: "+str(state.get_state().ID))
		print("looking for parent: "+str(parent_id)+"/ this is: "+str(state.get_state().get_parent_id()))
		if state.get_state().get_parent_id() == parent_id:
			result.append(state)
	
	return result
