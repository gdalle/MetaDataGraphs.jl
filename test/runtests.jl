using BenchmarkTools
using DataGraphs
using Documenter
using LinearAlgebra
using Test

@testset verbose = true "DataGraphs.jl" begin
    include("structure.jl")
    include("benchmark.jl")
end
