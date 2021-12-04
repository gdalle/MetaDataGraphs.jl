module DataGraphs

using SparseArrays

using Reexport
@reexport using Graphs

export AbstractDataGraph, AutoDataGraph, ManualDataDiGraph
export get_vertex, get_label
export get_data, set_data!

include("abstractdatagraph.jl")

include("auto/autodatagraph.jl")
include("auto/graphs_interface.jl")
include("auto/data.jl")

include("manual/manualdatagraph.jl")
include("manual/graphs_interface.jl")
include("manual/data.jl")

include("labels.jl")
include("weights.jl")

end
