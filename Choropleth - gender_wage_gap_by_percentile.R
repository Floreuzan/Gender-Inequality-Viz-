source("library.R")

load("data/gender_wage_gap_by_percentile.Rdata")

l <- list(color = toRGB("white"), width = 0.5)

plot_ly(gender_wage_gap_by_percentile, type='choropleth', z=~gwgp50, locations=~COUNTRY, frame=~TIME, 
                colorscale="Viridis", reversescale=F,hoverinfo="text", marker=list(line=l),
                text = ~paste("Country :", gender_wage_gap_by_percentile$COUNTRYNAME,
                              "<br> Gap at P50 :", gender_wage_gap_by_percentile$gwgp50),showscale=T,zmin=-0.1,zmax=0.5) %>%
  add_trace(z=~gwgp90,visible=F,showscale=F,text = ~paste("Country :", gender_wage_gap_by_percentile$COUNTRYNAME,
                                                          "<br> Gap at P90 :", gender_wage_gap_by_percentile$gwgp90)) %>%
  add_trace(z=~gwgp10,  visible=F,showscale=F,text = ~paste("Country :", gender_wage_gap_by_percentile$COUNTRYNAME,
                                                            "<br> Gap at P10 :", gender_wage_gap_by_percentile$gwgp10)) %>%
  animation_opts(frame=1000) %>% 
  layout(
  title = "Gender gaps at different percentiles",
  legend= list(title=list(text="Tred"),
               itemsizing='constant'),
  updatemenus = list(
    list(
      y = 1, x=-0.01,
      buttons = list(
        list(method = "restyle",
             args = list("visible", list(T,F,F)),
             label = "Median"),
        list(method = "restyle",
             args = list("visible", list(F,T,F)),
             label = "90th percentile"),
        list(method = "restyle",
             args = list("visible", list(F,F,T)),
             label = "10th percentile")
      )
    )
  )
) 
  
