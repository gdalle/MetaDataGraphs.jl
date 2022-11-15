using Aqua
using MetaDataGraphs
using Documenter
using JET
using JuliaFormatter
using Graphs
using LinearAlgebra
using Test

DocMeta.setdocmeta!(MetaDataGraphs, :DocTestSetup, :(using MetaDataGraphs); recursive=true)

@testset verbose = true "MetaDataGraphs.jl" begin
    @testset verbose = true "Code quality (Aqua.jl)" begin
        Aqua.test_all(MetaDataGraphs)
    end
    @testset verbose = true "Code formatting (JuliaFormatter.jl)" begin
        @test format(MetaDataGraphs; overwrite=false, verbose=false)
    end
    @testset verbose = true "Doctests" begin
        doctest(MetaDataGraphs)
    end
    @testset verbose = true "Structure" begin
        include("structure.jl")
    end
end
