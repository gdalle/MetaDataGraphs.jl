## Get vertex and edge data

get_data(g::AutoDataGraph) = g.graph_data
get_data(g::AutoDataGraph, v::Integer) = g.vertex_data[v]
get_data(g::AutoDataGraph, s::Integer, d::Integer) = g.edge_data[order(g, s, d)]

## Set vertex and edge data

function set_data!(g::AutoDataGraph{T,G,VL,VD}, v::Integer, data::VD) where {T,G,VL,VD}
    if has_vertex(g, v)
        g.vertex_data[v] = data
        return true
    else
        return false
    end
end

function set_data!(
    g::AutoDataGraph{T,G,VL,VD,ED}, s::Integer, d::Integer, data::ED
) where {T,G,VL,VD,ED}
    if has_edge(g, s, d)
        g.edge_data[order(g, s, d)] = data
        return true
    else
        return false
    end
end
