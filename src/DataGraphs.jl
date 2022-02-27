module DataGraphs

using SparseArrays

using Reexport
@reexport using Graphs

export AbstractDataGraph, DataDiGraph
export get_vertex, get_label
export get_data, set_data!

include("abstractdatagraph.jl")

include("datadigraph/datadigraph.jl")
include("datadigraph/data.jl")
include("datadigraph/graphs_interface.jl")

include("labels.jl")
include("weights.jl")

end
