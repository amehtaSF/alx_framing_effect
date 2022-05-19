---
title: "dataset Alexithymia"
author: "Jean Roisse"
date: "04/18/2022"
output: csv_textfile
---

#Load packages and import data ###############################################

library(tidyverse)
library(qpcR)

dataset <- read.csv("dataset_experiment_cleaned_for_test.csv")

ds1 <- dataset


#Create Risk Variables ########################################################
###############################################################################

#Data Privacy/county

ds1$riskdp.c <- NA

ds1$riskdp.c <- case_when(ds1$c_dplt == 1 ~ 1, 
                         ds1$c_dpgt == 1 ~ 1,
                         ds1$c_dplt == 0 ~ 0,
                         ds1$c_dpgt == 0 ~ 0) 


#Data Privacy/municipal

ds1$riskdp.m <- NA

ds1$riskdp.m <- case_when(ds1$dplt == 1 ~ 1, 
                         ds1$dpgt == 1 ~ 1,
                         ds1$dplt == 0 ~ 0,
                         ds1$dpgt == 0 ~ 0) 



###############################################################################
#Economy/county

ds1$riskecon.c <- NA

ds1$riskecon.c <- case_when(ds1$c_econlt == 1 ~ 1, 
                          ds1$c_econgt == 1 ~ 1,
                          ds1$c_econlt == 0 ~ 0,
                          ds1$c_econgt == 0 ~ 0) 


#Economy/municipal

ds1$riskecon.m <- NA

ds1$riskecon.m <- case_when(ds1$econlt == 1 ~ 1, 
                          ds1$econgt == 1 ~ 1,
                          ds1$econlt == 0 ~ 0,
                          ds1$econgt == 0 ~ 0) 


###############################################################################
#Data Privacy_Economy/county

ds1$riskdpecon.c <- NA

ds1$riskdpecon.c <- case_when(ds1$c_dpeconlt == 1 ~ 1, 
                            ds1$c_dpecongt == 1 ~ 1,
                            ds1$c_dpeconlt == 0 ~ 0,
                            ds1$c_dpecongt == 0 ~ 0) 


#Data Privacy_Economy/municipal

ds1$riskdpecon.m <- NA

ds1$riskdpecon.m <- case_when(ds1$dpeconlt == 1 ~ 1, 
                            ds1$dpecongt == 1 ~ 1,
                            ds1$dpeconlt == 0 ~ 0,
                            ds1$dpecongt == 0 ~ 0) 


#Create Treatment Variables ###################################################
###############################################################################

#Data Privacy/county

ds1$treatdp.c <- 0

ds1$treatdp.c <- case_when(ds1$c_dpgt == 1 ~ 1, 
                          ds1$c_dpgt == 0 ~ 1,
                          ds1$c_dplt == 0 ~ 0,
                          ds1$c_dplt == 1 ~ 0)


#Data Privacy/municipal

ds1$treatdp.m <- 0

ds1$treatdp.m <- case_when(ds1$dpgt == 1 ~ 1, 
                            ds1$dpgt == 0 ~ 1,
                            ds1$dplt == 0 ~ 0,
                            ds1$dplt == 1 ~ 0)


###############################################################################
#Economy/county

ds1$treatecon.c <- 0

ds1$treatecon.c <- case_when(ds1$c_econgt == 1 ~ 1, 
                           ds1$c_econgt == 0 ~ 1,
                           ds1$c_econlt == 0 ~ 0,
                           ds1$c_econlt == 1 ~ 0)


#Economy/municipal

ds1$treatecon.m <- 0

ds1$treatecon.m <- case_when(ds1$econgt == 1 ~ 1, 
                           ds1$econgt == 0 ~ 1,
                           ds1$econlt == 0 ~ 0,
                           ds1$econlt == 1 ~ 0)


###############################################################################
#Data Privacy and Economy/county

ds1$treatdpecon.c <- 0

ds1$treatdpecon.c <- case_when(ds1$c_dpecongt == 1 ~ 1, 
                             ds1$c_dpecongt == 0 ~ 1,
                             ds1$c_dpeconlt == 0 ~ 0,
                             ds1$c_dpeconlt == 1 ~ 0)


#Data Privacy and Economy/municipal

ds1$treatdpecon.m <- 0

ds1$treatdpecon.m <- case_when(ds1$dpecongt == 1 ~ 1, 
                             ds1$dpecongt == 0 ~ 1,
                             ds1$dpeconlt == 0 ~ 0,
                             ds1$dpeconlt == 1 ~ 0)



#cbind: county and municipal risk variables ###################################
###############################################################################

#Data Privacy
ds1$riskdp <- qpcR:::cbind.na(ds1$riskdp.c, ds1$riskdp.m)

#Economy
ds1$riskecon <- qpcR:::cbind.na(ds1$riskecon.c, ds1$riskecon.m)

#Data Privacy and Economy
ds1$riskdpecon <- qpcR:::cbind.na(ds1$riskdpecon.c, ds1$riskdpecon.m)


#cbind: county and municipal treatment variables ##############################
###############################################################################

#Data Privacy
ds1$treatdp <- qpcR:::cbind.na(ds1$treatdp.c, ds1$treatdp.m)

#Economy
ds1$treatecon <- qpcR:::cbind.na(ds1$treatecon.c, ds1$treatecon.m)

#Data Privacy and Economy
ds1$treatdpecon <- qpcR:::cbind.na(ds1$treatdpecon.c, ds1$treatdpecon.m)


#Save dataset
###############################################################################

dataset.alexithymia

write.csv(ds1, 'ds.risk.treat.alexithymia.csv')
