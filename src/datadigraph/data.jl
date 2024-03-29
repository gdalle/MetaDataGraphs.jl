## Get data

get_data(g::DataDiGraph) = g.graph_data

get_data(g::DataDiGraph, v::Integer) = g.vertex_data[v]

function get_data(g::DataDiGraph, s::Integer, d::Integer)
    d_index = searchsortedfirst(g.fadjlist[s], d)
    return g.edge_data[s][d_index]
end

## Set data

function set_data!(g::DataDiGraph{T,VL,VD,ED,GD}, data::GD) where {T,VL,VD,ED,GD}
    g.graph_data = data
    return true
end

function set_data!(g::DataDiGraph{T,VL,VD}, v::Integer, data::VD) where {T,VL,VD}
    if has_vertex(g, v)
        g.vertex_data[v] = data
        return true
    else
        return false
    end
end

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
