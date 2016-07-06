#Analysis by P. Brandicourt

library(dplyr)
library(ggplot2)

ggplot(filter(distribution,Team %in% c("France","Germany")),aes(100*PC/PA)) +
  geom_density(aes(fill=Team,color=Team))+ facet_grid(Team~.)+
  xlab("Passing Percentage")+
  scale_fill_manual(values = c("darkblue","white")) +
  scale_color_manual(values = c("white","black")) 
  

  top_passers = distribution %>% mutate(perc = PC/PA) %>% 
    filter(perc>.9,Team %in% c("France","Germany")) %>%
    arrange(desc(perc))
  
  
  bottom_passers = distribution %>% mutate(perc = PC/PA) %>% 
    filter(perc<.8,Team %in% c("France","Germany")) %>%
    arrange(desc(perc))
  