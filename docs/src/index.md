# UnitfulCoordinateSystems.jl

`UnitfulCoordinateSystems.jl` is a simple and efficient implementation of common
physically-based coordinate systems with `Unitful` dimensions. This package is
not yet registered in the Julia package manager, but it can be added manually
via Julia's `Pkg` REPL-mode as follows

```julia
julia> ]
(@v1.X) pkg> add https://github.com/mikeingold/UnitfulCoordinateSystems.jl.git
```

or programmatically via

```julia
import Pkg
Pkg.add(url="https://github.com/mikeingold/UnitfulCoordinateSystems.jl.git")
```

