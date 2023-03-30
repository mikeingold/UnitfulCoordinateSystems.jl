# TODO

Documentation:
- Add images of all systems
- Show some examples of accessor functions rho(r) and r.rho type notation
- Add API references for:
    - Constructors (from components, from `SVector`, from other `AbstractCoordinate`)
    - Unit vectors

Tests:
- Finish writing tests
    - For `CoordinateCylindrical` and `CoordinateSpherical`
    - For `SVector` conversions
    - Equality `==` between different coordinate types?
- Deploy a GitHub Action for `runtests.jl`

Long Term:
- Implement four-vectors (x,y,z,t)
