source("library.R")

load("data/GII.Rdata")

plot_ly(GII) %>%
  add_trace(
    type = "scatter",
    mode = "markers+lines+text",
    x =  ~Year, 
    y =  ~ gii,
    color = ~Entity,
    colors = colorRampPalette(brewer.pal(8, "Dark2"))(10),
    legendgroup = ~Entity,
    hoverinfo="none"
  ) %>%
  add_markers(x =  ~Year, 
              y =  ~ gii,
              color = ~Entity,
              showlegend = FALSE,
              legendgroup = ~Entity,
              text = ~paste0("Year :", Year, "\n", "Country :", Entity, "\n", "Value :", gii),
              hoverinfo= "text")%>%
  layout(title = 'Gender Inequality Index from the Human Development Report',
         yaxis = list(title = " gender inequality index"))

         