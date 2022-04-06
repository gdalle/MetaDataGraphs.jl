## Basic Graphs.jl functions

Graphs.edgetype(::DataDiGraph{T}) where {T} = Edge{T}

Graphs.nv(g::DataDiGraph) = length(g.fadjlist)
Graphs.ne(g::DataDiGraph) = g.ne

Graphs.vertices(g::DataDiGraph) = 1:nv(g)

function Graphs.edges(g::DataDiGraph)
    return (Edge(u, v) for u in vertices(g) for v in outneighbors(g, u))
end

Graphs.has_vertex(g::DataDiGraph, v::Integer) = v in vertices(g)

function Graphs.has_edge(g::DataDiGraph, s::Integer, d::Integer)
    return (has_vertex(g, s) && has_vertex(g, d) && insorted(d, outneighbors(g, s)))
end

Graphs.inneighbors(g::DataDiGraph, v::Integer) = g.badjlist[v]
Graphs.outneighbors(g::DataDiGraph, v::Integer) = g.fadjlist[v]

Graphs.is_directed(g::DataDiGraph) = true
Graphs.is_directed(::Type{<:DataDiGraph}) = true

## Add vertices and edges

"""
    add_vertex!(g::DataDiGraph, label, data)

Add a vertex to `g` by specifying its `label` along with the associated `data`.
"""
function Graphs.add_vertex!(
    g::DataDiGraph{T,VL,VD,ED}, label::VL, data::VD
) where {T,VL,VD,ED}
    if haskey(g, label)
        return false
    else
        push!(g.fadjlist, T[])
        push!(g.badjlist, T[])
        push!(g.labels, label)
        g.vertices[label] = nv(g)
        push!(g.vertex_data, data)
        push!(g.edge_data, ED[])
        return true
    end
end

"""
    add_edge!(g::DataDiGraph, s, d, data)

Add an edge to `g` by specifying the vertices `s` and `d` along with the associated `data`.
"""
function Graphs.add_edge!(
    g::DataDiGraph{T,VL,VD,ED}, s::Integer, d::Integer, data::ED
) where {T,VL,VD,ED}
    if !has_vertex(g, s) || !has_vertex(g, d)
        return false
    else
        flist = g.fadjlist[s]
        d_index = searchsortedfirst(flist, d)
        if d_index <= length(flist) && flist[d_index] == d
            return false
        else
            blist = g.badjlist[d]
            s_index = searchsortedfirst(blist, s)
            g.ne += 1
            insert!(flist, d_index, d)
            insert!(blist, s_index, s)
            insert!(g.edge_data[s], d_index, data)
            return true
        end
    end
end

function Graphs.rem_edge!(g::DataDiGraph, s::Integer, d::Integer)
    if !has_edge(g, s, d)
        return false
    else
        d_index = searchsortedfirst(g.fadjlist[s], d)
        s_index = searchsortedfirst(g.badjlist[d], s)
        g.ne -= 1
        deleteat!(g.fadjlist[s], d_index)
        deleteat!(g.badjlist[d], s_index)
        deleteat!(g.edge_data[s], d_index)
    end
end

## Other utilities

function Graphs.reverse(g::DataDiGraph)
    rev_ne = g.ne
    rev_fadjlist = deepcopy(g.badjlist)
    rev_badjlist = deepcopy(g.fadjlist)
    rev_labels = deepcopy(g.labels)
    rev_vertices = deepcopy(g.vertices)
    rev_vertex_data = deepcopy(g.vertex_data)
    rev_edge_data = [
        [
            deepcopy(g.edge_data[s][searchsortedfirst(g.fadjlist[s], d)]) for
            s in inneighbors(g, d)
        ] for d in vertices(g)
    ]
    rev_graph_data = deepcopy(g.graph_data)
    rev_g = DataDiGraph(
        rev_ne,
        rev_fadjlist,
        rev_badjlist,
        rev_labels,
        rev_vertices,
        rev_vertex_data,
        rev_edge_data,
        rev_graph_data,
    )
    return rev_g
end
