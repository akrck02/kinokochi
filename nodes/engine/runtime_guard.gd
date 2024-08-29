extends Node
class_name RuntimeGuard
 
var node_name : String = "RuntimeGuard"
var _enabled : bool = true
var _parameters : Dictionary = {}

## create a new runtime guard
static func for_node(parent_name : String) -> RuntimeGuard:
	var guard = RuntimeGuard.new()
	guard.node_name = parent_name
	return guard


## Register a parameter in runtime
func register_parameter(parameter_name : String, parameter_value):
	_parameters[_get_parameter_key(parameter_name)] = parameter_value


## Get parameter key
func _get_parameter_key(parameter_name : String) -> String:
	return "{param_name}".format({
		"param_name": parameter_name
	});


## Check if given parameters are present and update if runtime must be enabled
func calculate_if_runtime_must_be_enabled() -> bool:
	_enabled = true
	for parameter in _parameters: 
		if not _parameters[parameter]:
			push_error("No {param.name} was not found on {node.name}, no events will occur regarding this node".format({
				"param.name": parameter,
				"node.name" : node_name
			}))
			_enabled = false
	return _enabled


## Get if runtime script execution is disabled
func is_runtime_enabled() -> bool:
	return _enabled
