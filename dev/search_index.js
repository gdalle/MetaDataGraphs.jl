var documenterSearchIndex = {"docs":
[{"location":"api/#API-reference","page":"API reference","title":"API reference","text":"","category":"section"},{"location":"api/#Index","page":"API reference","title":"Index","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"","category":"page"},{"location":"api/#Docstrings","page":"API reference","title":"Docstrings","text":"","category":"section"},{"location":"api/","page":"API reference","title":"API reference","text":"Modules = [DataGraphs]","category":"page"},{"location":"api/#DataGraphs.AbstractDataGraph","page":"API reference","title":"DataGraphs.AbstractDataGraph","text":"AbstractDataGraph{T,VL,VD,ED,GD} <: AbstractGraph{T}\n\nGeneral template for graphs with metadata. Here,\n\nT<:Integer is the type of vertices\nVL is the type of vertex labels (cannot be a subtype of Integer)\nVD is the type of vertex data objects\nED is the type of edge data objects\nGD is the type of the graph data object\n\n\n\n\n\n","category":"type"},{"location":"api/#DataGraphs.ArrayDataDiGraph","page":"API reference","title":"DataGraphs.ArrayDataDiGraph","text":"ArrayDataDiGraph{T,VL,VD,ED,GD} <: AbstractDataGraph{T}\n\nStructure for graphs with metadata based on adjacency list storage.\n\nFields\n\nne::Int: number of edges\nfadjlist::Vector{Vector{Int}}: forward adjacency lists\nbadjlist::Vector{Vector{Int}}: backward adjacency lists\nlabels::Vector{VL}: list of vertex labels\nvertices::Dict{VL,T}: dictionary mapping each vertex label to the associated integer index v\nvertex_data::Vector{VD}: list of vertex data objects, indexed by integers v\nedge_data::Vector{Vector{ED}}: list of edge data objects, indexed by s first and d_index second, where d_index is the rank of d among the outneighbors of s\ngraph_data::GD: single graph data object\n\n\n\n\n\n","category":"type"},{"location":"api/#DataGraphs.DictDataGraph","page":"API reference","title":"DataGraphs.DictDataGraph","text":"DictDataGraph{T,G<:AbstractGraph{T},VL,VD,ED,GD} <: AbstractDataGraph{T}\n\nStructure for graphs with metadata based on an underlying dataless graph.\n\nFields\n\ngraph::G: underlying graph, following the Graphs.jl AbstractGraph{T} interface\nlabels::Vector{VL}: list of vertex labels\nvertices::Dict{VL,T}: dictionary mapping each vertex label to the associated integer index v\nvertex_data::Vector{VD}: list of vertex data objects, indexed by integers v\nedge_data::Dict{Tuple{T,T},ED}: list of edge data objects, indexed by integer tuples (s,d)\ngraph_data::GD: single graph data object\n\n\n\n\n\n","category":"type"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = DataGraphs","category":"page"},{"location":"#DataGraphs.jl","page":"Home","title":"DataGraphs.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Welcome to the documentation for DataGraphs.jl.","category":"page"},{"location":"","page":"Home","title":"Home","text":"DataGraphs.jl deals with graphs whose vertices or edges have associated metadata. In addition, vertices are allowed to have a \"label\" of arbitrary type, instead of the integer labels imposed by Graphs.jl.","category":"page"},{"location":"","page":"Home","title":"Home","text":"Our main inspiration is MetaGraphsNext.jl, but we made slightly different design choices.","category":"page"},{"location":"#Getting-started","page":"Home","title":"Getting started","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To install this package, open the Julia REPL, type ] to switch to the Pkg REPL, and run:","category":"page"},{"location":"","page":"Home","title":"Home","text":"pkg> add https://github.com/gdalle/DataGraphs.jl","category":"page"}]
}
