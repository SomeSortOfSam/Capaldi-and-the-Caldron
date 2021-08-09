using Godot;
using System;

public class Cauldron : Node2D
{
    private IFood[] ingredients = new IFood[3];
    private int ingredientIndex = 0;

    [Signal]
    public delegate void TryRecipe();

    public void AddFood(IFood newFood)
    {
        ingredients[ingredientIndex] = newFood;
        if(ingredientIndex >= ingredients.Length -1)
        {
            CheckRecipe();
            ingredientIndex = -1;
        }
        ingredientIndex++;
    }

    private void CheckRecipe()
    {
        GD.Print(ingredients);
    }

    private void _on_FoodZone_body_entered(object body)
    {
        if(body is IFood)
        {
            AddFood(body as IFood);
        }
    }
}



