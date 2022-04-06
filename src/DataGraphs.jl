module DataGraphs

using Graphs
using SparseArrays

export AbstractDataGraph, DataDiGraph
export get_vertex, get_label
export get_data, set_data!

include("abstract/abstractdatagraph.jl")
include("abstract/data.jl")
include("abstract/graphs_interface.jl")
include("abstract/weights.jl")
include("abstract/dict.jl")

include("datadigraph/datadigraph.jl")
include("datadigraph/data.jl")
include("datadigraph/graphs_interface.jl")


end
