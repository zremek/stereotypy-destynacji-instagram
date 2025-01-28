library(tidyverse)
library(readxl)
library(DataExplorer)
library(table1)
library(sjPlot)
library(sjmisc)

foto <- read_excel("arkusz analizy.xlsx", sheet = "ZBIORCZAnaliza fotografii")

# DataExplorer::create_report(foto)


table1(~ `nazwa użytkownika` + intencja + stereotyp + kraj, data = foto)
table1(~ intencja + stereotyp | kraj, data = foto, caption = "zdjęcia") # to jest dobre do tekstu 

?tab_xtab

foto %>% group_by(kraj) %>% 
  select(intencja, stereotyp) %>% sjtab(fun = "xtab")

flat_table(data = foto, intencja, stereotyp, kraj)

# czy nazwy ze zdjęć zgadzają się z nazwami postów? 
# po left join - zdjęcia po lewej - powinny być wszystkie wiersze złączone 
# ale nazw w postach jest mniej więc nie będzie i to wskaże braki 

foto <- foto %>% rename(username = `nazwa użytkownika`)

foto <- foto %>% mutate(username = gsub(" ", "", tolower(gsub(" \\(.*\\)", "", username))))
pst <- pst %>% mutate(username = gsub(" ", "", tolower(gsub(" \\(.*\\)", "", username))))

upst <- pst %>% count(username)
ufoto <- foto %>% count(username)

joinupstufoto <- left_join(x = ufoto, y = upst, by = join_by(username))
joinufotoupst <- left_join(x = upst, y = ufoto, by = join_by(username))


# joinupstufoto %>% 
#   filter(is.na(n.y)) %>% 
#   View()
# 
# 
# joinufotoupst %>% 
#   filter(is.na(n)) %>% 
#   View()
