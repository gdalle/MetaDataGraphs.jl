function Graphs.weights(g::AbstractDataGraph{T,VL,VD,ED}) where {T,VL,VD,ED<:Nothing}
    return Graphs.DefaultDistance(nv(g))
end

function get_edgeweight(
    g::AbstractDataGraph{T,VL,VD,ED}, s::Integer, d::Integer
) where {T,VL,VD,ED<:Real}
    return get_data(g, s, d)
end

function get_edgeweight(
    g::AbstractDataGraph{T,VL,VD,ED}, s::Integer, d::Integer
) where {T,VL,VD,ED}
    return get_data(g, s, d).weight
end

function Graphs.weights(g::AbstractDataGraph{T,VL,VD,ED}) where {T,VL,VD,ED}
    n = nv(g)
    I, J, V = Int[], Int[], ED[]
    for edge in edges(g)
        s, d = src(edge), dst(edge)
        weight = get_edgeweight(g, s, d)
        push!(I, s)
        push!(J, d)
        push!(V, weight)
        if !is_directed(g)
            push!(I, d)
            push!(J, s)
            push!(V, weight)
        end
    end
    return sparse(I, J, V, n, n)
end
