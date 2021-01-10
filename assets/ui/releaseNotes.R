tabBox(title = "Release Notes",
       width = 12,
       side = "left",
       tabPanel(title = "Features & Bug Fixes",
                value = "releaseNotes",
                icon = icon("code"),
                includeMarkdown("assets/ui/help/software.md")
       ),
       tabPanel(title = "Data Updates",
                value = "dataNotes",
                icon = icon("server"),
                includeMarkdown("assets/ui/help/data.md"))
)