module YYZRecipes

# Write your package code here.

using Requires
using RecipesBase

function __init__()
    @require Distributions="31c24e10-a181-5473-b8eb-7969acd0382f" include("Distributions.jl")
end


end
