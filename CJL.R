#Load packages
library(dplyr)
library(ggplot2)
library(gridExtra)

#Load YCOE data and clean up
YCOE_data <- read.csv("LeftPeripheries_YCOE.cod.ooo", header=F, sep = ":")
colnames(YCOE_data) = c("Type","Spec","N","ID")
YCOE_filenames <- read.csv("YCOE_match_IDs_to_files.csv")
YCOE_data <- merge(YCOE_filenames,YCOE_data,by="ID")

#Load PPCHE + PCEMP data and clean up
PPCHE_data <- read.csv("LeftPeripheries_PPCHE.cod.ooo", header=F, sep = ":")
colnames(PPCHE_data) = c("Type","Spec","N","ID")
PPCHE_filenames <- read.csv("Penn_match_IDs_to_files.csv", header=T)
PPCHE_data <- merge(PPCHE_filenames,PPCHE_data,by="ID")

#Merge YCOE and PPCHE/PCMEP, add basic info
AllData <- rbind(YCOE_data,PPCHE_data)
AllInfo <- read.csv("Allfiles_basic_info.csv", header=T)
AllInfo <- AllInfo[c(1,2,4,3)]
AllData <- merge(AllData,AllInfo,by="File")
AllData <- AllData[,c(1,3:5,7,6,8)]

# Load PLAEME data, clean up, add to YCOE/PPCHE/PCMEP
PLAEME_data <- read.csv("LeftPeripheries_PLAEME.cod.ooo", header=F, sep = ":")
colnames(PLAEME_data) = c("Type","Spec","N","File")
PLAEME_data$File <- tolower(PLAEME_data$File)
PLAEME_info <- read.csv("PLAEME_basic_info.csv",header = T)
PLAEME_info <- PLAEME_info[,c(3,1,5)]
colnames(PLAEME_info) = c("Words","File","Year")
PLAEME_info$File <- tolower(PLAEME_info$File)
PLAEME_info$Corpus <- "PLAEME"
PLAEME_data <- merge(PLAEME_data,PLAEME_info,by="File")
AllData <- rbind(AllData,PLAEME_data)

#Subset various ME Wh-Rels incl Frl
Rels <- subset(AllData, Type %in% c("Rel","Frl","Car") &
                 Corpus %in% c("YCOE","PPCME","PCMEP","PLAEME","PPCEME"))
WhRels <- subset(Rels, Spec %in% c("What","Which","HW"))
WhichRels <- subset(WhRels,Spec == "Which")
WhichFrls <- subset(WhichRels,Type == "Frl")
WhichHeaded <- subset(WhichRels,Type != "Frl")
WhatRels <- subset(WhRels,Spec == "What")
WhatFrls <- subset(WhatRels,Type == "Frl")

#Plot parameters -- how many rels are wh-rels?
Wh.gg <- ggplot(Rels,aes(x=Year,y=ifelse(Spec %in% c("Which","What","HW"),1,0),col="All Wh")) +
  geom_smooth() +
  geom_smooth(data=Rels,aes(x=Year,y=ifelse(Spec == "Which",1,0),col="Which")) +
  geom_smooth(data=Rels,aes(x=Year,y=ifelse(Spec == "What",1,0),col="What")) +
  geom_smooth(data=Rels,aes(x=Year,y=ifelse(Spec == "HW",1,0),col="Other")) +
  coord_cartesian(ylim = c(0,0.75)) + 
  scale_color_discrete("Wh-phrase",breaks=c("All Wh","Which","What","Other")) +
  guides(color=guide_legend(override.aes = list(fill=NA))) +
  ylab("Proportion Wh") +
  theme_minimal()

#Plot parameters -- zoomed version of above
WhZoom.gg <- ggplot(Rels,aes(x=Year,y=ifelse(Spec == "Which",1,0),col="Which")) +
  geom_smooth() +
  geom_smooth(data=Rels,aes(x=Year,y=ifelse(Spec == "What",1,0),col="What")) +
  coord_cartesian(ylim = c(0,0.1),xlim=c(1150,1350)) + 
  scale_color_manual("Wh-phrase",values=c("#00BFC4","#C77CFF"),breaks=c("Which","What")) +
  guides(color=guide_legend(override.aes = list(fill=NA))) +
  ylab("Proportion Wh") +
  theme_minimal()

#Plot parameters -- how many of which Spec is FRL vs. REL?
WhFrlRel.gg <- ggplot(WhichRels,aes(x=Year,y=ifelse(Type %in% c("Rel","Car"),1,0),col="Which")) +
  geom_smooth() +
  geom_smooth(data=WhatRels,aes(x=Year,y=ifelse(Type %in% c("Rel","Car"),1,0),col="What")) +
  coord_cartesian(ylim = c(0,1)) +
  scale_color_discrete("Wh-phrase",breaks=c("Which","What")) +
  guides(color=guide_legend(override.aes = list(fill=NA))) +
  ylab("Proportion headed") + 
  theme_minimal()


