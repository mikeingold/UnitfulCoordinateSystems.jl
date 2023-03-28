# TODO

Register package in Julia registry:
- Any name similarity issue?
- Requirements for automatic acceptance?

Documentation:
- Add API references for:
    - Constructors (from components, from `SVector`, from other `AbstractCoordinate`)
    - Unit vectors

Tests:
- Finish writing tests
    - For `CoordinateCylindrical` and `CoordinateSpherical`
    - For `SVector` conversions
    - Equality `==` between different coordinate types?
- Deploy a GitHub Action for `runtests.jl`
