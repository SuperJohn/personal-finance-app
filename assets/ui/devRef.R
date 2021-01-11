tabBox(title = "Developer Reference",
       width = 20,
       side = "left",
       tabPanel(title = "Shiny Dashboard",
                value = "releaseNotes",
                icon = icon("code"),
                includeMarkdown("assets/ui/help/shinyDevRef.md")
       ),
       tabPanel(title = "Data Updates",
                value = "dataNotes",
                icon = icon("server"),
                includeMarkdown("assets/ui/help/data.md"))
)