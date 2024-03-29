## Get graph data

"""
    get_data(g)

Retrieve graph-level metadata.
"""
function get_data(g::AbstractDataGraph)
    return error("Not implemented for $(typeof(g))")
end

"""
    set_data!(g, data)

Set graph-level metadata to value `data`.
"""
function set_data!(g::AbstractDataGraph{T,VL,VD,ED,GD}, data::GD) where {T,VL,VD,ED,GD}
    return error("Not implemented for $(typeof(g))")
end

## Get vertex data

"""
    get_data(g, v)

Retrieve vertex-level metadata for the vertex `v`.
"""
function get_data(g::AbstractDataGraph, v::Integer)
    return error("Not implemented for $(typeof(g))")
end

"""
    get_data(g, label)

Retrieve vertex-level metadata for the vertex with label `label`.
"""
function get_data(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL}
    v = get_vertex(g, label)
    return get_data(g, v)
end

## Get edge data

"""
    get_data(g, s, d)

Retrieve edge-level metadata for the edge between the vertices `s` and `d`.
"""
function get_data(g::AbstractDataGraph, s::Integer, d::Integer)
    return error("Not implemented for $(typeof(g))")
end

"""
    get_data(g, label_s, label_d)

Retrieve edge-level metadata for the edge between the vertices with labels `label_s` and `label_d`.
"""
function get_data(g::AbstractDataGraph{T,VL}, label_s::VL, label_d::VL) where {T,VL}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return get_data(g, s, d)
end

## Set vertex data

"""
    set_data!(g, v, data)

Set vertex-level metadata to value `data` for the vertex `v`.
"""
function set_data!(g::AbstractDataGraph{T,VL,VD}, v::Integer, data::VD) where {T,VL,VD}
    return error("Not implemented for $(typeof(g))")
end

"""
    set_data!(g, label, data)

Set vertex-level metadata to value `data` for the vertex with label `label`.
"""
function set_data!(g::AbstractDataGraph{T,VL,VD}, label::VL, data::VD) where {T,VL,VD}
    v = get_vertex(g, label)
    return set_data!(g, v, data)
end

## Set edge data

"""
    set_data!(g, s, d, data)

Set edge-level metadata to value `data` for edge `(s, d)`.
"""
function set_data!(
    g::AbstractDataGraph{T,VL,VD,ED}, s::Integer, d::Integer, data::ED
) where {T,VL,VD,ED}
    return error("Not implemented for $(typeof(g))")
end

"""
    set_data!(g, label_s, label_d, data)

Set edge-level metadata to value `data` for the edge between the vertices with labels `label_s` and `label_d`.
"""
function set_data!(
    g::AbstractDataGraph{T,VL,VD,ED}, label_s::VL, label_d::VD, data::ED
) where {T,VL,VD,ED}
    s, d = get_vertex(g, label_s), get_vertex(g, label_d)
    return set_data!(g, s, d, data)
end
