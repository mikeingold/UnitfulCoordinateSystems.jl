
using Unitful, UnitfulCoordinateSystems, Test

@testset "Component Functions on CoordinateRectangular" begin
	coord = CoordinateRectangular(1.0u"m", 2.0u"m")

	@test UnitfulCoordinateSystems.x(coord) ≈ 1.0u"m"
	@test UnitfulCoordinateSystems.y(coord) ≈ 2.0u"m"
	@test UnitfulCoordinateSystems.z(coord) ≈ 0.0u"m"
	@test UnitfulCoordinateSystems.r(coord) ≈ sqrt(5.0)*u"m"

	@test UnitfulCoordinateSystems.rho(coord) ≈ sqrt(5.0)*u"m"
	@test UnitfulCoordinateSystems.ρ(coord)   ≈ sqrt(5.0) * u"m"

	@test UnitfulCoordinateSystems.phi(coord) ≈ atand(2.0) * u"°"
	@test UnitfulCoordinateSystems.φ(coord)   ≈ atand(2.0) * u"°"
	@test UnitfulCoordinateSystems.ϕ(coord)   ≈ atand(2.0) * u"°"

	@test UnitfulCoordinateSystems.theta(coord) ≈ 90.0u"°"
	@test UnitfulCoordinateSystems.θ(coord)     ≈ 90.0u"°"
	@test UnitfulCoordinateSystems.ϑ(coord)     ≈ 90.0u"°"
end

@testset "Component Functions on CoordinatePolar" begin
	coord = CoordinatePolar(1.0u"m", 45.0u"°")

	@test UnitfulCoordinateSystems.x(coord) ≈ sqrt(2.0)/2 * u"m"
	@test UnitfulCoordinateSystems.y(coord) ≈ sqrt(2.0)/2 * u"m"
	@test UnitfulCoordinateSystems.z(coord) ≈ 0.0u"m"
	@test UnitfulCoordinateSystems.r(coord) ≈ 1.0u"m"

	@test UnitfulCoordinateSystems.rho(coord) ≈ 1.0u"m"
	@test UnitfulCoordinateSystems.ρ(coord)   ≈ 1.0u"m"

	@test UnitfulCoordinateSystems.phi(coord) ≈ 45.0u"°"
	@test UnitfulCoordinateSystems.φ(coord)   ≈ 45.0u"°"
	@test UnitfulCoordinateSystems.ϕ(coord)   ≈ 45.0u"°"
	
	@test UnitfulCoordinateSystems.theta(coord) ≈ 90.0u"°"
	@test UnitfulCoordinateSystems.θ(coord)     ≈ 90.0u"°"
	@test UnitfulCoordinateSystems.ϑ(coord)     ≈ 90.0u"°"
end

@testset "Component Functions on CoordinateCartesian" begin
	coord = CoordinateCartesian(1.0u"m", 2.0u"m", 3.0u"m")

	@test UnitfulCoordinateSystems.x(coord) ≈ 1.0u"m"
	@test UnitfulCoordinateSystems.y(coord) ≈ 2.0u"m"
	@test UnitfulCoordinateSystems.z(coord) ≈ 3.0u"m"
	@test UnitfulCoordinateSystems.r(coord) ≈ sqrt(14.0)*u"m"

	@test UnitfulCoordinateSystems.ρ(coord)   ≈ sqrt(5.0) * u"m"
	@test UnitfulCoordinateSystems.rho(coord) ≈ sqrt(5.0)*u"m"
	
	@test UnitfulCoordinateSystems.phi(coord) ≈ atand(2.0) * u"°"
	@test UnitfulCoordinateSystems.φ(coord)   ≈ atand(2.0) * u"°"
	@test UnitfulCoordinateSystems.ϕ(coord)   ≈ atand(2.0) * u"°"
	
	@test UnitfulCoordinateSystems.theta(coord) ≈ acosd(3.0/sqrt(14.0)) * u"°"
	@test UnitfulCoordinateSystems.θ(coord)     ≈ acosd(3.0/sqrt(14.0)) * u"°"
	@test UnitfulCoordinateSystems.ϑ(coord)     ≈ acosd(3.0/sqrt(14.0)) * u"°"
end

@testset "Component Functions on CoordinateCylindrical" begin
	coord = CoordinateCylindrical(1.0u"m", 45.0u"°", 3.0u"m")

	@test UnitfulCoordinateSystems.x(coord) ≈ (sqrt(2.0) / 2.0) * u"m"
	@test UnitfulCoordinateSystems.y(coord) ≈ (sqrt(2.0) / 2.0) * u"m"
	@test UnitfulCoordinateSystems.z(coord) ≈ 3.0u"m"
	@test UnitfulCoordinateSystems.r(coord) ≈ sqrt(10.0)*u"m"

	@test UnitfulCoordinateSystems.ρ(coord)   ≈ 1.0u"m"
	@test UnitfulCoordinateSystems.rho(coord) ≈ 1.0u"m"
	
	@test UnitfulCoordinateSystems.phi(coord) ≈ 45.0u"°"
	@test UnitfulCoordinateSystems.φ(coord)   ≈ 45.0u"°"
	@test UnitfulCoordinateSystems.ϕ(coord)   ≈ 45.0u"°"
	
	@test UnitfulCoordinateSystems.theta(coord) ≈ acosd(3.0) * u"°"
	@test UnitfulCoordinateSystems.θ(coord)     ≈ acosd(3.0) * u"°"
	@test UnitfulCoordinateSystems.ϑ(coord)     ≈ acosd(3.0) * u"°"
end

@testset "Component Functions on CoordinateSpherical" begin
	coord = CoordinateSpherical(1.0u"m", 45.0u"°", 45.0u"°")

	@test UnitfulCoordinateSystems.x(coord) ≈ 0.5u"m"
	@test UnitfulCoordinateSystems.y(coord) ≈ 0.5u"m"
	@test UnitfulCoordinateSystems.z(coord) ≈ (sqrt(2.0) / 2.0) * u"m"
	@test UnitfulCoordinateSystems.r(coord) ≈ 1.0u"m"

	@test UnitfulCoordinateSystems.ρ(coord)   ≈ (sqrt(2.0) / 2.0) * u"m"
	@test UnitfulCoordinateSystems.rho(coord) ≈ (sqrt(2.0) / 2.0) * u"m"
	
	@test UnitfulCoordinateSystems.phi(coord) ≈ 45.0u"°"
	@test UnitfulCoordinateSystems.φ(coord)   ≈ 45.0u"°"
	@test UnitfulCoordinateSystems.ϕ(coord)   ≈ 45.0u"°"
	
	@test UnitfulCoordinateSystems.theta(coord) ≈ 45.0u"°"
	@test UnitfulCoordinateSystems.θ(coord)     ≈ 45.0u"°"
	@test UnitfulCoordinateSystems.ϑ(coord)     ≈ 45.0u"°"
end
