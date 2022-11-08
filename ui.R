## Loading Libraries

library(shiny)
library(plotly)
library(markdown)

## Data Wrangling

Treatment_Control_Plot_1 <- c("Streptomycin", "Control")
Treatment_Control_Plot_2 <- c("Streptomycin", "Control")
Treatment_Control_Plot_3 <- c("Streptomycin", "Control")

## UI

shinyUI(
  fluidPage(
    titlePanel("Comparison of Treatment and Control group participants"),  # Title
    
    h6("The dataset is the results of a randomized, placebo-controlled,    
    prospective 2-arm clinical trial of Streptomycin 2 grams daily vs. 
    Placebo to treat tuberculosis in 107 young patients, as reported by 
    the Streptomycin in Tuberculosis Trials Committee in 1948 in the 
    British Medical Journal.A dataset has 107 observations and 13 variables. 
    The details of each variable can be found in the link: 
    https://rdrr.io/github/higgi13425/medicaldata/man/strep_tb.html"),     # Dataset Description
    
    sidebarLayout(                                                
      sidebarPanel(                                                        # Sidebar
        checkboxGroupInput(inputId = "Treatment_Control",                  # Adding Checkbox
                           label = "Treatment/Control", 
                           sort(Treatment_Control_Plot_1),
                           selected = c()),
        h5("Select the group you want to analyse")                        # Adding Input Description
                  ),
      mainPanel(
        tabsetPanel(
          tabPanel("Gender",                                              # Plot 1 & Description
                    plotlyOutput("plot_1"),
                    h6("The plot shows the gender distribution of the 
                        participants in both the treatment and control group. 
                        We see that females in the treatment group are sligtly 
                        higher than that of the control group. For males the 
                        disribution is equal.")), 
          
          tabPanel("Outcome",                                             # Plot 2 & Description
                  plotlyOutput("plot_2"),
                  h6("The plot shows the end outcomes observed for both the 
                      treatment and control group participants. We see that a 
                      high number of patients showed considerable improvement 
                      with the treatment of Streptomycin. Also, we see higher 
                      deaths in the control group participants. In general people 
                      in the control group showed detoriated condition while those 
                      in the treatment group (using Streptomycin) showed improved 
                      results. We can estimate that the treatment drug is effective 
                      as more participants are getting a positive outcome than that 
                      of the control group.")),
          
          tabPanel("Progression",                                        # Plot 3 & Description
                    plotOutput("plot_3"),
                    h6("The plot shows the progression of patients in both the 
                       groups from baseline condition to the outcome condition. 
                       In general we see that patients in the treatment group show 
                       positive improvements on the use of Streptomycin.We can estimate 
                       that the treatment drug is effective as more participants 
                       are getting a positive outcome than that of the control group."))
        )
      )
    )
  )
)

