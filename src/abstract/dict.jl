"""
    getindex(g, label)

Alias for [`get_vertex(g, label)`](@ref), intended for dictionary-like use.
"""
Base.getindex(g::AbstractDataGraph{T,VL}, label::VL) where {T,VL} = get_vertex(g, label)
