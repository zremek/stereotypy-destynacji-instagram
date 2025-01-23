library(tidyverse)
library(readxl)
library(DataExplorer)
library(table1)
library(sjPlot)
library(sjmisc)

pst <- read_excel("arkusz analizy.xlsx", sheet = "ZBIORCZAanaliza postów")

pst <- pst[, 1:6]

# DataExplorer::create_report(pst)


table1(~ `nazwa użytkownika` + intencja + stereotyp + kraj, data = pst)
table1(~ intencja + stereotyp | kraj, data = pst, caption = "posty") # to jest dobre do tekstu 

# poprawka nazw

pst <- pst %>% rename(username = `nazwa użytkownika`)

pst <- pst %>% 
  mutate(username = gsub(" \\(.*\\)", "", username))
