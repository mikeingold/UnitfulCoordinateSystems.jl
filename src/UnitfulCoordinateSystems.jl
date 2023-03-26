module UnitfulCoordinateSystems
    using LinearAlgebra, StaticArrays
    using Unitful, DimensionfulAngles

    include("structs.jl")

    ############################################################################
    #                        COORDINATE TYPE CONVERSIONS
    ############################################################################

    # x is the inner product of a vector with x̂
    x(r̄::CoordinatePolar) = r̄.r * cos(r̄.φ)
    x(r̄::CoordinateRectangular) = r̄.x
    x(r̄::CoordinateCartesian) = r̄.x
    x(r̄::CoordinateCylindrical) = r̄.r * cos(r̄.φ)
    x(r̄::CoordinateSpherical) = error("Not yet implemented.")

    # y is the inner product of a vector with ŷ
    y(r̄::CoordinatePolar) = r̄.r * sin(r̄.φ)
    y(r̄::CoordinateRectangular) = r̄.y
    y(r̄::CoordinateCartesian) = r̄.y
    y(r̄::CoordinateCylindrical) = r̄.r * sin(r̄.φ)
    y(r̄::CoordinateSpherical) = error("Not yet implemented.")

    # z is the inner product of a vector with ẑ
    z(r̄::CoordinatePolar{L,A}) where {L,A} = zero(L)
    z(r̄::CoordinateRectangular{L}) where {L} = zero(L)
    z(r̄::CoordinateCartesian) = r̄.z
    z(r̄::CoordinateCylindrical) = r̄.z
    z(r̄::CoordinateSpherical) = error("Not yet implemented.")
    
    # ρ is the length to a subtended point on the xy-plane
    ρ(r̄::CoordinatePolar) = r̄.r
    ρ(r̄::CoordinateRectangular) = LinearAlgebra.norm([r̄.x, r̄.y])
    ρ(r̄::CoordinateCartesian) = LinearAlgebra.norm([r̄.x, r̄.y])
    ρ(r̄::CoordinateCylindrical) = r̄.ρ
    ρ(r̄::CoordinateSpherical) = error("Not yet implemented.")
    rho = ρ

    # r is the vector length
    r(r̄::CoordinatePolar) = r̄.r
    r(r̄::CoordinateRectangular) = LinearAlgebra.norm([r̄.x, r̄.y])
    r(r̄::CoordinateCartesian) = LinearAlgebra.norm([r̄.x, r̄.y, r̄.z])
    r(r̄::CoordinateCylindrical) = LinearAlgebra.norm([r̄.ρ, r̄.z])
    r(r̄::CoordinateSpherical) = r̄.r

    # φ is the angle between the positive x-axis and a subtended point on the xy-plane
    φ(r̄::CoordinatePolar) = r̄.φ
    φ(r̄::CoordinateRectangular) = atand(r̄.y/r̄.x) * u"°"
    φ(r̄::CoordinateCartesian) = atand(r̄.y/r̄.x) * u"°"
    φ(r̄::CoordinateCylindrical) = r̄.φ
    φ(r̄::CoordinateSpherical) = r̄.φ
    phi = φ

    # θ is the angle between a vector and the positive z-axis
    θ(r̄::CoordinatePolar{L,A}) where {L,A} = 90 * one(A) * unit(r̄.φ)
    θ(r̄::CoordinateRectangular{L}) where {L} = one(L) * 90u"°"
    θ(r̄::CoordinateCartesian) = acosd(r̄.z/r(r̄)) * u"°"
    θ(r̄::CoordinateCylindrical) = atand(r̄.ρ/r̄.z) * u"°"
    θ(r̄::CoordinateSpherical) = r̄.θ
    theta = θ

    ############################################################################
    #                      EXTRA COORDINATE CONSTRUCTORS
    ############################################################################

    # Construct a Coordinate from another Coordinate
    #   Note that 3D -> 2D projects onto the xy-plane, losing information
    CoordinatePolar(r̄::AbstractCoordinate) = CoordinatePolar(ρ(r̄), φ(r̄))
    CoordinateRectangular(r̄::AbstractCoordinate) = CoordinateRectangular(x(r̄), y(r̄))
    CoordinateCartesian(r̄::AbstractCoordinate) = CoordinateCartesian(x(r̄), y(r̄), z(r̄))
    CoordinateCylindrical(r̄::AbstractCoordinate) = CoordinateCylindrical(r(r̄), φ(r̄), z(r̄))
    CoordinateSpherical(r̄::AbstractCoordinate) = CoordinateSpherical(r(r̄), θ(r̄), φ(r̄))

    # Construct a Coordinate from an SVector
    CoordinatePolar(v::SVector{2}) = CoordinatePolar(v[1], v[2])
    CoordinateRectangular(v::SVector{2}) = CoordinateRectangular(v[1], v[2])
    CoordinateCartesian(v::SVector{3}) = CoordinateCartesian(v[1], v[2], v[3])
    CoordinateCylindrical(v::SVector{3}) = CoordinateCylindrical(v[1], v[2], v[3])
    CoordinateSpherical(v::SVector{3}) = CoordinateSpherical(v[1], v[2], v[3])

    ###########################################################################
    #                           UNIT VECTORS
    ###########################################################################

    # Constant unit vectors
    unitvector_x = SVector(1,0,0)
    unitvector_y = SVector(0,1,0)
    unitvector_z = SVector(0,0,1)

    # Handy Unicode aliases
    x̂ = unitvector_x
    ŷ = unitvector_y
    ẑ = unitvector_z

    # Spatially-variant unit vectors
    function unitvector_rho(r̄::AbstractCoordinate)
        (x̂ .* cos(φ(r̄))) .+ (ŷ .* sin(φ(r̄)))
    end
    ρ̂ = unitvector_rho

    function unitvector_r(r̄::AbstractCoordinate)
        (x̂ .* sin(θ(r̄)) * cos(φ(r̄))) .+ (ŷ .* sin(θ(r̄)) * sin(φ(r̄))) .+ (ẑ .* cos(θ(r̄)))
    end
    r̂ = unitvector_r

    function unitvector_theta(r̄::AbstractCoordinate)
        (x̂ .* cos(θ(r̄)) * cos(φ(r̄))) .+ (ŷ .* cos(θ(r̄)) * sin(φ(r̄))) .- (ẑ .* sin(θ(r̄)))
    end
    θ̂ = unitvector_theta

    function unitvector_phi(r̄::AbstractCoordinate)
        (-x̂ .* sin(φ(r̄))) .+ (ŷ .* cos(φ(r̄)))
    end
    φ̂ = unitvector_phi

    export unitvector_x, x̂, unitvector_y, ŷ, unitvector_z, ẑ
    export unitvector_rho, ρ̂, unitvec_r, r̂, unitvec_theta, θ̂, unitvec_phi, φ̂

    ###########################################################################
    #                        UTILITY FUNCTIONS
    ###########################################################################

    Base.broadcastable(r̄::CoordinatePolar) = SVector(r̄.r, r̄.φ)
    Base.broadcastable(r̄::CoordinateRectangular) = SVector(r̄.x, r̄.y)
    Base.broadcastable(r̄::CoordinateCartesian) = SVector(r̄.x, r̄.y, r̄.z)
    Base.broadcastable(r̄::CoordinateCylindrical) = SVector(r̄.ρ, r̄.φ, r̄.z)
    Base.broadcastable(r̄::CoordinateSpherical) = SVector(r̄.r, r̄.φ, r̄.θ)

    Base.isempty(r̄::AbstractCoordinate) = false
    Base.length(r̄::AbstractCoordinate{N}) where {N} = N
    Base.axes(r̄::AbstractCoordinate{N}) where {N} = Base.OneTo(N)

    #= Maybe not needed?
    function Base.getindex(r::CoordinateCartesian, i::Int)
        if i == 1
            return r.x
        elseif i == 2
            return r.y
        elseif i == 3
            return r.z
        else
            error("r[$i] undefined for a CoordinateCartesian")
        end
    end
    =#

    # Addition rules
    Base.:+(u::CoordinateRectangular, v::CoordinateRectangular) = CoordinateRectangular(u.x+v.x, u.y+v.y)
    Base.:+(u::AbstractCoordinate{2}, v::AbstractCoordinate{2}) = CoordinateRectangular(u) + CoordinateRectangular(v)
    Base.:+(u::CoordinateCartesian, v::CoordinateCartesian) = CoordinateCartesian(u.x+v.x, u.y+v.y, u.z+v.z)
    Base.:+(u::AbstractCoordinate{3}, v::AbstractCoordinate{3}) = CoordinateCartesian(u) + CoordinateCartesian(v)
    Base.:+(u::AbstractCoordinate{3}, v::SVector{3}) = CoordinateCartesian(u.x+v[1], u.y+v[2], u.z+v[3])

    # Subtraction rules
    Base.:-(u::CoordinateRectangular, v::CoordinateRectangular) = CoordinateRectangular(u.x-v.x, u.y-v.y)
    Base.:-(u::AbstractCoordinate{2}, v::AbstractCoordinate{2}) = CoordinateRectangular(u) - CoordinateRectangular(v)
    Base.:-(u::CoordinateCartesian, v::CoordinateCartesian) = CoordinateCartesian(u.x-v.x, u.y-v.y, u.z-v.z)
    Base.:-(u::AbstractCoordinate{3}, v::AbstractCoordinate{3}) = CoordinateCartesian(u) - CoordinateCartesian(v)

    # Convert Coordinate to SVector
    StaticArrays.SVector(r̄::CoordinatePolar) = StaticArrays.SVector(r̄.r, r̄.φ)
    StaticArrays.SVector(r̄::CoordinateRectangular) = StaticArrays.SVector(r̄.r, r̄.φ)
    StaticArrays.SVector(r̄::CoordinateCartesian) = StaticArrays.SVector(r̄.x, r̄.y, r̄.z)
    StaticArrays.SVector(r̄::CoordinateCylindrical) = StaticArrays.SVector(r̄.r, r̄.φ, r̄.z)
    StaticArrays.SVector(r̄::CoordinateSpherical) = StaticArrays.SVector(r̄.r, r̄.φ, r̄.θ)

    # Cross/outer product
    function LinearAlgebra.cross(u::AbstractCoordinate{3}, v::AbstractCoordinate{3})
        u_vec = SVector(CoordinateCartesian(u))
        v_vec = SVector(CoordinateCartesian(v))
        w = LinearAlgebra.cross(u_vec, v_vec)
        return CoordinateCartesian(w)
    end

    # P-Norm
    LinearAlgebra.norm(r̄::CoordinatePolar) = r̄.r
    LinearAlgebra.norm(r̄::CoordinateRectangular) = LinearAlgebra.norm(SVector(r̄.x,r̄.y))
    LinearAlgebra.norm(r̄::CoordinateCartesian) = LinearAlgebra.norm(SVector(r̄.x,r̄.y,r̄.z))
    LinearAlgebra.norm(r̄::CoordinateCylindrical) = LinearAlgebra.norm(SVector(r̄.ρ,r̄.z))
    LinearAlgebra.norm(r̄::CoordinateSpherical) = r̄.r

end
