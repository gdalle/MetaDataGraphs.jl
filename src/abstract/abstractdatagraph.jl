"""
    AbstractDataGraph{T,VL,VD,ED,GD} <: AbstractGraph{T}

General template for graphs with metadata.

- `T<:Integer` is the type of vertices
- `VL` is the type of vertex labels (cannot be a subtype of `Integer`)
- `VD` is the type of vertex data objects
- `ED` is the type of edge data objects
- `GD` is the type of the graph data object
"""
abstract type AbstractDataGraph{T<:Integer,VL,VD,ED,GD} <: AbstractGraph{T} end

Base.copy(g::AbstractDataGraph) = deepcopy(g)

function Base.show(io::IO, g::AbstractDataGraph{T,VL,VD,ED,GD}) where {T,VL,VD,ED,GD}
    n, m = nv(g), ne(g)
    return print(
        io,
        "DataGraph of size ($n, $m) with vertex labels of type $VL, vertex data of type $VD, edge data of type $ED and graph data of type $GD.",
    )
end

## Vertex-label translation

"""
    get_vertex(g, label)

Retrieve the vertex associated with label `label.
"""
function get_vertex(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL}
    return error("Not implemented for $(typeof(g))")
end

"""
    get_label(g, v)

Retrieve the label associated with vertex `v`.
"""
function get_label(g::AbstractDataGraph, v::Integer)
    return error("Not implemented for $(typeof(g))")
end

## Dict behavior

"""
    haskey(g, label)

Check whether a vertex with label `label` exists.
"""
function Base.haskey(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL}
    return error("Not implemented for $(typeof(g))")
end

"""
    getindex(g, label)

Alias for [`get_vertex(g, label)`](@ref), intended for dictionary-like use.
"""
function Base.getindex(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL}
    return get_vertex(g, label)
end
