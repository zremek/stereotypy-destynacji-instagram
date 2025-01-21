library(tidyverse)
library(readxl)
library(DataExplorer)
library(table1)
library(sjPlot)
library(sjmisc)

foto <- read_excel("arkusz analizy.xlsx", sheet = "ZBIORCZAnaliza fotografii")

DataExplorer::create_report(foto)
# trwają konsultacje z zespołem w sprawie przygotowania danych 

table1(~ `nazwa użytkownika` + intencja + stereotyp + kraj, data = foto)
table1(~ intencja + stereotyp | kraj, data = foto) # to jest dobre do tekstu 

?tab_xtab

foto %>% group_by(kraj) %>% 
  select(intencja, stereotyp) %>% sjtab(fun = "xtab")

flat_table(data = foto, intencja, stereotyp, kraj)

# czy nazwy ze zdjęć zgadzają się z nazwami postów? 
# po left join - zdjęcia po lewej - powinny być wszystkie wiersze złączone 
# ale nazw w postach jest mniej więc nie będzie i to wskaże braki 

pst <- pst %>% rename(username = `nazwa użytkownika`)
foto <- foto %>% rename(username = `nazwa użytkownika`)

upst <- pst %>% count(username)
ufoto <- foto %>% count(username)

joinupstufoto <- left_join(x = ufoto, y = upst, by = join_by(username))
joinufotoupst <- left_join(x = upst, y = ufoto, by = join_by(username))


joinupstufoto %>% 
  filter(is.na(n.y)) %>% 
  View()

# zobaczmy czy nazwy zgadzają się z nazwami z tekstu i czego brakuje
# po lewej 27 nazw z tekstu, po prawej 25 z foto 

jointextfoto <- left_join(x = tibble(username = travel_bloggers), 
                          y = ufoto, 
                          by = join_by(username))


jointextfoto %>% 
  filter(is.na(n)) %>% 
  View()
