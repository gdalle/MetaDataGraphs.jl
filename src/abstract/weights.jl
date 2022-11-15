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

"""
    weights(g)

Compute the edge weights for an [`AbstractDataGraph`](@ref).

- If the edge data is of type `ED = Nothing`, return a lazy matrix full of ones.
- If the edge data is of type `ED <: Real`, fill a sparse matrix with it.
- If the edge data is of another type `ED`, try to use the attribute `edge_data.weight` for each edge.
"""
function Graphs.weights(g::AbstractDataGraph{T}) where {T}
    n = nv(g)
    eds = edges(g)
    I = [src(edge) for edge in eds]
    J = [dst(edge) for edge in eds]
    W = [get_edgeweight(g, src(edge), dst(edge)) for edge in eds]
    if is_directed(g)
        return sparse(I, J, W, n, n)
    else
        return sparse(vcat(I, J), vcat(J, I), vcat(W, W), n, n)
    end
end
