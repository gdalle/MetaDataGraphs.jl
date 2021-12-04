abstract type AbstractDataGraph{T,VL,VD,ED,GD} <: AbstractGraph{T} end

Base.copy(g::AbstractDataGraph) = deepcopy(g)

function Base.show(io::IO, g::AbstractDataGraph{T,VL,VD,ED,GD}) where {T,VL,VD,ED,GD}
    n, m = nv(g), ne(g)
    return print(
        io,
        "DataGraph of size ($n, $m) with vertex labels of type $VL, vertex data of type $VD, edge data of type $ED and graph data of type $GD.",
    )
end

Base.eltype(::AbstractDataGraph{T}) where {T} = T