#Plot parameters -- graph for Frls only
WhN_frl.gg <- ggplot(subset(Which_Frlcounts,Year<1500),aes(x=Year,y=WhichN/Total,col="Which")) +
  geom_point(aes(size=Total)) +
  geom_point(data=subset(What_Frlcounts,Year<1500),aes(x=Year,y=WhatN/Total,col="What",size=Total)) +
  geom_vline(aes(xintercept=1162),linetype="longdash",colour="grey30") +
  geom_vline(aes(xintercept=1362),linetype="longdash",colour="grey30") +
  annotate("text", x=1050,y=0.9,size=3,label="Stage 1",colour="grey30") +
  annotate("text", x=1262,y=0.9,size=3,label="Stage 2",colour="grey30") +
  annotate("text", x=1450,y=0.9,size=3,label="Stage 3",colour="grey30") +
  coord_cartesian(ylim = c(0,1)) +
  ylab("Proportion Wh-N") +
  scale_size_area("# obs") +
  scale_color_discrete("Wh-phrase") +
  theme_minimal()

#Plot parameters -- how do ME free vs. headed which-rels compare?
WhichN_headed.gg <- ggplot(subset(Which_Headedcounts,Year<1500),aes(x=Year,y=WhichN/Total)) +
  geom_point(aes(size=Total,col="Headed")) +
  geom_point(data=subset(Which_Frlcounts,Year<1500),aes(size=Total,col="Free")) +
  geom_smooth(data=subset(Which_Headedcounts,Year > 1250),aes(x=Year,y=WhichN/Total,col="Headed")) +
  geom_smooth(data=subset(Which_Frlcounts,Year<1350),aes(x=Year,y=WhichN/Total,col="Free")) +
  coord_cartesian(xlim=c(850,1500),ylim=c(0,1)) +
  scale_color_manual("RC type",values=c("#00BFC4","#F8766D")) +
  ylab("Proportion 'Which N'") +
  guides(color=guide_legend(override.aes = list(fill=NA))) +
  scale_size_area("# obs") +
  theme_minimal()

#Generate pdfs
pdf("Wh.pdf",width=8,height=4)
Wh.gg
dev.off()

pdf("WhZoom.pdf",width=8,height=2)
WhZoom.gg
dev.off()

pdf("WhFrlRel.pdf",width=8,height=4)
WhFrlRel.gg
dev.off()

pdf("WhN_frl.pdf",width=8,height=4)
WhN_frl.gg
dev.off()

pdf("WhichN_headed.pdf",width=8,height=4)
WhichN_headed.gg
dev.off()

########
########
# Nonreferential antecedent code
########
########

#Load data and sort.  Three different csv files for three different queries
Nonrefs <- read.csv("Nonref_antecedent.cod.ooo",header=F,sep = ":")
Nonrefs_ext <- read.csv("Nonref_extraposition.cod.ooo",header=F,sep = ":")
Nonrefs_car <- read.csv("Nonref_car_manual.cod.ooo",header=F,sep = ":")
Nonrefs <- rbind(Nonrefs,Nonrefs_ext)
Nonrefs <- rbind(Nonrefs,Nonrefs_car)
Nonrefs <- Nonrefs[,1:3]
colnames(Nonrefs) <- c("Antecedent","Rel","ID")
Nonrefs <- subset(Nonrefs,Rel %in% c("WhichN","Which","Rel"))
Nonrefs <- merge(PPCHE_filenames,Nonrefs,by="ID")
Nonrefs <- merge(Nonrefs,AllInfo,by="File")

#Subset
NoFew <- subset(Nonrefs,Antecedent != "X")
NonrefWhichN <- subset(Nonrefs,Rel == "WhichN")
NonrefWhich <- subset(Nonrefs,Rel == "Which")
NonrefRel <- subset(Nonrefs,Rel == "Rel")
NoFewWhichN <- subset(NoFew,Rel == "WhichN")
NoFewWhich <- subset(NoFew,Rel == "Which")
NoFewRel <- subset(NoFew,Rel == "Rel")

#Count subsets and make into df
NonrefWhichN %>% group_by(File,Year) %>% summarise(AllWhichN=n()) -> NonrefWhichN_counts
NonrefWhich %>% group_by(File,Year) %>% summarise(AllWhich=n()) -> NonrefWhich_counts
NonrefRel %>% group_by(File,Year) %>% summarise(AllRel=n()) -> NonrefRel_counts
NoFewWhichN %>% group_by(File,Year) %>% summarise(NoFewWhichN=n()) -> NoFewWhichN_counts
NoFewWhich %>% group_by(File,Year) %>% summarise(NoFewWhich=n()) -> NoFewWhich_counts
NoFewRel %>% group_by(File,Year) %>% summarise(NoFewRel=n()) -> NoFewRel_counts
Nonref_AllCounts <- merge(NonrefWhichN_counts,NonrefWhich_counts,all=T)
Nonref_AllCounts <- merge(Nonref_AllCounts,NonrefRel_counts,all=T)
Nonref_AllCounts <- merge(Nonref_AllCounts,NoFewWhichN_counts,all=T)
Nonref_AllCounts <- merge(Nonref_AllCounts,NoFewWhich_counts,all=T)
Nonref_AllCounts <- merge(Nonref_AllCounts,NoFewRel_counts,all=T)
Nonref_AllCounts[is.na(Nonref_AllCounts)] <- 0

