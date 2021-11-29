module DataGraphs

using SparseArrays

using Reexport
@reexport using Graphs

export DataGraph
export get_vertex, get_label
export get_data, set_data!

include("datagraph.jl")
include("graphs_interface.jl")
include("weights.jl")

end
