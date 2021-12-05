"""
    AbstractDataGraph{T,VL,VD,ED,GD} <: AbstractGraph{T}

General template for graphs with metadata. Here,

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

Base.eltype(::AbstractDataGraph{T}) where {T} = T
