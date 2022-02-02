"""
    DictDataGraph{T,G<:AbstractGraph{T},VL,VD,ED,GD} <: AbstractDataGraph{T}

Structure for graphs with metadata based on an underlying dataless graph.

# Fields
- `graph::G`: underlying graph, following the Graphs.jl `AbstractGraph{T}` interface
- `labels::Vector{VL}`: list of vertex labels
- `vertices::Dict{VL,T}`: dictionary mapping each vertex label to the associated integer index `v`
- `vertex_data::Vector{VD}`: list of vertex data objects, indexed by integers `v`
- `edge_data::Dict{Tuple{T,T},ED}`: list of edge data objects, indexed by integer tuples `(s,d)`
- `graph_data::GD`: single graph data object
"""
mutable struct DictDataGraph{T,G<:AbstractGraph{T},VL,VD,ED,GD} <:
               AbstractDataGraph{T,VL,VD,ED,GD}
    graph::G
    labels::Vector{VL}
    vertices::Dict{VL,T}
    vertex_data::Vector{VD}
    edge_data::Dict{Tuple{T,T},ED}
    graph_data::GD
end

function DictDataGraph(
    ::Type{G}; VL=Symbol, VD=Nothing, ED=Nothing, graph_data=nothing
) where {T,G<:AbstractGraph{T}}
    graph = zero(G)
    labels = VL[]
    vertices = Dict{VL,T}()
    vertex_data = VD[]
    edge_data = Dict{Tuple{T,T},ED}()
    return DictDataGraph(graph, labels, vertices, vertex_data, edge_data, graph_data)
end

## Link between vertices and labels

get_vertex(g::DictDataGraph{T,G,VL}, label::VL) where {T,G,VL} = g.vertices[label]
get_label(g::DictDataGraph, v::Integer) = g.labels[v]

Base.haskey(g::DictDataGraph{T,G,VL}, label::VL) where {T,G,VL} = haskey(g.vertices, label)
Base.getindex(g::DictDataGraph{T,G,VL}, label::VL) where {T,G,VL} = get_vertex(g, label)

## Define unique order for edges in undirected graphs

function order(g::DictDataGraph, s::Integer, d::Integer)
    if is_directed(g)
        return s, d
    else
        return min(s, d), max(s, d)
    end
end
