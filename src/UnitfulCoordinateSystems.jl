module UnitfulCoordinateSystems
    using DimensionfulAngles, LinearAlgebra, StaticArrays, Unitful

    include("structs.jl")
    export AbstractCoordinate
    export CoordinateRectangular, CoordinatePolar
    export CoordinateCartesian, CoordinateCylindrical, CoordinateSpherical

    include("components.jl")

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
    #                        ACCESSOR FUNCTIONS
    ###########################################################################

    function Base.getproperty(coord::CoordinatePolar, sym::Symbol)
        if (sym == :rho) || (sym == :phi)
            return getfield(coord, sym)
        elseif sym == :x
            return x(coord)
        elseif sym == :y
            return y(coord)
        elseif sym == :z
            return z(coord)
        elseif sym == :r
            return r(coord)
        elseif sym == :ρ
            return rho(coord)
        elseif (sym == :φ) || (sym == :ϕ)
            return phi(coord)
        elseif (sym == :θ) || (sym == :ϑ)
            return theta(coord)
        else # Fallback
            return getfield(coord, sym)
        end
    end

    function Base.getproperty(coord::CoordinateRectangular, sym::Symbol)
        if (sym == :x) || (sym == :y)
            getfield(coord, sym)
        elseif sym == :z
            return z(coord)
        elseif sym == :r
            return r(coord)
        elseif (sym == :rho) || (sym == :ρ)
            return rho(coord)
        elseif (sym == :phi) || (sym == :φ) || (sym == :ϕ)
            return phi(coord)
        elseif (sym == :theta) || (sym == :θ) || (sym == :ϑ)
            return theta(coord)
        else # Fallback
            return getfield(coord, sym)
        end
    end
    
    function Base.getproperty(coord::CoordinateCartesian, sym::Symbol)
        if (sym == :x) || (sym == :y) || (sym == :z)
            getfield(coord, sym)
        elseif sym == :r
            return r(coord)
        elseif (sym == :rho) || (sym == :ρ)
            return rho(coord)
        elseif (sym == :phi) || (sym == :φ) || (sym == :ϕ)
            return phi(coord)
        elseif (sym == :theta) || (sym == :θ) || (sym == :ϑ)
            return theta(coord)
        else # Fallback
            return getfield(coord, sym)
        end
    end

    function Base.getproperty(coord::CoordinateCylindrical, sym::Symbol)
        if (sym == :rho) || (sym == :phi) || (sym == :z)
            getfield(coord, sym)
        elseif sym == :x
            return x(coord)
        elseif sym == :y
            return y(coord)
        elseif sym == :r
            return r(coord)
        elseif sym == :ρ
            return rho(coord)
        elseif (sym == :φ) || (sym == :ϕ)
            return phi(coord)
        elseif (sym == :theta) || (sym == :θ) || (sym == :ϑ)
            return theta(coord)
        else # Fallback
            return getfield(coord, sym)
        end
    end

    function Base.getproperty(coord::CoordinateSpherical, sym::Symbol)
        if (sym == :r) || (sym == :theta) || (sym == :phi)
            getfield(coord, sym)
        elseif sym == :x
            return x(coord)
        elseif sym == :y
            return y(coord)
        elseif sym == :z
            return z(coord)
        elseif sym == :r
            return r(coord)
        elseif (sym == :rho) || (sym == :ρ)
            return rho(coord)
        elseif (sym == :φ) || (sym == :ϕ)
            return phi(coord)
        elseif (sym == :θ) || (sym == :ϑ)
            return theta(coord)
        else # Fallback
            return getfield(coord, sym)
        end
    end

    function Base.getindex(r::CoordinateRectangular, i::Int)
        if i == 1
            return r.x
        elseif i == 2
            return r.y
        else
            error("r[$i] undefined for a CoordinateRectangular")
        end
    end

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


    ############################################################################
    #                      EXTRA COORDINATE CONSTRUCTORS
    ############################################################################

    # Construct a Coordinate from another Coordinate
    #   Note that 3D -> 2D projects onto the xy-plane, losing information
    CoordinatePolar(r̄::AbstractCoordinate)       = CoordinatePolar(ρ(r̄), φ(r̄))
    CoordinateRectangular(r̄::AbstractCoordinate) = CoordinateRectangular(x(r̄), y(r̄))
    CoordinateCartesian(r̄::AbstractCoordinate)   = CoordinateCartesian(x(r̄), y(r̄), z(r̄))
    CoordinateCylindrical(r̄::AbstractCoordinate) = CoordinateCylindrical(r(r̄), φ(r̄), z(r̄))
    CoordinateSpherical(r̄::AbstractCoordinate)   = CoordinateSpherical(r(r̄), θ(r̄), φ(r̄))

    # Construct a Coordinate from an SVector
    CoordinatePolar(v::SVector{2})       = CoordinatePolar(v[1], v[2])
    CoordinateRectangular(v::SVector{2}) = CoordinateRectangular(v[1], v[2])
    CoordinateCartesian(v::SVector{3})   = CoordinateCartesian(v[1], v[2], v[3])
    CoordinateCylindrical(v::SVector{3}) = CoordinateCylindrical(v[1], v[2], v[3])
    CoordinateSpherical(v::SVector{3})   = CoordinateSpherical(v[1], v[2], v[3])


    ###########################################################################
    #                    BROADCASTING/VECTORIZATION METHODS 
    ###########################################################################

    # Convert Coordinate to SVector
    StaticArrays.SVector(r̄::CoordinatePolar)       = StaticArrays.SVector(r̄.r, r̄.phi)
    StaticArrays.SVector(r̄::CoordinateRectangular) = StaticArrays.SVector(r̄.r, r̄.phi)
    StaticArrays.SVector(r̄::CoordinateCartesian)   = StaticArrays.SVector(r̄.x, r̄.y, r̄.z)
    StaticArrays.SVector(r̄::CoordinateCylindrical) = StaticArrays.SVector(r̄.rho, r̄.phi, r̄.z)
    StaticArrays.SVector(r̄::CoordinateSpherical)   = StaticArrays.SVector(r̄.r, r̄.phi, r̄.theta)

    # Support for broadcasting into coordinates
    Base.broadcastable(r̄::AbstractCoordinate) = SVector(r̄)
    Base.isempty(r̄::AbstractCoordinate) = false
    Base.length(r̄::AbstractCoordinate{N}) where {N} = N
    Base.axes(r̄::AbstractCoordinate{N}) where {N} = Base.OneTo(N)


    ###########################################################################
    #                            MATH RULES/METHODS
    ###########################################################################

    # Addition rules
    Base.:+(u::CoordinateRectangular, v::CoordinateRectangular) = CoordinateRectangular(u.x+v.x, u.y+v.y)
    Base.:+(u::AbstractCoordinate{2}, v::AbstractCoordinate{2}) = CoordinateRectangular(u) + CoordinateRectangular(v)
    Base.:+(u::CoordinateCartesian, v::CoordinateCartesian)     = CoordinateCartesian(u.x+v.x, u.y+v.y, u.z+v.z)
    Base.:+(u::AbstractCoordinate{3}, v::AbstractCoordinate{3}) = CoordinateCartesian(u) + CoordinateCartesian(v)
    Base.:+(u::AbstractCoordinate{3}, v::SVector{3})            = CoordinateCartesian(u.x+v[1], u.y+v[2], u.z+v[3])

    # Subtraction rules
    Base.:-(u::CoordinateRectangular, v::CoordinateRectangular) = CoordinateRectangular(u.x-v.x, u.y-v.y)
    Base.:-(u::AbstractCoordinate{2}, v::AbstractCoordinate{2}) = CoordinateRectangular(u) - CoordinateRectangular(v)
    Base.:-(u::CoordinateCartesian, v::CoordinateCartesian)     = CoordinateCartesian(u.x-v.x, u.y-v.y, u.z-v.z)
    Base.:-(u::AbstractCoordinate{3}, v::AbstractCoordinate{3}) = CoordinateCartesian(u) - CoordinateCartesian(v)

    # Cross/outer product
    function LinearAlgebra.cross(u::AbstractCoordinate{3}, v::AbstractCoordinate{3})
        u_vec = SVector(CoordinateCartesian(u))
        v_vec = SVector(CoordinateCartesian(v))
        w = LinearAlgebra.cross(u_vec, v_vec)
        return CoordinateCartesian(w)
    end

    # P-Norm
    LinearAlgebra.norm(r̄::CoordinatePolar)       = r̄.r
    LinearAlgebra.norm(r̄::CoordinateRectangular) = LinearAlgebra.norm(SVector(r̄.x,r̄.y))
    LinearAlgebra.norm(r̄::CoordinateCartesian)   = LinearAlgebra.norm(SVector(r̄.x,r̄.y,r̄.z))
    LinearAlgebra.norm(r̄::CoordinateCylindrical) = LinearAlgebra.norm(SVector(r̄.rho,r̄.z))
    LinearAlgebra.norm(r̄::CoordinateSpherical)   = r̄.r

end
