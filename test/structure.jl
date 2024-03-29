function test_graph(g)
    @test add_vertex!(g, :Paris, (48.8566, 2.3522))
    @test add_vertex!(g, :Lyon, (45.7640, 4.8357))
    @test add_vertex!(g, :Marseille, (43.2965, 5.3698))
    @test add_vertex!(g, :Berlin, (52.5200, 13.4050))
    @test add_vertex!(g, :Munich, (48.1351, 11.5820))
    @test_opt add_vertex!(g, :Clermont, (45.7772, 3.0870))

    @test add_edge!(g, g[:Paris], g[:Lyon], 393)
    @test add_edge!(g, g[:Paris], g[:Marseille], 661)
    @test add_edge!(g, g[:Lyon], g[:Marseille], 278)
    @test add_edge!(g, g[:Berlin], g[:Munich], 504)
    @test_opt add_edge!(g, g[:Paris], g[:Berlin], 879)

    @test eltype(g) == Int64
    @test_opt eltype(g)

    @test edgetype(g) == Graphs.SimpleGraphs.SimpleEdge{Int64}
    @test_opt edgetype(g)

    @test (nv(g), ne(g)) == (5, 4)
    @test vertices(g) == Base.OneTo(5)
    @test length(collect(edges(g))) == ne(g)

    @test has_vertex(g, 2)
    @test !has_vertex(g, 6)
    @test haskey(g, :Paris)
    @test !haskey(g, :Rome)
    @test_opt haskey(g, :Paris)

    @test has_edge(g, g[:Paris], g[:Lyon])
    is_directed(g) && @test !has_edge(g, g[:Lyon], g[:Paris])
    !is_directed(g) && @test has_edge(g, g[:Lyon], g[:Paris])
    @test !has_edge(g, g[:Paris], g[:Berlin])
    @test_opt has_edge(g, g[:Paris], g[:Lyon])

    @test outneighbors(g, g[:Paris]) == [2, 3]
    is_directed(g) && @test inneighbors(g, g[:Paris]) == Int[]
    !is_directed(g) && @test inneighbors(g, g[:Paris]) == [2, 3]
    @test inneighbors(g, g[:Munich]) == [4]
    @test_opt outneighbors(g, g[:Paris])

    @test get_data(g, 1) == (48.8566, 2.3522)
    @test get_data(g, :Paris) == (48.8566, 2.3522)
    @test_opt get_data(g, :Paris)

    @test get_data(g, 4, 5) == 504
    @test get_data(g, g[:Berlin], g[:Munich]) == 504
    !is_directed(g) && @test get_data(g, g[:Munich], g[:Berlin]) == 504
    @test_opt get_data(g, g[:Berlin], g[:Munich])

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
    @test_opt weights(g)

    @test add_vertex!(g, :Rome, (0.0, 0.0))
    @test set_data!(g, :Rome, (41.9028, 12.4964))
    @test get_data(g, :Rome) == (41.9028, 12.4964)

    if is_directed(g)
        h = reverse(g)
        @test !has_edge(h, h[:Paris], h[:Lyon])
        @test has_edge(h, h[:Lyon], h[:Paris])
        @test get_data(h, h[:Lyon], h[:Paris]) == get_data(g, g[:Paris], g[:Lyon])
        @test_opt reverse(g)
    end
end
