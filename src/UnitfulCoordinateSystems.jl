module UnitfulCoordinateSystems
    using LinearAlgebra
    using StaticArrays
    using Unitful

    ###########################################################################
    #                        COORDINATE TYPE DEFINITIONS
    ###########################################################################

    abstract type Coordinate{N} end

    struct CoordinateRectangular{L} <: Coordinate{2}
        x::L
        y::L
    end

    struct CoordinatePolar{L,A} <: Coordinate{2}
        r::L
        ϕ::A
        #CoordinatePolar(r,ϕ) = new{L,A}(r,ϕ)
    end

    struct CoordinateCartesian{L} <: Coordinate{3}
        x::L
        y::L
        z::L
        #CoordinateCartesian(x,y,z) = new(x,y,z)
    end

    struct CoordinateSpherical{L,A} <: Coordinate{3}
        r::L
        θ::A
        ϕ::A
    end

    struct CoordinateCylindrical{L,A} <: Coordinate{3}
        ρ::L
        ϕ::A
        z::L
    end

    CoordinatePolar(r̄::CoordinateRectangular) = CoordinatePolar(norm(r̄), ϕ(r̄))
    CoordinateCartesian(r̄::CoordinateCartesian) = CoordinateCartesian(r̄.x, r̄.y, r̄.z)
    CoordinateCartesian(r̄::CoordinateRectangular) = CoordinateCartesian(r̄.x, r̄.y, r̄.z)
    CoordinateCartesian(r̄::CoordinatePolar) = CoordinateCartesian(r̄.r*cos(r̄.ϕ), r̄.r*sin(r̄.ϕ), 0.0u"m")
    CoordinateCartesian(r̄::CoordinateCylindrical) = CoordinateCartesian(r̄.r*cos(r̄.ϕ), r̄.r*sin(r̄.ϕ), r̄.z)
    CoordinateCartesian(r̄::CoordinateSpherical) = error("Not yet implemented.")

    export Coordinate
    export CoordinateRectangular, CoordinatePolar
    export CoordinateCartesian, CoordinateCylindrical, CoordinateSpherical

    ###########################################################################
    #                        UTILITY FUNCTIONS
    ###########################################################################

    Base.broadcastable(r::CoordinateCartesian) = SVector(r.x, r.y, r.z)
    Base.isempty(r::Coordinate) = false
    Base.length(r::Coordinate{N}) where {N} = N
    Base.axes(r::Coordinate{N}) where {N} = Base.OneTo(N)

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

    Base.:+(u::CoordinateCartesian, v::CoordinateCartesian) = CoordinateCartesian(u.x+v.x, u.y+v.y, u.z+v.z)
    Base.:+(u::Coordinate, v::Coordinate) = CoordinateCartesian(u) + CoordinateCartesian(v)

    Base.:-(u::CoordinateCartesian, v::CoordinateCartesian) = CoordinateCartesian(u.x-v.x, u.y-v.y, u.z-v.z)
    Base.:-(u::Coordinate, v::Coordinate) = CoordinateCartesian(u) - CoordinateCartesian(v)

    function LinearAlgebra.cross(u::CoordinateCartesian, v::CoordinateCartesian)
        w = cross(SVector(u.x, u.y, u.z), SVector(v.x, v.y, v.z))
        return CoordinateCartesian(w[1], w[2], w[3])
    end

    LinearAlgebra.norm(r̄::CoordinateRectangular) = LinearAlgebra.norm(SVector(r̄.x,r̄.y))
    LinearAlgebra.norm(r̄::CoordinatePolar) = r̄.r
    LinearAlgebra.norm(r̄::CoordinateCartesian) = LinearAlgebra.norm(SVector(r̄.x,r̄.y,r̄.z))
    LinearAlgebra.norm(r̄::CoordinateCylindrical) = LinearAlgebra.norm(SVector(r̄.ρ,r̄.z))
    LinearAlgebra.norm(r̄::CoordinateSpherical) = r̄.r

    ###########################################################################
    #                        INDEX FUNCTIONS
    ###########################################################################

    x(r::CoordinateRectangular) = r.x
    x(r::Coordinate{2}) = CoordinateRectangular(r).x
    x(r::CoordinateCartesian) = r.x
    x(r::Coordinate{3}) = CoordinateCartesian(r).x

    y(r::CoordinateRectangular) = r.y
    y(r::Coordinate{2}) = CoordinateRectangular(r).y
    y(r::CoordinateCartesian) = r.y
    y(r::Coordinate{3}) = CoordinateCartesian(r).y

    z(r::Coordinate{2}) = 0.0
    z(r::CoordinateCartesian) = r.z
    z(r::Coordinate{3}) = CoordinateCartesian(r).z

    r(r̄::Coordinate) = LinearAlgebra.norm(r̄)

    ϕ(r̄::CoordinateRectangular) = tand(r̄.y/r̄.x) * u"°"
    ϕ(r̄::CoordinatePolar) = r̄.ϕ
    ϕ(r̄::CoordinateCartesian) = atand(r̄.y/r̄.x) * u"°"
    ϕ(r̄::CoordinateCylindrical) = r̄.ϕ
    ϕ(r̄::CoordinateSpherical) = r̄.ϕ

    θ(r̄::CoordinateCartesian) = atand(r̄.z/hypot(r̄.x,r̄.y)) * u"°"
    θ(r̄::CoordinateCylindrical) = tand(r̄.z/r̄.ρ) * u"°"
    θ(r̄::CoordinateSpherical) = r̄.θ

    # do not export r, ϕ, θ functions by default

    ###########################################################################
    #                        CONSTANT UNIT VECTORS
    ###########################################################################

    x̂ = SVector(1,0,0)
    ŷ = SVector(0,1,0)
    ẑ = SVector(0,0,1)

    export x̂, ŷ, ẑ

    ###########################################################################
    #                  SPATIALLY-VARIANT UNIT VECTOR FUNCTIONS
    ###########################################################################

    ρ̂(r̄::Coordinate) = x̂ .* cos(ϕ(r̄)) .+ ŷ .* sin(ϕ(r̄))
    r̂(r̄::Coordinate) = x̂ .* sin(θ(r̄))*cos(ϕ(r̄)) .+ ŷ .* sin(θ(r̄))*sin(ϕ(r̄)) .+ ẑ .* cos(θ(r̄))
    θ̂(r̄::Coordinate) = x̂ .* cos(θ(r̄))*cos(ϕ(r̄)) .+ ŷ .* cos(θ(r̄))*sin(ϕ(r̄)) .- ẑ .* sin(θ(r̄))
    ϕ̂(r̄::Coordinate) = -x̂ .* sin(ϕ(r̄)) + ŷ .* cos(ϕ(r̄))

    export ρ̂, r̂, θ̂, ϕ̂
end
