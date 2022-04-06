```@meta
CurrentModule = DataGraphs
```

# DataGraphs.jl

Welcome to the documentation of [DataGraphs.jl](https://github.com/gdalle/DataGraphs.jl).

This packages provides a [Graphs.jl](https://github.com/JuliaGraphs/Graphs.jl)-compatible format for graphs whose vertices or edges have associated metadata.
In addition, vertices are allowed to have a "label" of arbitrary non-integer type, instead of the integer labels imposed by Graphs.jl.

Our main inspiration is [MetaGraphsNext.jl](https://github.com/JuliaGraphs/MetaGraphsNext.jl), but we made slightly different design choices.

## Getting started

To install this package, open the Julia REPL, type `]` to switch to the Pkg REPL, and run:

```julia
pkg> add https://github.com/gdalle/DataGraphs.jl
```
