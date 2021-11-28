using DataGraphs
using Documenter

DocMeta.setdocmeta!(DataGraphs, :DocTestSetup, :(using DataGraphs); recursive=true)

makedocs(;
    modules=[DataGraphs],
    authors="Guillaume Dalle <22795598+gdalle@users.noreply.github.com> and contributors",
    repo="https://github.com/gdalle/DataGraphs.jl/blob/{commit}{path}#{line}",
    sitename="DataGraphs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://gdalle.github.io/DataGraphs.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API reference" => "api.md"
    ],
)

deploydocs(;
    repo="github.com/gdalle/DataGraphs.jl",
    devbranch="main",
)
