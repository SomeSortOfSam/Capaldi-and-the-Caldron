using Godot;
using System;

public class Cauldron : Node2D
{
    private IFood[] ingredients = new IFood[3];
    private int ingredientIndex = 0;

    public bool tryingRecipie = false;

    [Signal]
    public delegate void TryRecipe(object result);

    public void AddFood(IFood newFood)
    {
        ingredientIndex++;
        ingredients[ingredientIndex] = newFood;
        if(ingredientIndex >= ingredients.Length - 1)
        {
        }
    }

    private void CheckRecipe()
    {
        tryingRecipie = true;
        GD.Print(ingredients[0].ToString() + "," + ingredients[1].ToString() + "," + ingredients[2].ToString());
    }

    private void _on_FoodZone_body_entered(object body)
    {
        if(body is IFood)
        {
            AddFood(body as IFood);
        }
    }
}



