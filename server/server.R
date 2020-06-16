server <- function(input, output, session) {
  
  output$top_channel_conversions_plot <- renderPlot({
    
    ggplot(top_channel_conversions, aes(x=reorder(channelGrouping, -total_converted), y=total_converted, fill=total_converted)) +
      geom_col(fill="#3c8dbc") +
      bbc_style() +
      labs(title = "Conversions by Channel", x = "Channel", y = "Number Converted")
    
  })
  
  output$social_conversions_plot <- renderPlot({
  ggplot(social_conversions, aes(x=reorder(socialNetwork, -total_converted), y=total_converted)) +
      geom_col(fill="#3c8dbc") +
      bbc_style() +
      labs(title = "Conversions by Social Channel")
  })


  output$user_device_conversions_plot <- renderPlot({
  ggplot(device_conversions, aes(x=reorder(deviceCategory, -total_converted), y=total_converted)) +
    geom_col(fill="#3c8dbc") +
      bbc_style() +
    labs(title = "Conversions by Device")
})
  
  output$day_conversions_plot <- renderPlot({
    ggplot(day_of_week_conversions, aes(x=reorder(dayOfWeekName, -total_converted), y=total_converted)) +
      geom_col(fill="#3c8dbc") +
        bbc_style() +
      labs(title = "Conversions by Day of Week")
  })
  
  output$depth_plot <- renderPlot({
    ggplot(top_depth_conversions, aes(x=reorder(pageDepth, -total_converted), y=total_converted)) +
      geom_col(fill="#3c8dbc") +
        bbc_style() +
      labs(title = "Conversions by Page Depth")  
  })

output$keyword_conversions_table <- DT::renderDataTable({keyword_conversions})

output$referral_conversion_table <- DT::renderDataTable({referral_conversions})

output$journey_conversion_table <- DT::renderDataTable({journey_conversions})

output$efficiency_conversion_table <- DT::renderDataTable({efficient_conversions})

output$delay_conversion_table <- DT::renderDataTable({timing_data_conversions})

output$exit_table <- DT::renderDataTable({exit_data})

output$bounce_table <- DT::renderDataTable({bounce_data})

output$avg_load_table <- DT::renderDataTable({avg_load_data})

output$sticky_table <- DT::renderDataTable({sticky_data})

output$campaigns_table <- DT::renderDataTable({campaign_conversions})

}




