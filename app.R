### NOTE THIS VERSION IS A WORK IN PROGRESS
### Lines listed as as "TODO" are where YOU need to add code to enable full functionality
### Below is a helpful table that lists all the things to do , use it to mark your progress
# [X] # TODO: Read this table and the instructions
# [ ] # TODO: Add id to component - RangeSlider
# [ ] # TODO: Add id to component - Dropdown
# [ ] # TODO: Add id to component - Dropdown
# [ ] # TODO: use yaxisKey (from above) and refactor the code below using - Dropdown
# [ ] # TODO: Use a function make_graph() to create the graph. 
# [ ] # TODO: Update line below to call make_graph() instead of calling ggplotly(p)
# [ ] # TODO: once you create make_graph, remove this static ggplot plot below
# [ ] # TODO: Update line below to call make_graph() instead of calling ggplotly(p)
# [ ] # TODO: Add callbacks to enable interactivity

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashTable)
library(tidyverse)
library(plotly)
library(gapminder)

app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

# Selection components

# Storing the labels/values as a tibble means we can use this both 
# to create the dropdown and convert colnames -> labels when plotting
yaxisKey <- tibble(label = c("GDP Per Capita", "Life Expectancy", "Population"),
                   value = c("gdpPercap", "lifeExp", "pop"))

bar_chart_radio_items <- dccRadioItems(
  id = "bar_chart_radio_items",
  options=list(
    list(label = "first world", value = 1),
    list(label = "all statuses", value = 0)
  ),
  value = 1
)


############ END make_graph() function to use ############


return_fatality_barchart <- function(value = 1){
  
  chart_2_data <- read_csv("chart_2_data.csv")
  chart_2_data$airline <- reorder(chart_2_data$airline,
                                  -chart_2_data$total_fatalities_per_b_avail_seat_km)
  
  
  if(value != 0) {
    fatality_barchart <-ggplot(data = chart_2_data,
                               aes(x = airline, 
                                   y = total_fatalities_per_b_avail_seat_km,
                                   fill = first_world))+
      geom_bar(stat = "identity") +
      coord_flip() + 
      labs(x = "Airlines",
           y = "adjusted rate of fatalities",
           title = "Number of fatalities for airlines that had an incident between 1985 and 2014") 
  }else{
    fatality_barchart <-ggplot(data = chart_2_data,
                                 aes(x = airline, 
                                     y = total_fatalities_per_b_avail_seat_km))+
      geom_bar(stat = "identity",
               fill = "blue") +
      coord_flip() + 
      labs(x = "Airlines",
           y = "adjusted rate of fatalities",
           title = "Number of fatalities for airlines that had an incident between 1985 and 2014") 
  }
  fatality_barchart
  }


return_jitter_bar_fatality_chart <- function(value = "incident"){
  
  chart_1_data <- read_csv("chart_1_data.csv")
  jitter_var_fatality_chart <- chart_1_data %>%
    ggplot(aes(x = fatalities_period,#reorder(fatalities_period, ~fatalities_value, FUN=median),
               y = fatalities_value)) +
    geom_boxplot(width  = 0.5) +
    geom_jitter(alpha = 0.2,
                width = 0.1) +
    labs(x="Time period", 
         y = "count",
         title = "count of airline fatalities") +
    theme(plot.title = element_text(hjust = 0.5)) +
    scale_x_discrete(labels = c("Fatalies 1985-1999", "Fatalities 2000-2014"))
  
  jitter_var_fatality_chart
}


horizontal_bar_chart <- dccGraph(
  id = 'fatality_barchart',
  figure = ggplotly(return_fatality_barchart())
)

jitter_var_fatality_chart <- dccGraph(
  id = 'jitter_var_fatality_chart',
  figure = ggplotly(return_jitter_bar_fatality_chart())
  
)

app$layout(
  htmlDiv(
    list(
      htmlH1('Flight Explorer'),
      htmlH2('Looking at flight incident data interactively'),
      #selection components go here
      # htmlLabel('Select a year range:'),
      # yearSlider,
      # htmlIframe(height=15, width=10, style=list(borderWidth = 0)), #space
      # htmlLabel('Select continents:'),
      # continentDropdown,
      # htmlLabel('Select y-axis metric:'),
      bar_chart_radio_items,
      #end selection components
      horizontal_bar_chart,
      jitter_var_fatality_chart,
      htmlIframe(height=20, width=10, style=list(borderWidth = 0)), #space
      dccMarkdown("[Data Source](https://cran.r-project.org/web/packages/gapminder/README.html)")
    )
  )
)

### # TODO: Add callbacks to enable interactivity

# # Adding callbacks for interactivity
app$callback(
#   # update figure of gap-graph
  output=list(id = 'fatality_barchart', property='figure'),
#   
#   # based on values of year, continent, y-axis components
#   # TODO: Update the IDs of the components (note: remember that order matters!!)
  params=list(input(id = 'bar_chart_radio_items', property='value')),
#
#   # this translates your list of params into function arguments
  function(radio_value) {
    ggplotly(return_fatality_barchart(radio_value))
  })

app$run_server()
