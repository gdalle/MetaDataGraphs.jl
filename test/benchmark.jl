function fill_square!(g, n, d)
    for i = 1:n, j = 1:n
        add_vertex!(g, (i,j), nothing)
    end
    for i = 1:n, j = 1:n, di in 1:d, dj in 1(-d):d
        add_edge!(g, (i,j), (((i+di)%n)+1, ((j+di)%n)+1), (weight=1., open=true))
    end
end

function sum_weights(g)
    s = 0.
    for v in vertices(g)
        for w in outneighbors(g, v)
            s += get_data(g, v, w).weight
        end
    end
    return s
end

@testset "Benchmark" begin
    for n in [100, 500], d in [2, 4, 8, 16]
        g1 = AutoDataGraph(
            DiGraph(); VL=Tuple{Int,Int}, VD=Nothing, ED=@NamedTuple{weight::Float64, open::Bool}
        )
        g2 = ManualDataDiGraph{Int}(
            VL=Tuple{Int,Int}, VD=Nothing, ED=@NamedTuple{weight::Float64, open::Bool}
        )
        fill_square!(g1, n, d)
        fill_square!(g2, n, d)
        @test (@elapsed sum_weights(g1)) > (@elapsed sum_weights(g2))
    end
end
