## Basic Graphs.jl functions

Graphs.edgetype(g::ArrayDataDiGraph{T}) where {T} = Edge{T}

Graphs.nv(g::ArrayDataDiGraph) = length(g.fadjlist)
Graphs.ne(g::ArrayDataDiGraph) = g.ne

Graphs.vertices(g::ArrayDataDiGraph) = 1:nv(g)

function Graphs.edges(g::ArrayDataDiGraph)
    # TODO: avoid allocations with iterator
    return collect(Edge(u, v) for u in vertices(g) for v in outneighbors(g, u))
end

Graphs.has_vertex(g::ArrayDataDiGraph, v::Integer) = v in vertices(g)

function Graphs.has_edge(g::ArrayDataDiGraph, s::Integer, d::Integer)
    return (has_vertex(g, s) && has_vertex(g, d) && insorted(d, outneighbors(g, s)))
end

Graphs.inneighbors(g::ArrayDataDiGraph, v::Integer) = g.badjlist[v]
Graphs.outneighbors(g::ArrayDataDiGraph, v::Integer) = g.fadjlist[v]

Graphs.is_directed(g::ArrayDataDiGraph) = true
Graphs.is_directed(::Type{<:ArrayDataDiGraph}) = true

function Base.zero(g::ArrayDataDiGraph{T,VL,VD,ED}) where {T,VL,VD,ED}
    return ArrayDataDiGraph{T}(; VL=VL, VD=VD, ED=ED, graph_data=get_data(g))
end

## Add vertices and edges

function Graphs.add_vertex!(
    g::ArrayDataDiGraph{T,VL,VD,ED}, label::VL, data::VD
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
    g::ArrayDataDiGraph{T,VL,VD,ED}, s::Integer, d::Integer, data::ED
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

function Graphs.reverse(g::ArrayDataDiGraph)
    error("Not implemented")
end
