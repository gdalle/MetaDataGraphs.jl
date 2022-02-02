function test_graph(g)
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

    @test (nv(zero(g)), ne(zero(g))) == (0, 0)
    @test (nv(g), ne(g)) == (5, 4)
    @test vertices(g) == Base.OneTo(5)
    # collect(edges(g))

    @test has_vertex(g, 2)
    @test !has_vertex(g, 6)
    @test haskey(g, :Paris)
    @test !haskey(g, :Rome)

    @test has_edge(g, g[:Paris], g[:Lyon])
    is_directed(g) && @test !has_edge(g, g[:Lyon], g[:Paris])
    !is_directed(g) && @test has_edge(g, g[:Lyon], g[:Paris])
    @test !has_edge(g, g[:Paris], g[:Berlin])

    @test outneighbors(g, g[:Paris]) == [2, 3]
    is_directed(g) && @test inneighbors(g, g[:Paris]) == Int[]
    !is_directed(g) && @test inneighbors(g, g[:Paris]) == [2, 3]
    @test inneighbors(g, g[:Munich]) == [4]

    @test get_data(g, 1) == (48.8566, 2.3522)
    @test get_data(g, :Paris) == (48.8566, 2.3522)

    @test get_data(g, 4, 5) == 504
    @test get_data(g, g[:Berlin], g[:Munich]) == 504
    !is_directed(g) && @test get_data(g, g[:Munich], g[:Berlin]) == 504

    w = [
        0 393 661 0 0
        0 0 278 0 0
        0 0 0 0 0
        0 0 0 0 504
        0 0 0 0 0
    ]
    wg = Matrix(weights(g))
    if is_directed(g)
        @test wg == w
    else
        @test wg == Matrix(Symmetric(w))
    end

    @test add_vertex!(g, :Rome, (0.0, 0.0))
    @test set_data!(g, :Rome, (41.9028, 12.4964))
    @test get_data(g, :Rome) == (41.9028, 12.4964)

    if is_directed(g)
        h = reverse(g)
        @test !has_edge(h, h[:Paris], h[:Lyon])
        @test has_edge(h, h[:Lyon], h[:Paris])
        @test get_data(h, h[:Lyon], h[:Paris]) == get_data(g, g[:Paris], g[:Lyon])
    end
end

@testset "Dict storage" begin
    g1 = DictDataGraph(SimpleGraph{Int}; VL=Symbol, VD=Tuple{Float64,Float64}, ED=Int64)
    test_graph(g1)
    g2 = DictDataGraph(SimpleDiGraph{Int}; VL=Symbol, VD=Tuple{Float64,Float64}, ED=Int64)
    test_graph(g2)
end
@testset "Array storage" begin
    g3 = ArrayDataDiGraph{Int}(; VL=Symbol, VD=Tuple{Float64,Float64}, ED=Int64)
    test_graph(g3)
end
