using DataGraphs
using Documenter
using Test

@testset "DataGraphs.jl" begin
    doctest(DataGraphs)
    include("datagraph.jl")
end
