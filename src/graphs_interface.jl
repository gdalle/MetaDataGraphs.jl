## Basic Graphs.jl functions

Base.eltype(::DataGraph{T}) where {T} = T
Graphs.edgetype(g::DataGraph) = edgetype(g.graph)

Graphs.nv(g::DataGraph) = nv(g.graph)
Graphs.ne(g::DataGraph) = ne(g.graph)

Graphs.vertices(g::DataGraph) = vertices(g.graph)
Graphs.edges(g::DataGraph) = edges(g.graph)

Graphs.has_vertex(g::DataGraph, v::Integer) = has_vertex(g.graph, v)
Graphs.has_edge(g::DataGraph, s::Integer, d::Integer) = has_edge(g.graph, s, d)

Graphs.inneighbors(g::DataGraph, v::Integer) = inneighbors(g.graph, v)
Graphs.outneighbors(g::DataGraph, v::Integer) = outneighbors(g.graph, v)

Graphs.is_directed(g::DataGraph) = is_directed(g.graph)
Graphs.is_directed(::Type{DataGraph{T,G}}) where {T,G} = is_directed(G)

function Base.zero(::DataGraph{T,G,VL,VD,ED}) where {T,G,VL,VD,ED}
    return DataGraph(G(); VL=VL, VD=VD, ED=ED)
end

## Add vertices and edges

function Graphs.add_vertex!(g::DataGraph{T,G,VL}, label::VL, data) where {T,G,VL}
    added = add_vertex!(g.graph)
    if added
        push!(g.labels, label)
        push!(g.vertex_data, data)
        g.vertices[label] = nv(g)
    end
    return added
end

function Graphs.add_edge!(g::DataGraph, s::Integer, d::Integer, data)
    added = add_edge!(g.graph, s, d)
    if added
        g.edge_data[order(g, s, d)] = data
    end
    return added
end

function Graphs.add_edge!(
    g::DataGraph{T,G,VL}, label_s::VL, label_d::VL, data
) where {T,G,VL}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return add_edge!(g, s, d, data)
end

## Remove edges

function Graphs.rem_edge!(g::DataGraph, s::Integer, d::Integer)
    removed = rem_edge!(g.graph, s, d)
    if removed
        delete!(g.edge_data, order(g, s, d))
    end
    return removed
end

function Graphs.rem_edge!(g::DataGraph{T,G,VL}, label_s::VL, label_d::VL) where {T,G,VL}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return remove_edge!(g, s, d)
end

## Get vertex and edge data

get_data(g::DataGraph, v::Integer) = g.vertex_data[v]
get_data(g::DataGraph, s::Integer, d::Integer) = g.edge_data[order(g, s, d)]

function get_data(g::DataGraph{T,G,VL}, label::VL) where {T,G,VL}
    v = get_vertex(g, label)
    return get_data(g, v)
end

function get_data(g::DataGraph{T,G,VL}, label_s::VL, label_d::VL) where {T,G,VL}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return get_data(g, s, d)
end

## Set vertex and edge data

function set_data!(g::DataGraph, v::Integer, data)
    if has_vertex(g, v)
        g.vertex_data[v] = data
        return true
    else
        return false
    end
end

function set_data!(g::DataGraph, s::Integer, d::Integer, data)
    if has_edge(g, s, d)
        g.edge_data[order(g, s, d)] = data
        return true
    else
        return false
    end
end

function set_data!(g::DataGraph{T,G,VL}, label::VL, data) where {T,G,VL}
    v = get_vertex(g, label)
    return set_data!(g, v, data)
end

function set_data!(g::DataGraph{T,G,VL}, label_s::VL, label_d::VL, data) where {T,G,VL}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return set_data!(g, s, d, data)
end
