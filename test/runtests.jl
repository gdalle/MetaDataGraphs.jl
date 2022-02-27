using BenchmarkTools
using DataGraphs
using Documenter
using JET
using LinearAlgebra
using Test

@testset verbose = true "DataGraphs.jl" begin
    include("structure.jl")
end
