## Get vertex and edge data

get_data(g::DictDataGraph) = g.graph_data
get_data(g::DictDataGraph, v::Integer) = g.vertex_data[v]
get_data(g::DictDataGraph, s::Integer, d::Integer) = g.edge_data[order(g, s, d)]

## Set vertex and edge data

function set_data!(g::DictDataGraph{T,G,VL,VD}, v::Integer, data::VD) where {T,G,VL,VD}
    if has_vertex(g, v)
        g.vertex_data[v] = data
        return true
    else
        return false
    end
end

function set_data!(
    g::DictDataGraph{T,G,VL,VD,ED}, s::Integer, d::Integer, data::ED
) where {T,G,VL,VD,ED}
    if has_edge(g, s, d)
        g.edge_data[order(g, s, d)] = data
        return true
    else
        return false
    end
end
