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

function Graphs.add_edge!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VL, data::ED
) where {T,VL,VD,ED}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return add_edge!(g, s, d, data)
end

function Graphs.rem_edge!(g::AbstractDataGraph{T,VL}, label_s::VL, label_d::VL) where {T,VL}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return remove_edge!(g, s, d)
end
