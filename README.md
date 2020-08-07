# YYZRecipes

This package makes more `plot(something)` to "just work". In principle I should send some PRs to related packages. But some may not be consistent with their original "flavor" (`StatsPlots` in my mind.), and some are too lazy to accept any PRs. So I rather collect them in the package.

All dependencies except `RecipesBase` and `Requires` are loaded by [Requires.jl](https://github.com/JuliaPackaging/Requires.jl) to decrease loading time.

## Installation

```julia
] add https://github.com/yiyuezhuo/YYZRecipes.jl
```

## Usage

```julia
using Distributions
using YYZRecipes
using Plots

plot(
    MvNormal([0.0, 0.5], [1. 0.5; 0.5 1.]),
    fmt=:png
)

plot(MixtureModel([
            MvNormal([1., 1.], 1.), 
            MvNormal([2., 2.], 1.),
            MvNormal([5., 5.], 1.),
            MvNormal([2., 4.], 2.)
    ])
)
```

## Gallery

### Distributions

#### MvNormal (2d)

<img src="https://user-images.githubusercontent.com/12798270/89645835-3ec26f00-d8ed-11ea-8497-8c9a0907cc75.png">

#### MultivariateMixture (2d MvNormal mixture)

<img src="https://user-images.githubusercontent.com/12798270/89645852-45e97d00-d8ed-11ea-81ab-ea6df784c115.png">





