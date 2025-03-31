push!(LOAD_PATH, "../src")

using Documenter
using ZenGui

makedocs(
    sitename = "ZenGui",
    clean = false,
    authors = "Li Huang <huangli@caep.cn> and contributors",
    format = Documenter.HTML(
        prettyurls = false,
        ansicolor = true,
        repolink = "https://github.com/huangli712/ZenGui",
        size_threshold = 409600, # 400kb
        assets = ["assets/zengui.css"],
        collapselevel = 1,
    ),
    remotes = nothing,
    modules = [ZenGui],
    pages = [
        "Home" => "index.md",
    ],
)
