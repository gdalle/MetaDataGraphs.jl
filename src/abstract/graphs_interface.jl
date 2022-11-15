## Basic Graphs.jl functions

Base.eltype(::AbstractDataGraph{T}) where {T} = T
Graphs.edgetype(::AbstractDataGraph{T}) where {T} = Edge{T}

function Graphs.vertices(g::AbstractDataGraph)
    return 1:nv(g)
end

function Graphs.has_vertex(g::AbstractDataGraph, v::Integer)
    return v in vertices(g)
end

function Graphs.edges(g::AbstractDataGraph)
    return (Edge(u, v) for u in vertices(g) for v in outneighbors(g, u))
end

function Graphs.has_edge(g::AbstractDataGraph, s::Integer, d::Integer)
    return (has_vertex(g, s) && has_vertex(g, d) && insorted(d, outneighbors(g, s)))
end

## Label-based access

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
        s, d = get_vertex(g, label_s), get_vertex(g, label_d)
        return has_edge(g, s, d)
    else
        return false
    end
end

## Label-based modification

"""
    rem_vertex!(g, label)

Remove the vertex with label `label` if it exists.
"""
function Graphs.rem_vertex!(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL}
    v = get_vertex(g, label)
    return rem_vertex!(g, v)
end

"""
    add_edge!(g, label_s, label_d, data)

Add an edge between the vertices with labels `label_s` and `label_d`, along with the associated `data`.
"""
function Graphs.add_edge!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VL, data::ED
) where {T,VL,VD,ED}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return add_edge!(g, s, d, data)
end

"""
    rem_edge!(g, label_s, label_d)

Remove the edge between the vertices with labels `label_s` and `label_d` if it exists.
"""
function Graphs.rem_edge!(
    g::AbstractDataGraph{T,VL,VD}, label_s::VL, label_d::VL
) where {T,VL,VD}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return rem_edge!(g, s, d)
end
