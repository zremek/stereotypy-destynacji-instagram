library(deeplr)

source("deepl.R")

deeplr::toEnglish2(
  text = c(
    "to jest zdanie w języku polskim",
    "zaś to jest inne zdanie w tym samym pięknym języku"
  ),
  source_lang = "PL",
  auth_key = my_key
)

en_f <- foto %>% mutate(country = toEnglish2(text = kraj, # nie działa 
                                     source_lang = "PL", 
                                     auth_key = my_key))


foto$country <- toEnglish2(text = split_text(foto$kraj, max_size_bytes = 29000), # nie działa
                            source_lang = "PL", 
                            auth_key = my_key)

# discouraging, encouraging, neutral intention; neutral, disproving, perpetuating stereotype

en_f <- foto %>% mutate(
  country = case_when(
    kraj == "Maroko" ~ "Morrocco",
    kraj == "Portugalia" ~ "Portugal",
    kraj == "Tunezja" ~ "Tunisia",
    kraj == "Włochy" ~ "Italy"
  ),
  intent = case_when(
    intencja == "neutralna" ~ "neutral",
    intencja == "zachęcająca" ~ "encouraging",
    intencja == "zniechęcająca" ~ "discouraging"
  ),
  stereotype = case_when(
    stereotyp == "neutralny" ~ "ignore",
    stereotyp == "obalający" ~ "debunk",
    stereotyp == "utrwalający" ~ "perpetuate"
  )
) %>% select(-kraj, -intencja, -stereotyp)

en_p <- pst %>% mutate(
  country = case_when(
    kraj == "Maroko" ~ "Morrocco",
    kraj == "Portugalia" ~ "Portugal",
    kraj == "Tunezja" ~ "Tunisia",
    kraj == "Włochy" ~ "Italy"
  ),
  intent = case_when(
    intencja == "neutralna" ~ "neutral",
    intencja == "zachęcająca" ~ "encouraging",
    intencja == "zniechęcająca" ~ "discouraging"
  ),
  stereotype = case_when(
    stereotyp == "neutralny" ~ "ignore",
    stereotyp == "obalający" ~ "debunk",
    stereotyp == "utrwalający" ~ "perpetuate"
  )
) %>% select(-kraj, -intencja, -stereotyp)

# Define a function to replace Polish month names with numeric equivalents
replace_months <- function(date_string) {
  months <- c("stycznia" = "01", "lutego" = "02", "marca" = "03", "kwietnia" = "04", 
              "maja" = "05", "czerwca" = "06", "lipca" = "07", "sierpnia" = "08", 
              "września" = "09", "października" = "10", "listopada" = "11", "grudnia" = "12")
  for (month in names(months)) {
    date_string <- gsub(month, months[[month]], date_string)
  }
  return(date_string)
}

# fix some typos

en_p$data_posta[44] <- "23 listopada 2021"
en_p$data_posta[86] <- "10 kwietnia 2024"

# Clean and parse the dates using a single mutate call
en_p <- en_p %>%
  mutate(post_date = dmy(gsub(" r\\.|r\\.", "", replace_months(data_posta))))

en_p <- en_p %>% select(-data_posta)


## make factors with proper order 

sjmisc::frq(en_p)

en_p <- en_p %>% 
mutate(
  intent = factor(intent, levels = c("discouraging", "neutral", "encouraging"), ordered = TRUE),
  stereotype = factor(stereotype, levels = c("perpetuate", "ignore", "debunk"), ordered = TRUE)
)

en_f <- en_f %>% 
  mutate(
    intent = factor(intent, levels = c("discouraging", "neutral", "encouraging"), ordered = TRUE),
    stereotype = factor(stereotype, levels = c("perpetuate", "ignore", "debunk"), ordered = TRUE)
  )


summary(en_p) # very nice
summary(en_f)
