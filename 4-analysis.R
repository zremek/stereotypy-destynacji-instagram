library(gtsummary)

table1(~ intent + stereotype | country, data = en_p, caption = "posts") # to jest dobre do tekstu 
table1(~ intent + stereotype | country, data = en_f, caption = "photos") # to jest dobre do tekstu 

table1(~ username | country, data = en_f, caption = "photos")



class(en_p$post_date)

# tbl_summary(en_p %>% select(-l.p))                                                  # default

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

#SRQ1

chisq.test(x = table(en_p$stereotype), p = c(1/3, 1/3, 1/3))

chisq.test(x = table(en_f$stereotype), p = c(1/3, 1/3, 1/3))


# SRQ2
en_p %>% sjtab(intent, stereotype, fun = "xtab", show.col.prc = TRUE)

en_f %>% sjtab(intent, stereotype, fun = "xtab", show.col.prc = TRUE)




stats::fisher.test(x = en_p$intent, y = en_p$stereotype)

stats::fisher.test(x = en_f$intent, y = en_f$stereotype)

t_int_ster_p <- table(x = en_p$intent, y = en_p$stereotype)
t_int_ster_f <- table(x = en_f$intent, y = en_f$stereotype)


chi_test_p <- chisq.test(t_int_ster_p)
print(chi_test_p)

chi_test_f <- chisq.test(t_int_ster_f)
print(chi_test_f)

# Extract and print the expected frequencies
chi_test_p$expected
chi_test_f$expected
