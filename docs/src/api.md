# Reference

## Data Structures

```@docs
UnitfulCoordinateSystems.CoordinateRectangular
UnitfulCoordinateSystems.CoordinatePolar
UnitfulCoordinateSystems.CoordinateCartesian
UnitfulCoordinateSystems.CoordinateCylindrical
UnitfulCoordinateSystems.CoordinateSpherical
```

## Component Functions

These functions are not exported by default because they present a high probability
of namespace collisions. Instead, they can be accessed by prepending the package
name, i.e. `UnitfulCoordinateSystems.x`, or by importing them explicitly, e.g.
`using UnitfulCoordinateSystems: x, y, z`.

```@docs
UnitfulCoordinateSystems.x
UnitfulCoordinateSystems.y
UnitfulCoordinateSystems.z
UnitfulCoordinateSystems.r

UnitfulCoordinateSystems.rho
UnitfulCoordinateSystems.ρ

UnitfulCoordinateSystems.phi
UnitfulCoordinateSystems.φ
UnitfulCoordinateSystems.ϕ

UnitfulCoordinateSystems.theta
UnitfulCoordinateSystems.θ
UnitfulCoordinateSystems.ϑ
```

