using Godot;
using System;

public class KinematicBody2D : Godot.KinematicBody2D
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";
	[Export] public Vector2 gravity;
	private Vector2 velocity;
	[Export] public float speed;


	//  // Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(float delta)
	{
		velocity += movementHandeler() * speed;
		velocity += gravity;
		velocity = MoveAndSlide(velocity);
	}
	public Vector2 movementHandeler()
	{
		Vector2 movementVector = Vector2.Zero;
		if (Input.IsActionPressed("ui_left"))
		{
			movementVector += Vector2.Left;
		}
		if (Input.IsActionPressed("ui_right"))
		{
			movementVector += Vector2.Right;
		}
		if (Input.IsActionPressed("ui_up")&&true)
		{
			movementVector += Vector2.Up;
		}
		//up is differnt, setup to allow a jump
		if (Input.IsActionPressed("ui_down"))
		{
			movementVector += Vector2.Down;
		}
		return movementVector.Normalized();
	}
}
