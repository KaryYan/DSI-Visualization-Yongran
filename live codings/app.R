
# load packages
library(shiny)
library(ggplot2)
library(dplyr)
library(gapminder)

# user interface
ui <- fluidPage(
  titlePanel('GDP and Life Expectancy with Shiny'),
  sidebarLayout(
    sidebarPanel(
      selectInput('year',
                  'Choose year',
                  choices = unique(gapminder$year))
    ),
    mainPanel(
      plotOutput('distPlot')
    )
  )
)

# server
server <- function(input,output){
  output$distPlot <- renderPlot({
    plotdata <- gapminder |>
      filter(year == input$year)
    p <- ggplot(plotdata, aes(x=gdpPercap, y=lifeExp, size=pop, color=country)) +
      geom_point(show.legend=FALSE, alpha=0.7) +
      scale_color_viridis_d() +
      scale_size(range=c(2,12)) +
      scale_x_log10() +
      labs(x='GDP per capita',
           y='Life expectancy')
    p
  })
}

# run the app
shinyApp(ui = ui, server = server)