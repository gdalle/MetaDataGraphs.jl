function Graphs.weights(g::DataGraph{T,G,VL,VD,ED}) where {T,G,VL,VD,ED<:Nothing}
    return Graphs.DefaultDistance(nv(g))
end

function Graphs.weights(g::DataGraph{T,G,VL,VD,ED}) where {T,G,VL,VD,ED<:Real}
    n = nv(g)
    I, J, V = Int[], Int[], ED[]
    for edge in edges(g)
        s, d = src(edge), dst(edge)
        data = get_data(g, s, d)
        push!(I, s)
        push!(J, d)
        push!(V, data)
        if !is_directed(g)
            push!(I, d)
            push!(J, s)
            push!(V, data)
        end
    end
    return sparse(I, J, V, n, n)
end
