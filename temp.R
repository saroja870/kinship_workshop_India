kin_out_2020_2090$kin_summary %>%
  filter(group == "d") %>% 
  filter(year == 2020) %>% 
  rename(kin = group) %>% 
  rename_kin(sex = "2sex") %>%
  summarise(count=sum(count), .by = c(kin_label, year, age_focal)) %>%
  ggplot(aes(x = age_focal, y = count, fill=kin_label)) +
  geom_area(colour = "black") +
  labs(y = "Expected number of living kin by Focal's age",
       x = "Year") +
  theme_bw() +
  theme(legend.position = "bottom")

kin_out_2020_2090$kin_summary %>%
  filter(group == "d") %>% 
  # filter(year == 2020) %>% 
  rename(kin = group) %>% 
  rename_kin(sex = "2sex") %>% 
  summarise(count=sum(count), .by = c(stage_kin, year)) %>%
  ggplot(aes(x = year, y = count, fill=stage_kin)) +
  geom_area(colour = "black") +
  labs(y = "Expected number of living kin by Focal's age",
       x = "Year") +
  theme_bw() +
  theme(legend.position = "bottom")


kin_out_2020_2090$kin_summary %>%
  dplyr::filter(group %in% c("d")) %>%
  group_by(year, stage_kin) %>%
  dplyr::summarize(sum_count = sum(count))%>%
  ggplot2::ggplot(ggplot2::aes(x = year, y = sum_count, color = stage_kin, fill = stage_kin)) +
  ggplot2::geom_bar(position = "stack", stat = "identity") +
  # ggplot2::facet_grid(sex_kin ~ year) +
  # ggplot2::scale_x_continuous(breaks = c(0,10,20,30,40,50,60,70,80,90,100)) +
  ggplot2::theme_bw() +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 90, vjust = 0.5)) +
  ggplot2::ylab("Daughters")
