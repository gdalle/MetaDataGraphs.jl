## Get vertex and edge data

"""
    get_data(g)

Retrieve graph-level metadata.
"""
get_data(g::DataDiGraph) = g.graph_data

"""
    get_data(g, v)

Retrieve vertex-level metadata for vertex `v`.
"""
get_data(g::DataDiGraph, v::Integer) = g.vertex_data[v]

"""
    get_data(g, s, d)

Retrieve edge-level metadata for edge `(s, d)`.
"""
function get_data(g::DataDiGraph, s::Integer, d::Integer)
    d_index = searchsortedfirst(g.fadjlist[s], d)
    return g.edge_data[s][d_index]
end

## Set vertex and edge data

"""
    set_data!(g, v, data)

Set vertex-level metadata to value `data` for vertex `v`.
"""
function set_data!(g::DataDiGraph{T,VL,VD}, v::Integer, data::VD) where {T,VL,VD}
    if has_vertex(g, v)
        g.vertex_data[v] = data
        return true
    else
        return false
    end
end

"""
    set_data!(g, s, d, data)

Set edge-level metadata to value `data` for edge `(s, d)`.
"""
function set_data!(
    g::DataDiGraph{T,VL,VD,ED}, s::Integer, d::Integer, data::ED
) where {T,VL,VD,ED}
    if has_edge(g, s, d)
        d_index = searchsortedfirst(g.fadjlist[s], d)
        g.edge_data[s][d_index] = data
        return true
    else
        return false
    end
end
