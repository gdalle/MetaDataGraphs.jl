## Data handling

function get_data(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL}
    v = get_vertex(g, label)
    return get_data(g, v)
end

function get_data(g::AbstractDataGraph{T,VL}, label_s::VL, label_d::VL) where {T,VL}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return get_data(g, s, d)
end

function set_data!(g::AbstractDataGraph{T,VL,VD}, label::VL, data::VD) where {T,VL,VD}
    v = get_vertex(g, label)
    return set_data!(g, v, data)
end

function set_data!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VD, data::ED
) where {T,VL,VD,ED}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return set_data!(g, s, d, data)
end

## Vertex and edge modification

function Graphs.add_vertex!(
    g::AbstractDataGraph{T,VL,VD,ED}, label::VL
) where {T,VL,VD<:Nothing,ED}
    return add_vertex!(g, label, nothing)
end

function Graphs.add_edge!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VL, data::ED
) where {T,VL,VD,ED}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return add_edge!(g, s, d, data)
end

function Graphs.add_edge!(
    g::AbstractDataGraph{T,VL,VD,ED}, s::Integer, d::Integer
) where {T,VL,VD,ED<:Nothing}
    return add_edge!(g, s, d, nothing)
end

function Graphs.add_edge!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VL
) where {T,VL,VD,ED<:Nothing}
    return add_edge!(g, label_s, label_d, nothing)
end
