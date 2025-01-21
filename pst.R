library(tidyverse)
library(readxl)
library(DataExplorer)
library(table1)
library(sjPlot)
library(sjmisc)

pst <- read_excel("arkusz analizy.xlsx", sheet = "ZBIORCZAanaliza postów")

pst <- pst[, 1:6]

DataExplorer::create_report(pst)
# trwają konsultacje z zespołem w sprawie przygotowania danych 

table1(~ `nazwa użytkownika` + intencja + stereotyp + kraj, data = pst)
table1(~ intencja + stereotyp | kraj, data = pst) # to jest dobre do tekstu 

# poprawka jednej nazwy 

pst[42, 2] <- "podrozovanie"
