ui <- fluidPage(theme = shinytheme("cerulean"),
  dashboardPage(
    dashboardHeader(title="CodeClan Goal Converters", titleWidth = 400),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Arrival", tabName = "Arrival", icon = icon("dashboard")),
        menuItem("Journey", tabName = "Journey", icon = icon("bar-chart-o")),
        menuItem("Conversions", tabName = "Conversions", icon = icon("bar-chart-o")),
        menuItem("Exits", tabName = "Exits", icon = icon("bar-chart-o"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem("Arrival",
                tabsetPanel(
                  tabPanel("Channel Source", plotOutput("top_channel_conversions_plot")),
                  tabPanel("Social Media", plotOutput("social_conversions_plot")),
                  tabPanel("Keywords", DT::dataTableOutput("keyword_conversions_table")),
                  tabPanel("Device", plotOutput("user_device_conversions_plot")),
                  tabPanel("Campaign", DT::dataTableOutput("campaigns_table"))
                  )
        ),
        tabItem("Journey",
                tabsetPanel(
                  tabPanel("Conversion Journey", DT::dataTableOutput("journey_conversion_table")),
                  tabPanel("Conversion Depth", plotOutput("depth_plot")),
                  tabPanel("Referral Sources", DT::dataTableOutput("referral_conversion_table")),
                  tabPanel("Stickiest Pages", DT::dataTableOutput("sticky_table"))
                  )
        ),
        tabItem("Conversions",
                tabsetPanel(
                  tabPanel("Conversion by Day of Week", plotOutput("day_conversions_plot")),
                  tabPanel("Conversion Delay", DT::dataTableOutput("delay_conversion_table")),
                  tabPanel("Most Efficient Landing Page", DT::dataTableOutput("efficiency_conversion_table"))
                  )
                ),
        tabItem("Exits",
                tabsetPanel(
                  tabPanel("Page Load Time", DT::dataTableOutput("avg_load_table")),
                  tabPanel("Bounce Rate", DT::dataTableOutput("bounce_table")),
                  tabPanel("Exit Pages", DT::dataTableOutput("exit_table"))
                  )
                )
      )
    )
  )
)
