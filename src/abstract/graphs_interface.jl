Base.eltype(::AbstractDataGraph{T}) where {T} = T

## Edge access

"""
    has_vertex(g, label)

Check whether a vertex with label `label` exists by calling [`haskey(g, label)`](@ref).
"""
function Graphs.has_vertex(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL}
    return haskey(g, label)
end

"""
    has_edge(g, label_s, label_d)

Check whether an edge exists between the vertices with labels `label_s` and `label_d`.
"""
function Graphs.has_edge(g::AbstractDataGraph{T,VL}, label_s::VL, label_d::VL) where {T,VL}
    if has_vertex(g, label_s) && has_vertex(g, label_d)
        s = get_vertex(g, label_s)
        d = get_vertex(g, label_d)
        return has_edge(g, s, d)
    else
        return false
    end
end

## Vertex and edge modification

"""
    add_edge!(g::DataDiGraph, label_s, label_d, data)

Add an edge to `g` by specifying the labels `label_s` and `label_d` of both vertices, along with the associated `data`.
"""
function Graphs.add_edge!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VL, data::ED
) where {T,VL,VD,ED}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return add_edge!(g, s, d, data)
end

"""
    add_vertex!(g, label)

Shortcut for `add_vertex(g, label, nothing)`, to use in graphs where vertices have no metadata.
"""
function Graphs.add_vertex!(
    g::AbstractDataGraph{T,VL,VD,ED}, label::VL
) where {T,VL,VD<:Nothing,ED}
    return add_vertex!(g, label, nothing)
end

"""
    add_edge!(g, s, d)

Shortcut for `add_edge!(g, s, d, nothing)`, to use in graphs where edges have no metadata.
"""
function Graphs.add_edge!(
    g::AbstractDataGraph{T,VL,VD,ED}, s::Integer, d::Integer
) where {T,VL,VD,ED<:Nothing}
    return add_edge!(g, s, d, nothing)
end

"""
    add_edge!(g, label_s, label_d)

Shortcut for `add_edge!(g, label_s, label_d, nothing)`, to use in graphs where edges have no metadata.
"""
function Graphs.add_edge!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VL
) where {T,VL,VD,ED<:Nothing}
    return add_edge!(g, label_s, label_d, nothing)
end
