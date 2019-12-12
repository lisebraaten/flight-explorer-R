library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashTable)
library(tidyverse)
library(plotly)
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

box_jitter_plot_radio_items <- dccRadioItems(
  id = "box_jitter_plot_radio_items",
  options=list(
    list(label = "lethality", value = "lethality"), 
    list(label = "fatalities", value = "fatalities"),
    list(label = "incident", value = "incident"),
    list(label = "fatal accident", value = "fatal_accident")
  ),
  value = "incident"
)

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
  
  if(value == "incident"){
    
    jitter_var_fatality_chart <- chart_1_data %>%
      ggplot(aes(x = incident_period,#reorder(fatalities_period, ~fatalities_value, FUN=median),
                 y = incident_value)) +
      geom_boxplot(width  = 0.5) +
      geom_jitter(alpha = 0.2,
                  width = 0.1) +
      labs(x="Time period", 
           y = "count",
           title = "count of airline incidents") +
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_x_discrete(labels = c("incidents 1985-1999", "incidents 2000-2014"))
  }
  else if (value == "lethality"){
    
    jitter_var_fatality_chart <- chart_1_data %>%
      ggplot(aes(x = lethality_period,#reorder(fatalities_period, ~fatalities_value, FUN=median),
                 y = lethality_value)) +
      geom_boxplot(width  = 0.5) +
      geom_jitter(alpha = 0.2,
                  width = 0.1) +
      labs(x="Time period", 
           y = "count",
           title = "ratio of airline lethality") +
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_x_discrete(labels = c("lethality 1985-1999", "lethality 2000-2014"))
  }
  else{
    jitter_var_fatality_chart <- chart_1_data %>%
      ggplot(aes(x = fatal_accident_period,#reorder(fatalities_period, ~fatalities_value, FUN=median),
                 y = fatal_accident_value)) +
      geom_boxplot(width  = 0.5) +
      geom_jitter(alpha = 0.2,
                  width = 0.1) +
      labs(x="Time period", 
           y = "count",
           title = "count of airline fatal incidents") +
      theme(plot.title = element_text(hjust = 0.5)) +
      scale_x_discrete(labels = c("Fatal Incidents 1985-1999", "Fatal Incidents 2000-2014"))
    }
  
  jitter_var_fatality_chart
}

horizontal_bar_chart <- dccGraph(
  id = 'fatality_barchart',
  figure = ggplotly(return_fatality_barchart()))

jitter_var_fatality_chart <- dccGraph(
  id = 'jitter_var_fatality_chart',
  figure = ggplotly(return_jitter_bar_fatality_chart()))


app$layout(htmlDiv(list(
  htmlH1('Flight Explorer'),
  htmlH2('Looking at flight incident data interactively'),
  dccTabs(id="tabs-example", value='tab-1-example', children=list(
    dccTab(label='Fatality rates per billion by airlines', value='tab-1-example'),
    dccTab(label='Counts of different categories of incidents', value='tab-2-example')
  )),
  htmlDiv(id='tabs-content-example')
)))

app$callback(
  output = list(id='tabs-content-example', property = 'children'),
  params = list(input(id = 'tabs-example', property = 'value')),


  function(tab){
    if(tab == 'tab-1-example'){
      return(  htmlDiv(
    list(
      dccMarkdown("This bar chart shows the adjusted fatality rate, calculated as number of fatal incidents, normalized by the total distance each airline flys, as wells as the nubmer of seats per flight."), 
      dccMarkdown("Hover over each bar to see each airline's adjusted fatality rate."),
      dccMarkdown("The airlines are grouped by the economic status of their orginating country, where countries of a sufficient economic status is designated [**first world**](https://www.nationsonline.org/oneworld/first_world.htm)."),
      bar_chart_radio_items,
      horizontal_bar_chart,
      htmlIframe(height=20, width=10, style=list(borderWidth = 0)), #space
      dccMarkdown("data taken from [github](https://github.com/fivethirtyeight/data/tree/master/airline-safety), originally used for [this fiveThirtyEight article](https://fivethirtyeight.com/features/should-travelers-avoid-flying-airlines-that-have-had-crashes-in-the-past/).")
    )
  )
  )
 }

    else if(tab == 'tab-2-example'){
      return(
          htmlDiv(
    list(
      box_jitter_plot_radio_items,
      jitter_var_fatality_chart,
      htmlIframe(height=20, width=10, style=list(borderWidth = 0))
    )
  )
      )
    }
  }
)

app$callback(
  output=list(id = 'fatality_barchart', property='figure'),
  params=list(input(id = 'bar_chart_radio_items', property='value')),

  function(radio_value) {
    ggplotly(return_fatality_barchart(radio_value))
  })

app$callback(
  output=list(id = 'jitter_var_fatality_chart', property='figure'),
  params=list(input(id = 'box_jitter_plot_radio_items', property='value')),
  function(radio_value) {
    ggplotly(return_jitter_bar_fatality_chart(radio_value))
  })



app$run_server(host = "0.0.0.0", port = Sys.getenv('PORT', 8050))
