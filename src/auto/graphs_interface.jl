
## Basic Graphs.jl functions

Graphs.edgetype(g::AutoDataGraph) = edgetype(g.graph)

Graphs.nv(g::AutoDataGraph) = nv(g.graph)
Graphs.ne(g::AutoDataGraph) = ne(g.graph)

Graphs.vertices(g::AutoDataGraph) = vertices(g.graph)
Graphs.edges(g::AutoDataGraph) = edges(g.graph)

Graphs.has_vertex(g::AutoDataGraph, v::Integer) = has_vertex(g.graph, v)
Graphs.has_edge(g::AutoDataGraph, s::Integer, d::Integer) = has_edge(g.graph, s, d)

Graphs.inneighbors(g::AutoDataGraph, v::Integer) = inneighbors(g.graph, v)
Graphs.outneighbors(g::AutoDataGraph, v::Integer) = outneighbors(g.graph, v)

Graphs.is_directed(g::AutoDataGraph) = is_directed(g.graph)
Graphs.is_directed(::Type{<:AutoDataGraph{T,G}}) where {T,G} = is_directed(G)

function Base.zero(g::AutoDataGraph{T,G,VL,VD,ED}) where {T,G,VL,VD,ED}
    return AutoDataGraph(G(); VL=VL, VD=VD, ED=ED, graph_data=get_data(g))
end

## Add vertices and edges

function Graphs.add_vertex!(
    g::AutoDataGraph{T,G,VL,VD}, label::VL, data::VD
) where {T,G,VL,VD}
    if haskey(g, label)
        return false
    else
        added = add_vertex!(g.graph)
        if added
            push!(g.labels, label)
            g.vertices[label] = nv(g)
            push!(g.vertex_data, data)
        end
        return added
    end
end

function Graphs.add_edge!(
    g::AutoDataGraph{T,G,VL,VD,ED}, s::Integer, d::Integer, data::ED
) where {T,G,VL,VD,ED}
    added = add_edge!(g.graph, s, d)
    if added
        g.edge_data[order(g, s, d)] = data
    end
    return added
end

## Other utilities

function Graphs.reverse(g::AutoDataGraph)
    rev_graph = reverse(g.graph)
    rev_labels = deepcopy(g.labels)
    rev_vertices = deepcopy(g.vertices)
    rev_vertex_data = deepcopy(g.vertex_data)
    rev_edge_data = Dict((d, s) => deepcopy(data) for ((s, d), data) in g.edge_data)
    rev_graph_data = deepcopy(g.graph_data)
    rev_g = AutoDataGraph(;
        graph=rev_graph,
        labels=rev_labels,
        vertices=rev_vertices,
        vertex_data=rev_vertex_data,
        edge_data=rev_edge_data,
        graph_data=rev_graph_data,
    )
    return rev_g
end
