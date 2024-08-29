extends Node
class_name Code

## Check if given parameters are present
static func check_parameters(node_name : String, params : Dictionary) -> bool:
	var ok = true;
	for param in params: 
		if not params[param]:
			push_error("No {param.name} was found on {node.name}, no events will occur regarding this node".format({
				"param.name": param,
				"node.name" : node_name
			}))
			
			ok = false
	
	return ok
