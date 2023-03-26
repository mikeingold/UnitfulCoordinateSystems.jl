push!(LOAD_PATH, "../src/")

using Documenter, UnitfulCoordinateSystems

makedocs(sitename="UnitfulCoordinateSystems.jl",
	 authors = "Michael Ingold",
	 pages = [
		"Home" => "index.md",
	 ]
	)

deploydocs(repo="github.com/mikeingold/UnitfulCoordinateSystems.jl")

