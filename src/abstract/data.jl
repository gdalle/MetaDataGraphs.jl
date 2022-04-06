## Data handling

"""
    get_data(g, label)

Retrieve vertex-level metadata for the vertex with label `label`.
"""
function get_data(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL}
    v = get_vertex(g, label)
    return get_data(g, v)
end

"""
    get_data(g, label_s, label_d)

Retrieve edge-level metadata for the edge between the vertices with labels `label_s` and `label_d`.
"""
function get_data(g::AbstractDataGraph{T,VL}, label_s::VL, label_d::VL) where {T,VL}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return get_data(g, s, d)
end

"""
    set_data!(g, label, data)

Set vertex-level metadata to value `data` for the vertex with label `label`.
"""
function set_data!(g::AbstractDataGraph{T,VL,VD}, label::VL, data::VD) where {T,VL,VD}
    v = get_vertex(g, label)
    return set_data!(g, v, data)
end

"""
    sett_data!(g, label_s, label_d, data)

Set edge-level metadata to value `data` for the edge between the vertices with labels `label_s` and `label_d`.
"""
function set_data!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VD, data::ED
) where {T,VL,VD,ED}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return set_data!(g, s, d, data)
end
