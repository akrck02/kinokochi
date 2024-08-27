extends Node
class_name State

@warning_ignore("unused_signal") signal transitioned(state : State, new_state_name : String)

## Logic for the entrance of the state
func enter(): pass

## Logic for the exit of the state
func exit(): pass

## Logic for the standard update of the state
func process(_delta : float): pass

## Logic for the physic update of the state
func physics_process(_delta: float): pass

## Logic for the tick update of the state
func tick_process(): pass
