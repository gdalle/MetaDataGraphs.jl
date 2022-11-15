"""
    DataDiGraph{T,VL,VD,ED,GD} <: AbstractDataGraph{T}

Structure for graphs with metadata based on adjacency list storage.

# Fields
- `ne::Int`: number of edges
- `fadjlist::Vector{Vector{Int}}`: forward adjacency lists
- `badjlist::Vector{Vector{Int}}`: backward adjacency lists
- `labels::Vector{VL}`: list of vertex labels
- `vertices::Dict{VL,T}`: dictionary mapping each vertex label to the associated integer index `v`
- `vertex_data::Vector{VD}`: list of vertex data objects, indexed by integers `v`
- `edge_data::Vector{Vector{ED}}`: list of edge data objects, indexed by `s` first and `d_index` second, where `d_index` is the rank of `d` among the outneighbors of `s`
- `graph_data::GD`: single graph data object
"""
mutable struct DataDiGraph{T<:Integer,VL,VD,ED,GD} <: AbstractDataGraph{T,VL,VD,ED,GD}
    ne::Int
    const fadjlist::Vector{Vector{T}}
    const badjlist::Vector{Vector{T}}
    const labels::Vector{VL}
    const vertices::Dict{VL,T}
    const vertex_data::Vector{VD}
    const edge_data::Vector{Vector{ED}}
    graph_data::GD
end

"""
    DataDiGraph{T,VL,VD,ED}(graph_data)

Constructor taking only label and data types to create an empty [`DataDiGraph`](@ref).
"""
function DataDiGraph{T,VL,VD,ED}(graph_data::GD=nothing) where {T,VL,VD,ED,GD}
    ne = 0
    fadjlist = Vector{T}[]
    badjlist = Vector{T}[]
    labels = VL[]
    vertices = Dict{VL,T}()
    vertex_data = VD[]
    edge_data = Vector{ED}[]
    return DataDiGraph(
        ne, fadjlist, badjlist, labels, vertices, vertex_data, edge_data, graph_data
    )
end

## Vertex-label translation

get_vertex(g::DataDiGraph{T,VL}, label::VL) where {T,VL} = g.vertices[label]

get_label(g::DataDiGraph, v::Integer) = g.labels[v]

## Dict behavior

Base.haskey(g::DataDiGraph{T,VL}, label::VL) where {T,VL} = haskey(g.vertices, label)
