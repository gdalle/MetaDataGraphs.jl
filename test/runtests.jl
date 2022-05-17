using Aqua
using MetaDataGraphs
using Documenter
using Graphs
using JET
using LinearAlgebra
using Test

DocMeta.setdocmeta!(MetaDataGraphs, :DocTestSetup, :(using MetaDataGraphs); recursive=true)

@testset verbose = true "MetaDataGraphs.jl" begin
    @testset verbose = true "Doctests" begin
        doctest(MetaDataGraphs)
    end
    @testset verbose = true "Code quality" begin
        Aqua.test_all(MetaDataGraphs)
    end
    @testset verbose = true "Structure" begin
        include("structure.jl")
    end
end
