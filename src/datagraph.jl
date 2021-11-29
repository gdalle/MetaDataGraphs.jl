"""
    DataGraph{T<:Integer,G<:AbstractGraph{T},VL,VD,ED} <: AbstractGraph{T}

Structure for graphs with metadata.

# Fields
- `graph::G`: the underlying graph, following the Graphs.jl `AbstractGraph{T}` interface
- `labels::Vector{VL}`: the list of vertex labels
- `vertices::Dict{VL,T}`: the dictionary mapping each vertex label to the associated integer index `v`
- `vertex_data::Vector{VD}`: the list of vertex data objects, indexed by integers `v`
- `edge_data::Dict{Tuple{T,T},ED}`: the list of edge data objects, indexed by integer tuples `(s,d)`
- `graph_data::GD`: a single graph data object
"""
@Base.kwdef struct DataGraph{T<:Integer,G<:AbstractGraph{T},VL,VD,ED,GD} <: AbstractGraph{T}
    graph::G
    labels::Vector{VL}
    vertices::Dict{VL,T}
    vertex_data::Vector{VD}
    edge_data::Dict{Tuple{T,T},ED}
    graph_data::GD
end

function DataGraph(graph::AbstractGraph{T}; VL, VD=Nothing, ED=Nothing, graph_data=nothing) where {T}
    if VL <: Integer
        error("Using integers as vertex labels for a DataGraph is not allowed.")
    else
        return DataGraph(
            graph=graph,
            labels=VL[],
            vertices=Dict{VL,T}(),
            vertex_data=VD[],
            edge_data=Dict{Tuple{T,T},ED}(),
            graph_data=graph_data
        )
    end
end

Base.copy(g::DataGraph) = deepcopy(g)

function Base.show(
    io::IO, g::DataGraph{T,G,VL,VD,ED,GD}
) where {T,G,VL,VD,ED,GD}
    n, m = nv(g), ne(g)
    return print(
        io,
        "DataGraph of size ($n, $m) based on a $G with\n- vertex labels of type $VL, \n- vertex data of type $VD, \n- edge data of type $ED, \n- graph data of type $GD."
    )
end

## Link between graph codes and metagraph labels

get_vertex(g::DataGraph, label) = g.vertices[label]
get_label(g::DataGraph, v) = g.labels[v]

Base.getindex(g::DataGraph{T,G,VL}, label::VL) where {T,G,VL} = get_vertex(g, label)
Base.haskey(g::DataGraph{T,G,VL}, label::VL) where {T,G,VL} = haskey(g.vertices, label)

## Define unique order for edges in undirected graphs

function order(g::DataGraph, s::Integer, d::Integer)
    if is_directed(g)
        return s, d
    else
        return min(s, d), max(s, d)
    end
end
