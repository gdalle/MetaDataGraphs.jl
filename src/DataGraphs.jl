module DataGraphs

using Reexport
@reexport using Graphs

export DataGraph
export get_data, set_data!

include("datagraph.jl")
include("graphs_interface.jl")

end
