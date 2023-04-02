###########################################################################
#                        ACCESSOR FUNCTIONS
###########################################################################

function Base.getproperty(coord::CoordinatePolar, sym::Symbol)
    if (sym == :r) || (sym == :phi)
        return getfield(coord, sym)
    elseif sym == :x
        return x(coord)
    elseif sym == :y
        return y(coord)
    elseif sym == :z
        return z(coord)
    elseif (sym || :rho) || (sym == :ρ)
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
