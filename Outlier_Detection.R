#Author: Anastasia Dimakou
#Outlier detection of reaction time data based on boxplot methods 
require(dplyr); require(rstatix)


# Compute summary statistics before removing outliers
summary_before <- data %>%
  group_by(Participant) %>%
  summarize(
    mean_RT_before = mean(Reaction_Time),
    median_RT_before = median(Reaction_Time),
    min_RT_before = min(Reaction_Time),
    max_RT_before = max(Reaction_Time)
  )

#identifying the outliers for each participant
out=data%>%
  group_by(Participant) %>%
  identify_outliers("Reaction_Time")
# }

View(out)

#Removing the outliers 

# Assuming you have already identified the outliers and stored them in a variable `out`.


# Remove outliers from the dataset
data_filtered <- data %>%
  anti_join(out, by = c("Participant", "Reaction_Time"))

# The resulting `data_filtered` will be the original dataset with the outliers removed.

# Compute summary statistics after removing outliers
summary_after <- data_filtered %>%
  group_by(Participant) %>%
  summarize(
    mean_RT_after = mean(Reaction_Time),
    median_RT_after = median(Reaction_Time),
    min_RT_after = min(Reaction_Time),
    max_RT_after = max(Reaction_Time)
  )

# Print summary statistics before and after removing outliers
print("Summary Statistics - Before Removing Outliers:")
print(summary_before)

print("\nSummary Statistics - After Removing Outliers:")
print(summary_after)