source("library.R")

load("data/gender_wage_gap_by_age.Rdata")

plot_ly(gender_wage_gap_by_age) %>%
  add_trace(
    type = "scatter",
    mode = "markers+lines+text",
    x =  ~Year, 
    y =  ~ gwdba,
    color = ~Entity,
    legendgroup = ~Entity,
    hoverinfo="none"
    ) %>%
  add_markers(x =  ~Year, 
              y =  ~ gwdba,
              color = ~Entity,
              showlegend = FALSE,
              legendgroup = ~Entity,
              text = ~paste0("Year :", Year, "\n", "Age level :", Entity, "\n", "Ratio :", gwdba),
              hoverinfo= "text")%>%
  layout(title = 'Ratio of female-to-male median earnings by age, US',
         xaxis = list(title = "Year", tickvals=c(1980, 1985, 1990, 1995, 2000, 2005)),
         yaxis = list(title = " gender wage gap"),
         legend = list(traceorder = "grouped", x = 30, y = .5))

