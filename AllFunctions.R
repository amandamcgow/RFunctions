---
  title: "R Functions"
author: "Amanda McGowan"
date: "09/04/2020"
output: html_document
---
  
  
  Chi-Square
```{r}
library(readr)
workingdatabase <- read.csv("SampleFitnessData.csv", header = TRUE)

# Make factor variables
#workingdatabase$Group <- factor(workingdatabase$Group,
#                                levels = c(0,1),
#                                labels = c("LowFit", "HighFit"))

#workingdatabase$Race <- factor(workingdatabase$Race,
#                               levels = c(0,1),
#                               labels = c("White", "Nonwhite"))

#workingdatabase$Sex <- factor(workingdatabase$Sex,
#                               levels = c(0,1),
#                               labels = c("Male", "Female"))

# Are there differences in the proportion of high fit and low fit who identify as nonwhite? 
#0 = White; 1=Nonwhite

#Count HighFit Nonwhite
temp1 <- workingdatabase[which(workingdatabase$Group==1 & workingdatabase$Race==1),]

#Count HighFit White
temp2 <- workingdatabase[which(workingdatabase$Group==1 & workingdatabase$Race==0),]

#Count LowFit Nonwhite
temp3 <- workingdatabase[which(workingdatabase$Group==0 & workingdatabase$Race==1),]

#Count LowFit White
temp4 <- workingdatabase[which(workingdatabase$Group==0 & workingdatabase$Race==0),]

RaceChi <- matrix(c(nrow(temp1), nrow(temp2), nrow(temp3), nrow(temp4)),
                  nrow = 2,
                  dimnames = list("Race" = c("White", "Nonwhite"),
                                  "Group" = c("LowFit", "HighFit")))

# use Yates' correction when at least one cell of table has count < 5
chisq.test(RaceChi)

# remove Yates' correction
#chisq.test(RaceChi, correct = FALSE)

# remove scientific notation
options(scipen=999)
```

Bar Graph - Numerical Distance Effect
```{r}
OverallDatabase_Long <- read.csv("SampleData.csv")

df <- summarySE(data = OverallDatabase_Long, measurevar = "DV", groupvars = "Split")

ggplot(df, aes(x = Split, y = DV, fill = Split)) + 
  geom_bar(stat = "identity", color = "black",
           position = position_dodge()) + 
  geom_errorbar(aes(ymin=DV-se, ymax=DV+se), width = .2, position = position_dodge(.9)) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border=element_blank(),
        panel.background=element_blank(),
        axis.title.x = element_text(family = "sans", colour = "black", size = 10),
        axis.title.y = element_text(family = "sans", colour = "black", size = 10),
        axis.text = element_text(family = "sans", colour = "black", size = 10),
        axis.line = element_line(size = 1, linetype = "solid"), legend.position="right") +
  scale_x_discrete(limit = c("Massive", "Easy", "Hard")) +
  ylab("Median Reaction Time (ms)\n") +
  xlab("Numerical Ratio Between Comparisons") +
  coord_cartesian(ylim = c(600,1000), expand = TRUE) +
  scale_y_continuous(expand = c(0,0))+
  scale_fill_manual(values=c("#0db14b", "#00205b", "#666666")) 
ggsave('RT_DistanceEffect.pdf', units="in", useDingbats=FALSE, width = 7, height = 3)
```

Correlation Plot 
```{r}
library(Hmisc)
# Load in data
temp <- read.csv("SampleData.csv")
# Correlation matrix with p-values
cormatp <- rcorr(as.matrix(temp), type = "pearson")

# Custom color palette
custom_color <- colorRampPalette(c("#00004B", "#1C2C75",'#38598C',	'#2B798B', '#1E9B8A',	'#85D54A',	'#FDE725', '#F9FB0E'))

pdf(file = "Exercise_Pre_Corrplot.pdf") # write to pdf file (will save to working directory)

# Correlation plot
corrplot(cormatp$r,
         p.mat = cormatp$P,
         insig = "p-value",
         sig.level = 0,
         method = "circle", 
         type = "upper",
         tl.col = "black",
         bg = "white",
         col=custom_color(5),
         diag = FALSE)
dev.off()

```

