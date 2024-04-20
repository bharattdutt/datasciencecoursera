library(ggplot2)
library(dplyr)
library(tidyr)
if (!file.exists("stormdata.csv.bz2")) {
  url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
  download.file(url, "stormdata.csv.bz2")
  bunzip2("stormdata.csv.bz2", "stormdata.csv", remove=FALSE)
}

storm <- data.table::fread("stormdata.csv", fill=TRUE, header=TRUE)
head(storm)

# Aggregate Data for Property Damage
propdmg <- aggregate(PROPDMG ~ EVTYPE, data = dataset, FUN = sum)
propdmgMax <- head(propdmg[order(propdmg$PROPDMG, decreasing = TRUE), ], 10)

# Aggregate Data for Crop Damage
cropdmg <- aggregate(CROPDMG ~ EVTYPE, data = dataset, FUN = sum)
cropdmgMax <- head(cropdmg[order(cropdmg$CROPDMG, decreasing = TRUE), ], 10)

# Merge both property and crop damage data
totalDamage <- merge(propdmgMax, cropdmgMax, by = "EVTYPE")
totalDamage <- arrange(totalDamage, desc(PROPDMG + CROPDMG))

# Melt the data for visualization
top_10_damages <- melt(totalDamage, id.vars = "EVTYPE", variable.name = "Damage_Types")

# Create chart for Economic Consequences
DamageChart <- ggplot(top_10_damages, aes(x = reorder(EVTYPE, -value/1000), y = value/1000, fill = Damage_Types)) +
  geom_bar(stat = "identity", position = "dodge") +
  xlab("Event Type") +
  ylab("Cost of Damage ($ billions)") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  ggtitle("Top 10 Greatest Economic Consequences") +
  scale_fill_manual(values = c("darkgreen", "grey"))

# Print the Economic Consequences chart
print(DamageChart)

# Aggregate Data for Injuries
total_injuries <- aggregate(INJURIES ~ EVTYPE, dataset, sum)
total_injuries <- arrange(total_injuries, desc(INJURIES))
total_injuries <- total_injuries[1:20, ]

# Aggregate Data for Fatalities
total_fatalities <- aggregate(FATALITIES ~ EVTYPE, dataset, sum)
total_fatalities <- arrange(total_fatalities, desc(FATALITIES))
total_fatalities <- total_fatalities[1:20, ]

# Create chart for Health Impact
healthChart <- ggplot(bad_stuff, aes(x = reorder(EVTYPE, -value), y = value)) +
  geom_bar(stat = "identity", aes(fill = bad_thing)) +
  xlab("Event Type") +
  ylab("Number of Fatalities and Injuries") +
  coord_flip() +
  ggtitle("Total People Loss in USA by Weather Events in 1996-2011")

# Print the Health Impact chart
print(healthChart)
