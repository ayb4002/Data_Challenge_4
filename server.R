## Loading Libraries

library(shiny)
library(plotly)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(medicaldata)
library(ggalluvial)

## Data Wrangling

data_1 <- strep_tb %>% 
  select(patient_id,arm,gender) %>%
  group_by(arm,gender) %>%
  summarise(n = n()) 

colnames(data_1) <- c("Treatment_Control", "Gender", "Participants_Count")

data_2 <- strep_tb %>% 
  select(patient_id,arm,radiologic_6m) %>%
  group_by(arm,radiologic_6m) %>%
  summarise(n = n()) 

colnames(data_2) <- c("Treatment_Control", "Outcome", "Participants_Count")

data_3 <- strep_tb %>% 
  select(patient_id,arm,baseline_condition,radiologic_6m) %>%
  group_by(arm,baseline_condition,radiologic_6m) %>%
  summarise(n = n()) 

colnames(data_3) <- c("Treatment_Control", "Baseline_Condition", "Outcome", "Participants_Count")

## Plots

shinyServer(function(input, output) {
  
  #Plot 1
  
  output$plot_1 <- renderPlotly({
    ds_1 <- data_1 %>% filter(Treatment_Control %in% input$Treatment_Control)
    ggplot_plot_1 <- ggplot(data = ds_1,
                            aes(x = Gender,
                                y = Participants_Count,
                                fill = Treatment_Control)) + 
      geom_bar(stat='identity',position = 'dodge') +
      labs(x = "Gender",
           y = "Count of Participants",
           title ="Participant Counts by Gender") +
      theme(plot.title = element_text(hjust = 0.5)) +
      guides(fill=guide_legend(title="Treatment/Control Group"))
    ggplotly(ggplot_plot_1)
  })
  
  output$plot_2 <- renderPlotly({
    
    # Plot 2
    
    ds_2 <- data_2 %>% filter(Treatment_Control %in% input$Treatment_Control)
    ggplot_plot_2 <- ggplot(data = ds_2,
                            aes(x = Outcome,
                                y = Participants_Count,
                                fill = Treatment_Control)) + 
      geom_bar(stat='identity',position = 'dodge') +
      labs(x = "Outcome",
           y = "Count of Participants",
           title ="Participant Counts by Outcome") +
      theme(plot.title = element_text(hjust = 0.5),axis.text.x = element_text(angle = 90)) +
      guides(fill=guide_legend(title="Treatment/Control Group"))
    ggplotly(ggplot_plot_2)
  })
  
  output$plot_3 <- renderPlot({
    
    # Plot 3
    
    ds_3 <- data_3 %>% filter(Treatment_Control %in% input$Treatment_Control)
    ggplot_plot_3 <- ggplot(data = ds_3,
                            aes(axis1 = Baseline_Condition,
                                axis2 = Outcome,
                                y = Participants_Count)) +
      geom_alluvium(aes(fill = Treatment_Control),curve_type = "cubic") +
      geom_stratum() +
      geom_text(stat = "stratum", aes(label = after_stat(stratum)),size= 2.5) +
      theme_void() +
      labs(title ="Participant Progression towards Outcome") +
      theme(plot.title = element_text(hjust = 0.5,face="bold")) +
      guides(fill=guide_legend(title="Treatment/Control Group"))
    ggplot_plot_3
  })
  
})


