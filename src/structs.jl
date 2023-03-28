################################################################################
#                           COORDINATE TYPE DEFINITIONS
################################################################################

abstract type AbstractCoordinate{N} end

    ############################################################################
    #                              2D COORDINATES
    ############################################################################

    struct CoordinatePolar{L,A} <: AbstractCoordinate{2} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}
        r::L
        phi::A
    end

    struct CoordinateRectangular{L} <: AbstractCoordinate{2} where {L<:Unitful.Length}
        x::L
        y::L
    end

    ############################################################################
    #                              3D COORDINATES
    ############################################################################

    struct CoordinateCartesian{L} <: AbstractCoordinate{3} where {L<:Unitful.Length}
        x::L
        y::L
        z::L
    end

    struct CoordinateCylindrical{L,A} <: AbstractCoordinate{3} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}
        rho::L
        phi::A
        z::L
    end

    struct CoordinateSpherical{L,A} <: AbstractCoordinate{3} where {L<:Unitful.Length, A<:DimensionfulAngles.Angle}
        r::L
        theta::A
        phi::A
    end

export AbstractCoordinate
export CoordinateRectangular, CoordinatePolar
export CoordinateCartesian, CoordinateCylindrical, CoordinateSpherical
