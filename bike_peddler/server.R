
library(shiny)


shinyServer(function(input, output) {
  
  make_input <- reactive({
    data.frame(Category = c(rep("Acessories", 3), rep("Bikes", 4)),
               Type = c("Clothes", "Helmets", "Parts", "Hybrid", "Kids",
                        "Mountain", "Road"),
               input = c(input$acessories_clothes,
                         input$acessories_helmet,
                         input$acessories_parts,
                         input$bikes_hybrid,
                         input$bikes_kids,
                         input$bikes_mountain,
                         input$bikes_road),
               stringsAsFactors = FALSE)
  })
   
  output$box_plot <- plotly::renderPlotly({
    input_df <- make_input()
    
    pred <- get_revenue_prediction(boot_type, input_df) %>%
      dplyr::select(Category, Type, Revenue) %>%
      dplyr::mutate(Data = "Selected")
    
    plot_data <- boot_type %>%
      dplyr::select(Category, Type, Revenue) %>%
      dplyr::mutate(Data = "All")
    
    plot_data <- rbind(pred, plot_data)
    
    p <- ggplot(plot_data, aes(Data, Revenue)) + geom_boxplot()
    plotly::ggplotly(p)
    
  })
  
  output$time_plot <- plotly::renderPlotly({
    time_data <- type %>%
      dplyr::mutate(date = as.Date(paste(Year, Month, "01", sep = "-")))
    
    p <- ggplot(time_data, aes(date, Qty_Sold, color = Type)) +
      geom_line() + facet_grid(Category ~ ., scales = "free_y")
    
    plotly::ggplotly(p)
  })
  
})
