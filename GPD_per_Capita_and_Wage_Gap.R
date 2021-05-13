source("library.R")

load("data/gender_wage_gap_by_GDP.Rdata")


ui <- fluidPage(
  titlePanel("Gender inequality"),
  sidebarLayout(
    sidebarPanel(
      selectInput("category","Category:", c("gwgp50","gwgp90","gwgp10"),selected = "gwgp50"),
      checkboxGroupInput("income","Income level:", levels(as.factor(gender_wage_gap_by_GDP$YLV)),selected = c("High income"))
    ),
    mainPanel(plotOutput("ts"),
              plotOutput('ts1')
    )
  )
)

server <- function(input, output){
  
  output$ts <- renderPlot({ 
    
    gender_wage_gap_by_GDP %>% 
      filter(YLV %in% input$income,
             CATEGORY %in% input$category
      ) %>%
      ggplot(aes(x=TIME, y=VALUE,color=COUNTRYNAME,shape=COUNTRYNAME)) +
      scale_shape_manual(values=1:37) +
      geom_point()+geom_line()
  })
  
}


shinyApp(ui,server)
