@testset "Graph manipulation" begin
    g = DataGraph(Graph(), VL=Symbol, VD=Tuple{Float64,Float64}, ED=Int64);

    @test add_vertex!(g, :Paris, (48.8566, 2.3522))
    @test add_vertex!(g, :Lyon, (45.7640, 4.8357))
    @test add_vertex!(g, :Marseille, (43.2965, 5.3698))
    @test add_vertex!(g, :Berlin, (52.5200, 13.4050))
    @test add_vertex!(g, :Munich, (48.1351, 11.5820))

    @test add_edge!(g, g[:Paris], g[:Lyon], 393)
    @test add_edge!(g, g[:Paris], g[:Marseille], 661)
    @test add_edge!(g, g[:Lyon], g[:Marseille], 278)
    @test add_edge!(g, g[:Berlin], g[:Munich], 504)

    @test eltype(g) == Int64
    @test edgetype(g) == Graphs.SimpleGraphs.SimpleEdge{Int64}
    @test !is_directed(g)

    @test (nv(zero(g)), ne(zero(g))) == (0, 0)
    @test (nv(g), ne(g)) == (5, 4)
    @test vertices(g) == Base.OneTo(5)
    edges(g) |> collect

    @test has_vertex(g, 2)
    @test !has_vertex(g, 6)
    @test haskey(g, :Paris)
    @test !haskey(g, :Rome)
    @test has_edge(g, g[:Paris], g[:Lyon])
    @test !has_edge(g, g[:Paris], g[:Berlin])

    @test outneighbors(g, g[:Paris]) == [2, 3]
    @test inneighbors(g, g[:Berlin]) == [5]

    @test get_data(g, 1) == (48.8566, 2.3522)
    @test get_data(g, :Paris) == (48.8566, 2.3522)

    @test get_data(g, 4, 5) == 504
    @test get_data(g, g[:Berlin], g[:Munich]) == 504
    @test get_data(g, g[:Munich], g[:Berlin]) == 504

    @test add_vertex!(g, :Rome, (0., 0.))
    @test set_data!(g, :Rome, (41.9028, 12.4964))
    @test get_data(g, :Rome) == (41.9028, 12.4964)

    @test add_edge!(g, g[:Rome], g[:Berlin], -1)
    @test set_data!(g, g[:Rome], g[:Berlin], 1184)
    @test rem_edge!(g, g[:Rome], g[:Berlin])
    @test (nv(g), ne(g)) == (6, 4)
end
