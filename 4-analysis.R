library(gtsummary)

table1(~ intent + stereotype | country, data = en_p, caption = "posts") # to jest dobre do tekstu 
table1(~ intent + stereotype | country, data = en_f, caption = "photos") # to jest dobre do tekstu 

table1(~ username | country, data = en_f, caption = "photos")



class(en_p$post_date)

tbl_summary(en_p %>% select(-l.p))                                                  # default

summary(en_p$post_date)

en_p %>% group_by(country) %>% summarise(datemin = min(post_date), 
                                         datemax = max(post_date), 
                                         n = n())

tab_xtab(en_p$username, en_p$country)

en_p %>% group_by(country) %>% 
  count(username) %>% count(country) # counting influencers

en_f %>% group_by(country) %>% 
  count(username) %>% count(country) # counting influencers
7 + 10 + 8 + 7 # 32, why? because of repeating 

flat_table(en_p, username, country)



