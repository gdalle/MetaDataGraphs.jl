using MetaDataGraphs
using Documenter

DocMeta.setdocmeta!(MetaDataGraphs, :DocTestSetup, :(using MetaDataGraphs); recursive=true)

makedocs(;
    modules=[MetaDataGraphs],
    authors="Guillaume Dalle <22795598+gdalle@users.noreply.github.com> and contributors",
    repo="https://github.com/gdalle/MetaDataGraphs.jl/blob/{commit}{path}#{line}",
    sitename="MetaDataGraphs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://gdalle.github.io/MetaDataGraphs.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API reference" => [
            "AbstractDataGraph" => "api_abstract.md",
            "DataDiGraph" => "api_datadigraph.md",
        ],
    ],
)

deploydocs(;
    repo="github.com/gdalle/MetaDataGraphs.jl",
    devbranch="main",
)
