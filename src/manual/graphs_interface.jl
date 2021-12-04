## Basic Graphs.jl functions

Graphs.edgetype(g::ManualDataDiGraph{T}) where {T} = Edge{T}

Graphs.nv(g::ManualDataDiGraph) = length(g.fadjlist)
Graphs.ne(g::ManualDataDiGraph) = g.ne

Graphs.vertices(g::ManualDataDiGraph) = 1:nv(g)

function Graphs.edges(g::ManualDataDiGraph)
    # TODO: avoid allocations with iterator
    return collect(Edge(u, v) for u in vertices(g) for v in outneighbors(g, u))
end

Graphs.has_vertex(g::ManualDataDiGraph, v::Integer) = v in vertices(g)

function Graphs.has_edge(g::ManualDataDiGraph, s::Integer, d::Integer)
    return (has_vertex(g, s) && has_vertex(g, d) && insorted(d, outneighbors(g, s)))
end

Graphs.inneighbors(g::ManualDataDiGraph, v::Integer) = g.badjlist[v]
Graphs.outneighbors(g::ManualDataDiGraph, v::Integer) = g.fadjlist[v]

Graphs.is_directed(g::ManualDataDiGraph) = true
Graphs.is_directed(::Type{<:ManualDataDiGraph}) = true

function Base.zero(g::ManualDataDiGraph{T,VL,VD,ED}) where {T,VL,VD,ED}
    return ManualDataDiGraph{T}(; VL=VL, VD=VD, ED=ED, graph_data=get_data(g))
end

## Add vertices and edges

function Graphs.add_vertex!(
    g::ManualDataDiGraph{T,VL,VD,ED}, label::VL, data::VD
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

function Graphs.add_edge!(
    g::ManualDataDiGraph{T,VL,VD,ED}, s::Integer, d::Integer, data::ED
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

## Other utilities

function Graphs.reverse(g::ManualDataDiGraph)
    error("Not implemented")
end
