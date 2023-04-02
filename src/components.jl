############################################################################
#                        COMPONENT FUNCTIONS
############################################################################

# These component functions are not exported due to their high potential for
# namespace collisions. They can instead be accessed by prepending the package
# name or by explicitly importing them as required.

"""
    x(r̄::AbstractCoordinate)

Calculate the x̂-directed component of `r̄`, i.e. the inner product of x̂ and r̄.
"""
x(r̄::CoordinatePolar) = r̄.r * cos(r̄.phi)
x(r̄::CoordinateRectangular) = r̄.x
x(r̄::CoordinateCartesian) = r̄.x
x(r̄::CoordinateCylindrical) = r̄.rho * cos(r̄.phi)
x(r̄::CoordinateSpherical) = r̄.r * sin(r̄.theta) * cos(r̄.phi)

"""
    y(r̄::AbstractCoordinate)

Calculate the ŷ-directed component of `r̄`, i.e. the inner product of ŷ and r̄.
"""
y(r̄::CoordinatePolar) = r̄.r * sin(r̄.phi)
y(r̄::CoordinateRectangular) = r̄.y
y(r̄::CoordinateCartesian) = r̄.y
y(r̄::CoordinateCylindrical) = r̄.rho * sin(r̄.phi)
y(r̄::CoordinateSpherical) = r̄.r * sin(r̄.theta) * sin(r̄.phi)

"""
    z(r̄::AbstractCoordinate)

Calculate the ẑ-directed component of `r̄`, i.e. the inner product of ẑ and r̄.
"""
z(r̄::CoordinatePolar{L,A}) where {L,A} = zero(L)
z(r̄::CoordinateRectangular{L}) where {L} = zero(L)
z(r̄::CoordinateCartesian) = r̄.z
z(r̄::CoordinateCylindrical) = r̄.z
z(r̄::CoordinateSpherical) = r̄.r * cos(r̄.theta)

# ρ is the length to a subtended point on the xy-plane
"""
    rho(r̄::AbstractCoordinate)

Calculate the magnitude of the coordinate that `r̄` subtends onto the xy-plane.
"""
rho(r̄::CoordinatePolar) = r̄.r
rho(r̄::CoordinateRectangular) = LinearAlgebra.norm([r̄.x, r̄.y])
rho(r̄::CoordinateCartesian) = LinearAlgebra.norm([r̄.x, r̄.y])
rho(r̄::CoordinateCylindrical) = r̄.rho
rho(r̄::CoordinateSpherical) = r̄.r * sin(r̄.phi)

"""
    ρ(r̄::AbstractCoordinate)

Calculate the magnitude of the coordinate that `r̄` subtends onto the xy-plane.
"""
ρ = rho

"""
    r(r̄::AbstractCoordinate)

Calculate the magnitude/radius of `r̄`, i.e. the inner product of r̂ and r̄.
"""
r(r̄::CoordinatePolar) = r̄.r
r(r̄::CoordinateRectangular) = LinearAlgebra.norm([r̄.x, r̄.y])
r(r̄::CoordinateCartesian) = LinearAlgebra.norm([r̄.x, r̄.y, r̄.z])
r(r̄::CoordinateCylindrical) = LinearAlgebra.norm([r̄.ρ, r̄.z])
r(r̄::CoordinateSpherical) = r̄.r

"""
    phi(r̄::AbstractCoordinate)

Calculate the angle between the positive x-axis and the coordinate that `r̄`
subtends onto the xy-plane.

!!! note
    `phi`, `φ`, and `ϕ` are all aliased to the same function.
"""
phi(r̄::CoordinatePolar) = r̄.phi
phi(r̄::CoordinateRectangular) = atand(r̄.y/r̄.x) * u"°"
phi(r̄::CoordinateCartesian) = atand(r̄.y/r̄.x) * u"°"
phi(r̄::CoordinateCylindrical) = r̄.phi
phi(r̄::CoordinateSpherical) = r̄.phi

"""
    φ(r̄::AbstractCoordinate)

Calculate the angle between the positive x-axis and the coordinate that `r̄`
subtends onto the xy-plane.

!!! note
    `phi`, `φ`, and `ϕ` are all aliased to the same function.
"""
φ = phi

"""
    ϕ(r̄::AbstractCoordinate)

Calculate the angle between the positive x-axis and the coordinate that `r̄`
subtends onto the xy-plane.

!!! note
    `phi`, `φ`, and `ϕ` are all aliased to the same function.
"""
ϕ = phi

"""
    theta(r̄::AbstractCoordinate)

Calculate the angle between the positive z-axis and `r̄`.

!!! note
    `theta`, `θ`, and `ϑ` are all aliased to the same function.
"""
theta(r̄::CoordinatePolar{L,A}) where {L,A} = 90 * one(A) * unit(r̄.phi)
theta(r̄::CoordinateRectangular{L}) where {L} = one(L) * 90u"°"
theta(r̄::CoordinateCartesian) = acosd(r̄.z/r(r̄)) * u"°"
theta(r̄::CoordinateCylindrical) = atand(r̄.rho/r̄.z) * u"°"
theta(r̄::CoordinateSpherical) = r̄.theta

"""
    θ(r̄::AbstractCoordinate)

Calculate the angle between the positive z-axis and `r̄`.

!!! note
    `theta`, `θ`, and `ϑ` are all aliased to the same function.
"""
θ = theta

"""
    ϑ(r̄::AbstractCoordinate)

Calculate the angle between the positive z-axis and `r̄`.

!!! note
    `theta`, `θ`, and `ϑ` are all aliased to the same function.
"""
ϑ = theta
