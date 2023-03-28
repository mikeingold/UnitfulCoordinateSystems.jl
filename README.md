# UnitfulCoordinateSystems.jl

[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://mikeingold.github.io/UnitfulCoordinateSystems.jl/dev/)

This package is a simple and efficient implementation of several common coordinate
systems with `Unitful` dimensions. These systems, as defined by the ISO 80000-2:2019
standards, include:
- Two-Dimensional `AbstractCoordinate{2}`:
    - Rectangular `CoordinateRectangular` (x, y)
    - Polar `CoordinatePolar` (r, $\varphi$)
- Three-Dimensional `AbstractCoordinate{3}`:
    - Cartesian `CoordinateCartesian` (x, y, z)
    - Cylindrical `CoordinateCylindrical` ($\rho$, $\varphi$, z)
    - Spherical `CoordinateSpherical` (r, $\theta$, $\varphi$)

Typical usage looks like:
```julia
using Unitful, UnitfulCoordinateSystems
coord1 = CoordinateCartesian(1.0u"m", 2.0u"m", 3.0u"m")
coord2 = CoordinateSpherical(1.0u"m", 45.0u"°", 30.0u"°")
```
