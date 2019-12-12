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

yaxisDropdown <- dccDropdown(
  # TODO: Add id to component
  # TODO: use yaxisKey (from above) and refactor the code below using
  # purrr:map (tidyverse) instead of manually listing each option
  # Reference: https://adv-r.hadley.nz/functionals.html
  options=list(
    list(label = "GDP Per Capita", value = "gdpPercap"),
    list(label = "Life Expectancy", value = "lifeExp"),
    list(label = "Population", value = "pop")
  ),
  value = "gdpPercap"
)

# TODO: Use a function make_graph() to create the graph.  
# Note: The make_graph() function is created for you already.
# Once you understand how it works, uncomment it out to use it
# and then delete the static plot starting after this chunk.
#
############ START make_graph() function to use ############
# Uses default parameters such as all_continents for initial graph
# all_continents <- unique(gapminder$continent)
# make_graph <- function(years=c(1952, 2007), 
#                        continents=all_continents,
#                        yaxis="gdpPercap"){

#   # gets the label matching the column value
#   y_label <- yaxisKey$label[yaxisKey$value==yaxis]

#   #filter our data based on the year/continent selections
#   data <- gapminder %>%
#     filter(year >= years[1] & year <= years[2]) %>%
#     filter(continent %in% continents)

#   # make the plot!
#   # on converting yaxis string to col reference (quosure) by `!!sym()`
#   # see: https://github.com/r-lib/rlang/issues/116
#   p <- ggplot(data, aes(x=year, y=!!sym(yaxis), colour=continent)) +
#     geom_point(alpha=0.6) +
#     scale_color_manual(name="Continent", values=continent_colors) +
#     scale_x_continuous(breaks = unique(data$year))+
#     xlab("Year") +
#     ylab(y_label) +
#     ggtitle(paste0("Change in ", y_label, " Over Time")) +
#     theme_bw()

#   ggplotly(p)
# }
############ END make_graph() function to use ############

# Graph (no change from app2)
# TODO: once you create make_graph, remove this static ggplot plot below
### START CODE TO REMOVE
# p <- ggplot(gapminder, aes(x=year, y=gdpPercap, colour=continent)) +
#   geom_point(alpha=0.6) +
#   scale_color_manual(name="Continent", values=continent_colors) +
#   xlab("Year") +
#   ylab("GDP Per Capita") +
#   theme_bw()
### END CODE TO REMOVE


return_fatality_barchart <- function(value = 0){
  
  chart_2_data <- read_csv("chart_2_data.csv")
  
  fatality_barchart <- chart_2_data %>%
    ggplot(aes(x = airline, 
               y = total_fatalities_per_b_avail_seat_km)) +
    geom_bar(stat = "identity",
             fill = "blue") +
    coord_flip() + 
    labs(x = "Airlines",
         y = "adjusted rate of fatalities",
         title = "Number of fatalities for airlines that had an incident between 1985 and 2014")
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
      yaxisDropdown,
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
# app$callback(
#   # update figure of gap-graph
#   output=list(id = 'gap-graph', property='figure'),
#   
#   # based on values of year, continent, y-axis components
#   # TODO: Update the IDs of the components (note: remember that order matters!!)
#   params=list(input(id = 'CORRECT_ID_HERE', property='value'),
#               input(id = 'CORRECT_ID_HERE', property='value'),
#               input(id = 'CORRECT_ID_HERE', property='value')),
#
#   # this translates your list of params into function arguments
#   function(year_value, continent_value, yaxis_value) {
#     make_graph(year_value, continent_value, yaxis_value)
#   })

app$run_server()
