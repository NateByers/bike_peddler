

library(shiny)


shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel(
       sliderInput("acessories_clothes",
                   "Acessories-Clothes Sold:",
                   min = get_min("Acessories", "Clothes"),
                   max = get_max("Acessories", "Clothes"),
                   value = get_median("Acessories", "Clothes"),
                   step = 1),
       sliderInput("acessories_helmet",
                   "Acessories-Helmet Sold:",
                   min = get_min("Acessories", "Helmets"),
                   max = get_max("Acessories", "Helmets"),
                   value = get_median("Acessories", "Helmets"),
                   step = 1),
       sliderInput("acessories_parts",
                   "Acessories-Parts Sold:",
                   min = get_min("Acessories", "Parts"),
                   max = get_max("Acessories", "Parts"),
                   value = get_median("Acessories", "Parts"),
                   step = 1),
       sliderInput("bikes_hybrid",
                   "Bikes-Hybrid Sold:",
                   min = get_min("Bikes", "Hybrid"),
                   max = get_max("Bikes", "Hybrid"),
                   value = get_median("Bikes", "Hybrid"),
                   step = 1),
       sliderInput("bikes_kids",
                   "Bikes-Kids Sold:",
                   min = get_min("Bikes", "Kids"),
                   max = get_max("Bikes", "Kids"),
                   value = get_median("Bikes", "Kids"),
                   step = 1),
       sliderInput("bikes_mountain",
                   "Bikes-Mountain Sold:",
                   min = get_min("Bikes", "Mountain"),
                   max = get_max("Bikes", "Mountain"),
                   value = get_median("Bikes", "Mountain"),
                   step = 1),
       sliderInput("bikes_road",
                   "Bikes-Road Sold:",
                   min = get_min("Bikes", "Road"),
                   max = get_max("Bikes", "Road"),
                   value = get_median("Bikes", "Road"),
                   step = 1)
    ),
    
    mainPanel(
       plotly::plotlyOutput("box_plot"),
       plotly::plotlyOutput("time_plot")
    )
  )
))
