## Get vertex and edge data

get_data(g::ManualDataDiGraph) = g.graph_data
get_data(g::ManualDataDiGraph, v::Integer) = g.vertex_data[v]

function get_data(g::ManualDataDiGraph, s::Integer, d::Integer)
    d_index = searchsortedfirst(g.fadjlist[s], d)
    return g.edge_data[s][d_index]
end

## Set vertex and edge data

function set_data!(g::ManualDataDiGraph{T,VL,VD}, v::Integer, data::VD) where {T,VL,VD}
    if has_vertex(g, v)
        g.vertex_data[v] = data
        return true
    else
        return false
    end
end

function set_data!(
    g::ManualDataDiGraph{T,VL,VD,ED}, s::Integer, d::Integer, data::ED
) where {T,VL,VD,ED}
    if has_edge(g, s, d)
        d_index = searchsortedfirst(g.fadjlist[s], d)
        g.edge_data[s][d_index] = data
        return true
    else
        return false
    end
end
