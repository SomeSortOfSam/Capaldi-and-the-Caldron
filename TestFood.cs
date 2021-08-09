using Godot;
using System;

public class TestFood : RigidBody2D, IFood
{
    public string name => Name;
}
