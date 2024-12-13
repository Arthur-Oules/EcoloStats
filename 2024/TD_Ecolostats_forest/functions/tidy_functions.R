InfosPlacette <- read.csv("data/Infos.csv") |>
  select(Placette, Versant = Exposition2, Topo) |>
  group_by(Placette) |>
  unique() |>
  mutate(Topo = factor(Topo, levels = c('BDP', 'MDP', 'HDP')))

Placette_join <- function(data) {
  data |> left_join(
    y            = InfosPlacette, 
    by           = c("Placette"),
    relationship = "many-to-many"
  )
}