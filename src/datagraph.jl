"""
    DataGraph{T<:Integer,G<:AbstractGraph{T},VL,VD,ED} <: AbstractGraph{T}

Structure for graphs with metadata.

# Fields
- `graph::G`: the underlying graph, following the Graphs.jl `AbstractGraph{T}` interface
- `labels::Vector{VL}`: the list of vertex labels
- `vertices::Dict{VL,T}`: the dictionary mapping each vertex label to the associated integer index `v`
- `vertex_data::Vector{VD}`: the list of vertex data objects, indexed by integers `v`
- `edge_data::Dict{Tuple{T,T},ED}`: the list of edge data objects, indexed by integer tuples `(s,d)`
"""
struct DataGraph{T<:Integer,G<:AbstractGraph{T},VL,VD,ED} <: AbstractGraph{T}
    graph::G
    labels::Vector{VL}
    vertices::Dict{VL,T}
    vertex_data::Vector{VD}
    edge_data::Dict{Tuple{T,T},ED}
end

function DataGraph(graph::AbstractGraph{T}; VL, VD=Nothing, ED=Nothing) where {T}
    if VL <: Integer
        error("Using integers as vertex labels for a DataGraph is not allowed.")
    else
        return DataGraph(graph, VL[], Dict{VL,T}(), VD[], Dict{Tuple{T,T},ED}())
    end
end

Base.copy(g::DataGraph) = deepcopy(g)
