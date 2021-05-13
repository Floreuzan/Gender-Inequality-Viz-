source("library.R")

load("data/gender_wage_gap_by_sector.Rdata")

### Dumbbell plots - Gender Inequalities - Shiny App

if (interactive()) {
  shinyApp(
    ### UI
    ui = fluidPage(
      theme = bslib::bs_theme(
        bg = "grey", 
        fg = "white", 
        base_font = "Source Sans Pro"),
      sidebarLayout(
        sidebarPanel(
          p("ADD A TITLE"),
          
          radioButtons("sector", "Choose a sector",
                       c("Employment",
                         "Education",
                         "Entrepreneurship"
                         )),
          
          selectInput("category","Choose a category", 
                      choice = levels(as.factor(df$Category)),
                      selected = levels(as.factor(df$Category))),
          
          sliderTextInput(
            inputId = "year",
            label = "Pick a year :",
            choices = range(df$TIME),
            selected = range(df$TIME)[1],
            animate = TRUE,
            grid =TRUE
          )
        ),
        mainPanel(plotOutput("Gender_Inequalities"))
      )
    ),
    
    ## SERVER 
    server = function(input, output, session) {
      observe({
        val_TIME <- subset(df, (Category==input$category) & !is.na(Value) )$TIME
        updateSliderTextInput(session = session,
                              inputId = "year",
                              choices = as.integer(levels(as.factor(val_TIME))))
      })
      observe({
        val_CAT <- subset(df, (Sector==input$sector))
        updateSelectInput(session = session,
                          "category","Choose a category", 
                          choice = levels(as.factor(val_CAT$Category)),
                          selected = levels(as.factor(val_CAT$Category)))
      })
      output$Gender_Inequalities <- renderPlot({ 
        df %>%
          pivot_wider(names_from = SEX, values_from = Value) %>%
          filter(Category == input$category,
                 TIME == input$year) %>%
          na.omit(df) %>% 
          mutate(difference = abs(MEN - WOMEN)) %>%
          arrange(difference) %>%
          
          ggplot(aes(y=reorder(COUNTRY, difference), x=MEN, xend=WOMEN)) +
          geom_dumbbell(size=1, color="grey", 
                        colour_x = "blue", colour_xend = "red",
                        dot_guide=TRUE, dot_guide_size=0.005)+
          geom_text(color="black", size=2, hjust=-0.5,
                    aes(x=MEN, label=round(MEN,2)))+
          geom_text(aes(x=WOMEN, label=round(WOMEN,2)), 
                    color="black", size=2, hjust=1.5)+
          labs(x=NULL, y=NULL, title= paste("Gender_Inequalities in", input$sector),
               subtitle=paste("Descending difference between men and women in", input$category)) +
          theme_minimal() +
          theme(panel.grid.major.x=element_line(size=0.005)) +
          theme(panel.grid.major.y=element_blank())
        
      })
    }
  )
}