Longitudinal Line Graph
```{r}
library(ggplot2)
library(Rmisc)

temp_plot <- read.csv("SampleData.csv")

df <- summarySE(data = temp_plot, measurevar = "DV", groupvars = c("Mode", "Order"))
df$Mode <- factor(df$Mode, levels = c("Control", "Exercise"), labels = c("Sedentary Instruction", "Physically Active Instruction"))

# Make custom x-axis timeline
df$Order_Standard <- rep_len(NA,nrow(df))
df$Order_Standard[which(df$Order == 1)] <- 0
df$Order_Standard[which(df$Order == 2)] <- 3
df$Order_Standard[which(df$Order == 3)] <- 10

ggplot(df, aes(x=Order_Standard, y=DV, color = Mode)) + 
  geom_line(stat = "identity", size = 1, aes(linetype=Mode)) +
  geom_errorbar(aes(ymin=DV-se, ymax=DV+se), width=0.25, size=1) +
  scale_color_discrete(name = "Mode", labels = c("Exercise", "Control")) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border=element_blank(),
        panel.background=element_blank(),
        axis.title.x = element_text(family = "sans", colour = "black", size = 10),
        axis.title.y = element_text(family = "sans", colour = "black", size = 10),
        axis.text = element_text(family = "sans", colour = "black", size = 10),
        axis.line = element_line(size = 1, linetype = "solid"), legend.position="right") +
  scale_y_continuous(limits = c(800,1100), expand = c(0,0)) +
  scale_x_continuous(breaks = c(0,3,10), labels = c("Pretest", "Posttest", "Recall")) +
  xlab("Testing Period") +
  ylab("Median Reaction Time (ms)") + 
  scale_color_manual(values=c("#00205b", "#0db14b")) +
  ggsave('RT_by_Group_Lineplot.pdf', units="in", useDingbats=FALSE, width = 7, height = 2.5)
```

Line Graph for Pre Post Designs
```{r, fig.width=10,fig.height=5}

OverallDatabase_Long <- read.csv("SampleData.csv")

df <- summarySE(data = OverallDatabase_Long, measurevar = "DV", groupvars = c("Mode", "Time", "Split"))
df$Split_f = factor(df$Split, levels = c("Massive", "Easy", "Hard"))

ggplot(df, aes(x=Time, y=DV, group=Mode, color=Mode)) + 
  geom_errorbar(aes(ymin=DV-se, ymax=DV+se), width=0.25, size=1) +
  geom_line(aes(linetype=Mode), size=1) +
  geom_point(aes(shape=Mode), size=2) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border=element_blank(),
        strip.background = element_blank(),
        panel.background=element_blank(),
        axis.title.x = element_text(family = "sans", colour = "black", size = 10),
        axis.title.y = element_text(family = "sans", colour = "black", size = 10),
        axis.text = element_text(family = "sans", colour = "black", size = 10),
        axis.line = element_line(size = 1, linetype = "solid"), legend.position="right") +
  scale_y_continuous(limits = c(700, 1000), expand = c(0,0)) +
  ylab("Median Reaction Time (ms)\n") +
  xlab(NULL) +
  scale_color_manual(values=c("#00205b", "#0db14b")) +
  facet_wrap(~as.factor(Split_f), nrow=1)
rm(df)
ggsave('RT_Split_Linegraph.pdf', units="in", useDingbats=FALSE, width = 7, height = 3)
```

Scatterplot
```{r, fig.width=7, fig.height=3}
tryCatch(library(doBy), error=function(e){install.packages("doBy"); library(doBy)}) # load packages

# Load in database
Complete_Long <- read.csv("SampleData.csv")

# Collapse across block
tempplotdat <- summaryBy(DV ~ ID + Split + Age + Sex + Nonwhite + BodyFat + Fitness, FUN=c(mean), keep.names=TRUE, data=Complete_Long)
tempplotdat$Split <- factor(tempplotdat$Split, levels = c("Massive", "Large", "Small"))
tempplotdat$Sex <- as.factor(tempplotdat$Sex)

# Make plot
ggplot(tempplotdat, aes(x = Fitness, y=DV, color = Split)) +
  geom_point(shape=16, size = 3, alpha = 0.5) +
  geom_smooth(method=lm) +
  facet_wrap(~Split) +
  # theme for manuscript 
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing = unit(2,"lines"),
        panel.border=element_blank(),
        panel.background=element_blank(),
        strip.background = element_blank(),
        strip.text.x = element_text(family = "sans", colour = "black", size = 12),
        axis.title.x = element_text(family = "sans", colour = "black", size = 12),
        axis.title.y = element_text(family = "sans", colour = "black", size = 12),
        axis.text = element_text(family = "sans", colour = "black", size = 12),
        axis.line = element_line(size = 1, linetype = "solid"), legend.position="none") +
  xlab("Fitness Percentile") + 
  ylab("Reaction Time (ms)") + 
  scale_color_manual(values=c( "#00205b", "#e87722", "#0db14b")) + 
  scale_y_continuous(expand = c(0, 0), limits=c(100,1400), breaks = c(200,400,600,800,1000,1200,1400)) +
  ggsave('RTFitnessGraphbySplit.pdf', units="in", useDingbats=FALSE, width = 7, height = 3) # save to pdf

```

