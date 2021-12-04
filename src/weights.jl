function Graphs.weights(
    g::AbstractDataGraph{T,VL,VD,ED,GD}
) where {T,G,VL,VD,ED<:Nothing,GD}
    return Graphs.DefaultDistance(nv(g))
end

function Graphs.weights(g::AbstractDataGraph{T,VL,VD,ED,GD}) where {T,VL,VD,ED<:Real,GD}
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
