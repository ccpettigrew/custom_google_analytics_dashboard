library(googleAnalyticsR)
library(tidyverse)
library(lubridate)
library(readr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(DT)
library(shinythemes)
library(bbplot)
library(janitor)
library(tools)

ga_client_id <- "785581628757-8h5b31b1dugu0qthh6c0o6a6g6cjcq7l.apps.googleusercontent.com"
ga_client_secret <- "O-G9VfeY54J0ehlj0k5f-Kp2"
options(googleAuthR.client_id = ga_client_id)
options(googleAuthR.client_secret = ga_client_secret)

#Authenticate your account (putting in your gmail address) 
ga_auth(email = "chris@pettigrew.work")
#IMPORTANT: It may ask here you to enable another API here, just follow the link in the error message to do so. 
#Get a list of accounts you have access to
account_list <- ga_account_list()
#ViewID is the way to access the account you want
account_list$viewId
#Select the one you want to work with
my_ga_id <- 102407343

#channel conversions
channel_data <- google_analytics(my_ga_id, 
                                 date_range = c("2019-10-01", "2020-03-31"), 
                                 dimensions = c("channelGrouping"),
                                 metrics = c("goal3Completions", 
                                             "goal5Completions", 
                                             "goal6Completions", 
                                             "goal13Completions",
                                             "goal17Completions"),
                                 max = -1) 

channel_conversions <- channel_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  arrange(desc(total_converted, decreasing)) 

channel_conversions <- head(channel_conversions)

top_channel_conversions <- channel_conversions %>%
  select(channelGrouping, total_converted) %>%
  arrange(desc(total_converted, decreasing)) 

top_channel_conversions <- head(top_channel_conversions)

#social media conversions
social_data <- google_analytics(my_ga_id, 
                                date_range = c("2019-10-01", "2020-03-31"), 
                                dimensions = c("socialNetwork"),
                                metrics = c("goal3Completions", 
                                            "goal5Completions", 
                                            "goal6Completions", 
                                            "goal13Completions",
                                            "goal17Completions"),
                                max = -1) 

social_conversions <- social_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(socialNetwork, total_converted) %>%
  arrange(desc(total_converted, decreasing)) 

social_conversions <- social_conversions%>%
  filter(total_converted > 0,) %>%
  slice(-c(1,6)) 

#keywords

keyword_data <- google_analytics(my_ga_id, 
                                date_range = c("2019-10-01", "2020-03-31"), 
                                dimensions = c("keyword"),
                                metrics = c("goal3Completions", 
                                            "goal5Completions", 
                                            "goal6Completions", 
                                            "goal13Completions",
                                            "goal17Completions"),
                                max = -1) 

keyword_conversions <- keyword_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(keyword, total_converted) %>%
  arrange(desc(total_converted, decreasing)) 
keyword_conversions 


#device data conversions

device_data <- google_analytics(my_ga_id, 
                                 date_range = c("2019-10-01", "2020-03-31"), 
                                 dimensions = c("deviceCategory"),
                                 metrics = c("goal3Completions", 
                                             "goal5Completions", 
                                             "goal6Completions", 
                                             "goal13Completions",
                                             "goal17Completions"),
                                 max = -1) 

device_conversions <- device_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(deviceCategory, total_converted) %>%
  arrange(desc(total_converted, decreasing)) 

#day of week conversions

day_of_week_data <- google_analytics(my_ga_id, 
                                     date_range = c("2019-10-01", "2020-03-31"), 
                                     dimensions = c("dayOfWeekName"),
                                     metrics = c("goal3Completions", 
                                                 "goal5Completions", 
                                                 "goal6Completions", 
                                                 "goal13Completions",
                                                 "goal17Completions"),
                                     max = -1) 

day_of_week_conversions <- day_of_week_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(dayOfWeekName, total_converted) 

day_of_week_conversions

#most common goal path
goal_path_data<- google_analytics(my_ga_id, 
                                    date_range = c("2019-10-01", "2020-03-31"), 
                                    metrics = c("goal3Completions", 
                                                "goal5Completions", 
                                                "goal6Completions", 
                                                "goal13Completions",
                                                "goal17Completions"),
                                    dimensions = c("ga:GoalCompletionLocation","ga:goalPreviousStep1","ga:goalPreviousStep2",
                                                    "ga:goalPreviousStep3"))
goal_path_conversions <- goal_path_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(goalPreviousStep3, goalPreviousStep2, goalPreviousStep1, GoalCompletionLocation, total_converted) 
goal_path_conversions

#conversion rates


#depth conversions

depth_data <- google_analytics(my_ga_id, 
                               date_range = c("2019-10-01", "2020-03-31"), 
                               dimensions = c("pageDepth"),
                               metrics = c("goal3Completions", 
                                           "goal5Completions", 
                                           "goal6Completions", 
                                           "goal13Completions",
                                           "goal17Completions"),
                               max = -1) 

depth_conversions <- depth_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(pageDepth, total_converted) %>%
  arrange(desc(total_converted, decreasing)) %>%
  filter(total_converted > 0)

top_depth_conversions <- head(depth_conversions)

#source of conversion

referral_data <- google_analytics(my_ga_id, 
                                  date_range = c("2019-10-01", "2020-03-31"), 
                                  dimensions = c("source"),
                                  metrics = c("goal3Completions", 
                                              "goal5Completions", 
                                              "goal6Completions", 
                                              "goal13Completions",
                                              "goal17Completions"),
                                  max = -1) 

referral_conversions <- referral_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(source, total_converted) %>%
  arrange(desc(total_converted, decreasing)) %>%
  filter(total_converted > 0)

referral_conversions


#conversion_journey

journey_data<- google_analytics(my_ga_id, 
                                date_range = c("2019-03-31", "2020-03-31"), 
                                dimensions = c("goalPreviousStep1",
                                               "goalPreviousStep2",
                                               "goalCompletionLocation"),
                                metrics = c("goal3Completions", 
                                            "goal5Completions", 
                                            "goal6Completions", 
                                            "goal13Completions",
                                            "goal17Completions"),
                                max = -1) 

journey_conversions <- journey_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(goalPreviousStep2, goalPreviousStep1, goalCompletionLocation, total_converted) %>%
  arrange(desc(total_converted, decreasing))

journey_conversions

# most efficient landing page

page_efficiency_data<- google_analytics(my_ga_id, 
                                date_range = c("2019-03-31", "2020-03-31"), 
                                dimensions = c("landingPagePath"),
                                metrics = c("goal3Completions", 
                                            "goal5Completions", 
                                            "goal6Completions", 
                                            "goal13Completions",
                                            "goal17Completions"),
                                max = -1) 

efficient_conversions <- page_efficiency_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(landingPagePath, total_converted) %>%
  arrange(desc(total_converted, decreasing))

efficient_conversions <- head(efficient_conversions)
  
  
#conversions by last visit

timing_data <- google_analytics(my_ga_id, 
                                date_range = c("2019-10-01", "2020-03-31"), 
                                dimensions = c("daysSinceLastSession"),
                                metrics = c("goal3Completions", 
                                            "goal5Completions", 
                                            "goal6Completions", 
                                            "goal13Completions",
                                            "goal17Completions",
                                            "timeOnPage", "sessionDuration"),
                                max = -1) 

timing_data_conversions <- timing_data %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(daysSinceLastSession, total_converted) %>%
  arrange(desc(total_converted, decreasing)) %>%
  group_by(daysSinceLastSession)

timing_data_conversions
  
# most common exits
exit_data <- google_analytics(my_ga_id, 
                              date_range = c("2019-10-01", "2020-03-31"), 
                              metrics = c("sessions"),
                              dimensions = c("exitPagePath")) %>%
  arrange(desc(sessions, decreasing))



# avg load time
avg_load_data<- google_analytics(my_ga_id, 
                                 date_range = c("2019-10-01", "2020-03-31"), 
                                 metrics = c("sessions", "avgPageLoadTime"),
                                 dimensions = c("pageTitle")) %>%
  select(pageTitle, avgPageLoadTime) %>%
  arrange(desc(avgPageLoadTime, decreasing))
avg_load_data

#bounce rate
bounce_data<- google_analytics(my_ga_id, 
                               date_range = c("2019-10-01", "2020-03-31"), 
                               metrics = c("bounceRate", "sessions"),
                               dimensions = c("pageTitle")) %>%
  select(pageTitle, bounceRate, sessions) %>%
  arrange(desc(bounceRate, decreasing)) %>%
  filter(sessions > 100)
bounce_data

# stickiest pages
sticky_data<- google_analytics(my_ga_id, 
                               date_range = c("2019-10-01", "2020-03-31"), 
                               metrics = c("avgTimeOnPage"),
                               dimensions = c("pageTitle")) %>%
  
  arrange(desc(avgTimeOnPage, decreasing))

sticky_data

#campaign goals
sources_of_goal_completion <- google_analytics(my_ga_id, 
                                               date_range = c("2019-10-01", "2020-03-31"), 
                                               dimensions = c("acquisitionCampaign"),
                                               metrics = c("goal3Completions",
                                                           "goal5Completions", 
                                                           "goal6Completions", 
                                                           "goal13Completions",
                                                           "goal17Completions"),
                                               max = -1)
campaign_conversions <- sources_of_goal_completion %>%
  mutate(total_converted = goal3Completions + goal5Completions + goal6Completions + goal13Completions + goal17Completions) %>%
  select(acquisitionCampaign, total_converted) %>%
  arrange(desc(total_converted, decreasing)) 

campaign_conversions <- head(campaign_conversions)
