push!(LOAD_PATH, "../src/")

using Documenter, UnitfulCoordinateSystems

makedocs(sitename="UnitfulCoordinateSystems.jl",
	 authors = "Michael Ingold <mike.ingold@gmail.com>",
	 pages = [
		"Home" => "index.md",
		"Reference" => "api.md"
	 ]
	)

deploydocs(repo="github.com/mikeingold/UnitfulCoordinateSystems.jl")

