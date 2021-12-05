module DataGraphs

using SparseArrays

using Reexport
@reexport using Graphs

export AbstractDataGraph, DictDataGraph, ArrayDataDiGraph
export get_vertex, get_label
export get_data, set_data!

include("abstractdatagraph.jl")

include("dict/dictdatagraph.jl")
include("dict/graphs_interface.jl")
include("dict/data.jl")

include("array/arraydatadigraph.jl")
include("array/graphs_interface.jl")
include("array/data.jl")

include("labels.jl")
include("weights.jl")

end
