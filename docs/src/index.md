# UnitfulCoordinateSystems.jl

This package is a simple and efficient implementation of several common coordinate
systems, as defined by the ISO 80000-2:2019 standards, with `Unitful` dimensions.

This package is not yet registered in the Julia package manager, but it can be
added manually via Julia's `Pkg` REPL-mode as follows

```julia
julia> ]
(@v1.X) pkg> add https://github.com/mikeingold/UnitfulCoordinateSystems.jl.git
```

or programmatically via

```julia
import Pkg
Pkg.add(url="https://github.com/mikeingold/UnitfulCoordinateSystems.jl.git")
```

## Coordinate Systems

Coordinate types are defined under a common type `AbstractCoordinate{N}` where
`N` is the number of dimensions in the coordinate.

### Rectangular (2D)

Two-dimensional rectangular coordinates are represented with the `CoordinateRectangular`
type. These coordinates are located on the xy-plane and are defined by orthogonal
$x$ and $y$ components.

### Polar (2D)

Two-dimensional polar coordinates are represented with the `CoordinatePolar` type.
These coordinates are located on the xy-plane and are defined by a radius $r$ and
an azimuth angle $\varphi$. This angle $\varphi$ is measured relative to the positive
$x$-axis.

### Cartesian (3D)

Three-dimensional Cartesian coordinates are represented with the `CoordinateCartesian`
type. These coordinates are defined by orthogonal $x$, $y$, and $z$ components.

### Cylindrical (3D)

Three-dimensional cylindrical coordinates are represented with the `CoordinateCylindrical`
type. These coordinates are defined by a range $\rho$ from the origin to the point on
the $xy$-plane subtended by the coordinate, an azimuth angle $\varphi$ measured
relative to the positive $x$-axis, and an orthogonal $z$ component.

### Spherical (3D)

Three-dimensional spherical coordinates are represented with the `CoordinateSpherical`
type. These coordinates are defined by a radius $r$, a polar angle $\theta$ measured
relative to the positive $z$-axis, and an azimuth angle $\varphi$ measured relative
to the positive $x$-axis.