#Plot parameters, distribution of nonrefs pt.1
Nonref_combined_which.gg <- ggplot(subset(Nonrefs,Year>1339 & Rel == "Rel"),aes(x=Year,y=ifelse(Antecedent %in% c("No","Few"),1,0),col="Other")) +
  geom_smooth() +
  geom_smooth(data=subset(Nonrefs,Year > 1339 & Rel %in% c("Which","WhichN")),aes(x=Year,y=ifelse(Antecedent %in% c("No","Few"),1,0),col="Which")) +
  coord_cartesian(ylim=c(0,0.05)) +
  ylab("Proportion nonref. antecedent") +
  scale_color_discrete("Relativizer",breaks = c("Other","Which")) +
  guides(color=guide_legend(override.aes = list(fill=NA))) +
  theme_minimal()

#Plot parameters, distribution of nonrefs pt.2
Nonref2_combined_which.gg <- ggplot(subset(Nonrefs,Year > 1339 & Antecedent %in% c("No","Few") & Rel %in% c("Rel","Which","WhichN")),aes(x=Year,y=ifelse(Rel == "Rel",1,0))) +
  geom_smooth(aes(col="Other")) +
  geom_smooth(aes(y=ifelse(Rel != "Rel",1,0),col="Which")) +
  ylab("Proportion relativizer") +
  scale_color_discrete("Relativizer",breaks = c("Other","Which")) +
  guides(color=guide_legend(override.aes = list(fill=NA))) +
  theme_minimal()

#Generate pdf for nonrefs
pdf("WhichOpaque.pdf",width=8,height=4)
grid.arrange(Nonref_combined_which.gg,Nonref2_combined_which.gg,ncol=2)
dev.off()

########
## Predicted no N which N
########


Nonref_AllCounts %>% mutate(AllWhichTotal = AllWhichN+AllWhich,
                            NoFewWhichTotal = NoFewWhichN+NoFewWhich,
                            NoFewTotal = NoFewWhichTotal + NoFewRel) %>%
  filter(AllWhichTotal > 0 & NoFewTotal > 0) %>%
  mutate(WhichNProp = AllWhichN/AllWhichTotal,
         NoFewWhichProp = NoFewWhichTotal/NoFewTotal) -> Nonref_for_predict

#Add predicted values from loess smoothers
WhichN.predict <- predict(loess(WhichNProp ~ Year,data=Nonref_for_predict),se=T)
NoFewWhich.predict <- predict(loess(NoFewWhichProp ~ Year, data = Nonref_for_predict),se=T)
Nonref_for_predict$WhichNLoess <- WhichN.predict$fit
Nonref_for_predict$NoFewWhichLoess <- NoFewWhich.predict$fit
Nonref_for_predict %>% mutate(ProductLoess = WhichNLoess * NoFewWhichLoess,
                              WhichNLoessCI = WhichNLoess - qt(0.975,WhichN.predict$df)*WhichN.predict$se,
                              NoFewWhichLoessCI = NoFewWhichLoess - qt(0.975,NoFewWhich.predict$df)*NoFewWhich.predict$se,
                              ProductLoessCI = WhichNLoessCI * NoFewWhichLoessCI,
                              ProductLoessCINoMinus = ifelse(ProductLoessCI<0,0,ProductLoessCI),
                              NoFewWhichN.Expected = ProductLoess * NoFewTotal,
                              NoFewWhichN.Expected.CI = ProductLoessCINoMinus * NoFewTotal) -> Nonref_for_predict

#Plot parameters: expected no N which N
NoFewWhichN.predict.gg <- ggplot(subset(Nonref_for_predict,Year > 1339),aes(x=Year,y=ProductLoess)) +
  geom_line(aes(color="Product"),size=1.25) +
  geom_line(aes(y=ifelse(ProductLoessCI <= 0.001, 0.001,ProductLoessCI),color="Product"),linetype=2) +
  geom_line(aes(y=WhichNLoess,color="Which N")) +
  geom_line(aes(y=NoFewWhichLoess,color="Nonref. + which")) +
  coord_cartesian(ylim=c(0.001,0.5)) +
  scale_color_discrete("Construction",breaks = c("Which N", "Nonref. + which", "Product")) +
  scale_y_log10(breaks=c(0.001,0.01,0.1),labels=c("0","0.01","0.1")) +
  ylab("Proportion (log scale)") +
  theme_minimal()

#Generate pdf
pdf("NoFewWhichN_predict.pdf",width=8,height=4)
NoFewWhichN.predict.gg
dev.off()

#Estimates of expected count of no N which N
sum(Nonref_for_predict$NoFewWhichN.Expected)
sum(Nonref_for_predict$NoFewWhichN.Expected.CI)
subset(Nonref_AllCounts,Year >1339) %>% summarise(WhichNTotal = sum(AllWhichN),
                               WhichTotal = WhichNTotal + sum(AllWhich),
                               WhichNFreq = WhichNTotal/WhichTotal,
                               PredictWhichN = sum(NoFewWhich) * WhichNFreq)