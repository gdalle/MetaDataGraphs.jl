"""
    ArrayDataDiGraph{T,VL,VD,ED,GD} <: AbstractDataGraph{T}

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
Base.@kwdef mutable struct ArrayDataDiGraph{T<:Integer,VL,VD,ED,GD} <:
                           AbstractDataGraph{T,VL,VD,ED,GD}
    ne::Int
    fadjlist::Vector{Vector{T}}
    badjlist::Vector{Vector{T}}
    labels::Vector{VL}
    vertices::Dict{VL,T}
    vertex_data::Vector{VD}
    edge_data::Vector{Vector{ED}}
    graph_data::GD
end

function ArrayDataDiGraph{T}(; VL, VD=Nothing, ED=Nothing, graph_data=nothing) where {T}
    if VL <: Integer
        error("Using integers as vertex labels for a DataGraph is not allowed.")
    else
        return ArrayDataDiGraph(;
            ne=0,
            fadjlist=Vector{T}[],
            badjlist=Vector{T}[],
            labels=VL[],
            vertices=Dict{VL,T}(),
            vertex_data=VD[],
            edge_data=Vector{ED}[],
            graph_data=graph_data,
        )
    end
end

## Link between vertices and labels

get_vertex(g::ArrayDataDiGraph{T,VL}, label::VL) where {T,VL} = g.vertices[label]
get_label(g::ArrayDataDiGraph, v::Integer) = g.labels[v]

Base.haskey(g::ArrayDataDiGraph{T,VL}, label::VL) where {T,VL} = haskey(g.vertices, label)
Base.getindex(g::ArrayDataDiGraph{T,VL}, label::VL) where {T,VL} = get_vertex(g, label)