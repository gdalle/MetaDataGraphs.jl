using Aqua
using DataGraphs
using Documenter
using Graphs
using JET
using LinearAlgebra
using Test

DocMeta.setdocmeta!(DataGraphs, :DocTestSetup, :(using DataGraphs); recursive=true)

@testset verbose = true "DataGraphs.jl" begin
    @testset verbose = true "Doctests" begin
        doctest(DataGraphs)
    end
    @testset verbose = true "Code quality" begin
        Aqua.test_all(DataGraphs)
    end
    @testset verbose = true "Structure" begin
        include("structure.jl")
    end
end
