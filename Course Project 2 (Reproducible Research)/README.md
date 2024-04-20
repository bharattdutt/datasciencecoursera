#Weather Events Analysis

#Overview

This R script analyzes weather event data to identify the top events with the greatest economic consequences and health impacts in the United States.

#Data

The analysis requires a dataset containing information on weather events, including variables such as event type (EVTYPE), property damage (PROPDMG), crop damage (CROPDMG), injuries (INJURIES), and fatalities (FATALITIES). The dataset should be in a CSV format and should include relevant columns for the analysis.

#Economic Consequences

The script aggregates property and crop damage data for each weather event type and identifies the top 10 events with the greatest economic consequences. It then creates a bar chart visualizing the cost of damage for each event type, highlighting both property and crop damage.

#Health Impact

Similarly, the script aggregates injury and fatality data for each weather event type and identifies the top 20 events with the highest health impacts. It creates a bar chart visualizing the total number of fatalities and injuries for each event type.

#Requirements

-R (>=3.0.0)

-ggplot2

-dplyr

-tidyr