ERP Waveform Plot
```{r}
ERPworking <- read.csv("ERPWaveformSampleData.csv")
ggplot(ERPworking, aes(Time, ExtraSmall_Amp, fill = Group, linetype = Group)) +
  ggtitle("Extra Small Peak Amplitude") +
  stat_summary(fun.y = mean,geom = "line",size = 2,aes(colour = Group)) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing = unit(2,"lines"),
        panel.border=element_blank(),
        panel.background=element_blank(),
        strip.background = element_blank(),
        axis.title.x = element_text(family = "sans", colour = "black", size = 12),
        axis.title.y = element_text(family = "sans", colour = "black", size = 12),
        axis.text = element_text(family = "sans", colour = "black", size = 12),
        axis.line = element_line(size = 1, linetype = "solid"), legend.position="right") +
  labs(x = "Time (ms)",y = expression(paste("Amplitude (",mu,"V)")),colour = "") +
  scale_color_manual(values=c("#0db14b", "#00205b")) +
  scale_x_continuous(breaks = c(-2500,-2000,-1500,-1000,-500,0,500,1000), expand = c(0,0), limits = c(-3000,1000)) +
  scale_y_reverse(expand=c(0,0)) +
  coord_cartesian(ylim = c(8, -4))
ggsave('FitnessWaveform.pdf', units="in", useDingbats=FALSE, width = 6, height = 3) # save to pdf 
```

ERP Waveform with Smoothing
```{r}
# Read in database
ERPworking <- read.csv("ERPWaveformSampleData.csv")

# Subset Data
temp <- ERPworking[which(ERPworking$Group == "Low Fit"),]

# Plot All Data
ggplot(temp, aes(Time)) +
  ggtitle("Lower Aerobic Fitness Group") +
  stat_smooth(fun.y = mean,geom = "line",size = 2,aes(y = temp$ExtraSmall_Amp, colour = "black"), span = 0.1, method = "loess") + #smoothing
  stat_smooth(fun.y = mean,geom = "line",size = 2,aes(y = temp$Medium_Amp, colour = "red"), span = 0.1, method = "loess") +
  stat_smooth(fun.y = mean,geom = "line",size = 2,aes(y = temp$Large_Amp, colour = "grey"), span = 0.1, method = "loess") +
  stat_smooth(fun.y = mean,geom = "line",size = 2,aes(y = temp$Massive_Amp, colour = "green"), span = 0.1, method = "loess") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing = unit(2,"lines"),
        panel.border=element_blank(),
        panel.background=element_blank(),
        strip.background = element_blank(),
        axis.title.x = element_text(family = "sans", colour = "black", size = 12),
        axis.title.y = element_text(family = "sans", colour = "black", size = 12),
        axis.text = element_text(family = "sans", colour = "black", size = 12),
        axis.line = element_line(size = 1, linetype = "solid"), legend.position="right") +
  labs(x = "Time (ms)",y = expression(paste("Amplitude (",mu,"V)")),colour = "") +
  #scale_color_manual(values=c("#0db14b", "#00205b")) +
  scale_x_continuous(breaks = c(-2500,-2000,-1500,-1000,-500,0,500,1000), expand = c(0,0), limits = c(-3000,1000)) +
  scale_y_reverse(expand=c(0,0)) +
  coord_cartesian(ylim = c(8, -4)) 
ggsave('LowFitP3AmplitudebySplit.pdf', units="in", useDingbats=FALSE, width = 6, height = 3)
```

Pupil Waveform Plot
```{r}
workingdatabase <- read.csv("SampleData.csv")

ggplot(workingdatabase, aes(Time, Amplitude, fill = Group)) +
  stat_summary(fun.y = mean,geom = "line",size = 2,aes(colour = Group)) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.spacing = unit(2,"lines"),
        panel.border=element_blank(),
        panel.background=element_blank(),
        strip.background = element_blank(),
        axis.title.x = element_text(family = "sans", colour = "black", size = 12),
        axis.title.y = element_text(family = "sans", colour = "black", size = 12),
        axis.text = element_text(family = "sans", colour = "black", size = 12),
        axis.line = element_line(size = 1, linetype = "solid"), legend.position="none") +
  labs(x = "Time (ms)",y = expression(paste("Amplitude (",mu,"m)")),colour = "") +
  #geom_vline(xintercept = 0,linetype = "dashed" )+
  #geom_hline(yintercept = 0,linetype = "dashed") +
  scale_color_manual(values=c("#00205b", "#0db14b")) +
  scale_x_continuous(breaks = c(-1000,-500, 0, 500, 1000, 1500, 2000), expand = c(0,0)) + 
  scale_y_continuous(breaks = c(-0.05,0,0.05,0.10),expand = c(0,0)) +
  coord_cartesian(ylim = c(-0.05, 0.10))

#scale_y_reverse()

ggsave('Pupil_Plot_Group.pdf', units="in", useDingbats=FALSE, width = 12, height = 10)
```

