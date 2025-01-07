library(tidyverse)
library(readxl)
library(DataExplorer)

foto <- read_excel("arkusz analizy.xlsx", sheet = "ZBIORCZAnaliza fotografii")

DataExplorer::create_report(foto)
# trwają konsultacje z zespołem w sprawie przygotowania danych 
