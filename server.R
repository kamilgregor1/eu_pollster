# server

shinyServer(function(input, output) {
  
  v <- reactiveValues(doPlot = FALSE)
  
  observeEvent(input$psp_votes_update, {
    # 0 will be coerced to FALSE
    # 1+ will be coerced to TRUE
    v$doPlot <- input$psp_votes_update
  })
  
  observeEvent(input$tabset, {
    v$doPlot <- FALSE
  })  
  
  output$psp_votes_chart <- renderGvis({
    
    if (v$doPlot == TRUE) return() # if TRUE, there's a chart visible when the app loads, if FALSE, it's not there
    
    isolate({
      
      psp_votes_chart_series <- c(names(psp_votes)[2:ncol(psp_votes)])
      psp_votes_chart_linewidth <- ifelse(is.na(join(psp_votes_names, data.frame(psp_votes_names = apply(expand.grid(input$psp_votes_poll_types, input$psp_votes_parties), 1, paste, collapse = "_"), included = 1), by = "psp_votes_names", type = "left")[, 2]), 0, ifelse(any(grepl(3, input$psp_votes_features)), 1, 0))
      psp_votes_chart_pointsize <- ifelse(is.na(join(psp_votes_names, data.frame(psp_votes_names = apply(expand.grid(input$psp_votes_poll_types, input$psp_votes_parties), 1, paste, collapse = "_"), included = 1), by = "psp_votes_names", type = "left")[, 2]), 0, 5)
      psp_votes_chart_tooltip <- ifelse(is.na(join(psp_votes_names, data.frame(psp_votes_names = apply(expand.grid(input$psp_votes_poll_types, input$psp_votes_parties), 1, paste, collapse = "_"), included = 1), by = "psp_votes_names", type = "left")[, 2]), "false", "true")
      psp_votes_chart_interval <- ifelse(is.na(join(psp_votes_names, data.frame(psp_votes_names = apply(expand.grid(input$psp_votes_poll_types, input$psp_votes_parties), 1, paste, collapse = "_"), included = 1), by = "psp_votes_names", type = "left")[, 2]), 0, ifelse(any(grepl(3, input$psp_votes_features)), ifelse(any(grepl(4, input$psp_votes_features)), 0.1, 0), 0))
      
      chunk <- paste0("{color: '", colors, "', lineWidth: ", psp_votes_chart_linewidth, ", interval: {'i3': {'fillOpacity': 0.5, 'style': 'points', 'pointSize': ", psp_votes_chart_pointsize, "}, 'i4': {'fillOpacity': ", psp_votes_chart_interval, ", 'style': 'area', curveType: 'function'}, 'i5': {'fillOpacity': ", psp_votes_chart_interval, ", 'style': 'area', curveType: 'function'}}, tooltip: ", psp_votes_chart_tooltip, "}, ", collapse = "")
      
      gvisLineChart(data = psp_votes,
                    xvar = 'date', 
                    yvar = psp_votes_chart_series,
                    options = list(
                      height = 600,
                      tooltip = "{isHtml:'true'}",
                      tooltipWidth = 400,
                      interpolateNulls = TRUE,
                      chartArea = "{'left': 50, 'width': '100%', 'top': 10, 'height': '90%'}",
                      legend = "{position: 'none'}",
                      series = paste0("[", substr(chunk, 1, nchar(chunk) - 2), "]"),
                      hAxis = paste0("{gridlines: {color: 'white'}, format: 'dd.MM.yyyy', viewWindow: {min: new Date('", input$psp_votes_time, "'), max: new Date('", Sys.Date(), "')}}"),
                      vAxis = "{gridlines: {color: 'white'}, format: 'percent'}"
                    )
      )
      
  })
  })
})