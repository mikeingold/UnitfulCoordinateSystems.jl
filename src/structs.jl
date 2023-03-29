################################################################################
#                           COORDINATE TYPE DEFINITIONS
################################################################################

"""
AbstractCoordinate{N}

Used to represent a Unitful `N`-dimensional coordinate.
"""
abstract type AbstractCoordinate{N} end

    ############################################################################
    #                              2D COORDINATES
    ############################################################################

    """
    CoordinatePolar{L,A} <: AbstractCoordinate{2} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}

    Used to represent a two-dimensional polar coordinate located on the xy-plane
    and defined by: a radius `r`, and an azimuth angle `phi` measured relative
    to the positive x-axis.
    """
    struct CoordinatePolar{L,A} <: AbstractCoordinate{2} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}
        r::L
        phi::A
    end

    """
    CoordinateRectangular{L} <: AbstractCoordinate{2} where {L<:Unitful.Length}

    Used to represent a two-dimensional rectangular coordinate located on the
    xy-plane and defined by orthogonal `x` and `y` components.
    """
    struct CoordinateRectangular{L} <: AbstractCoordinate{2} where {L<:Unitful.Length}
        x::L
        y::L
    end

    ############################################################################
    #                              3D COORDINATES
    ############################################################################

    """
    CoordinateCartesian{L} <: AbstractCoordinate{3} where {L<:Unitful.Length}

    Used to represent a three-dimensional Cartesian coordinate, defined by
    orthogonal `x`, `y`, and `z` components.
    """
    struct CoordinateCartesian{L} <: AbstractCoordinate{3} where {L<:Unitful.Length}
        x::L
        y::L
        z::L
    end

    """
    CoordinateCylindrical{L,A} <: AbstractCoordinate{3} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}

    Used to represent a three-dimensional cylindrical coordinate, defined by: a
    range `rho` from the origin to the point on the xy-plane subtended by the
    coordinate, an azimuth angle `phi` measured relative to the positive x-axis,
    and an orthogonal `z` component.
    """
    struct CoordinateCylindrical{L,A} <: AbstractCoordinate{3} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}
        rho::L
        phi::A
        z::L
    end

    """
    CoordinateSpherical{L,A} <: AbstractCoordinate{3} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}

    Used to represent a three-dimensional spherical coordinate, defined by: a
    radius `r` from the origin to the coordinate, a polar angle `theta` measured
    relative to the positive z-axis, and an azimuth angle `phi` measured relative
    to the positive x-axis.
    """
    struct CoordinateSpherical{L,A} <: AbstractCoordinate{3} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}
        r::L
        theta::A
        phi::A
    end
