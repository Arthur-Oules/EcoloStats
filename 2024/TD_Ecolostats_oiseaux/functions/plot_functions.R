# Load packages
library(tidyverse)
library(cowplot)

# Set theme
theme_cowplot() |> theme_set()

# Functions

box_plot <- function(data, x, y, xlab, ylab) {
  data |>
    ggplot(aes(x = {{ x }}, y = {{ y }}, group = {{ x }})) +
    geom_boxplot(fill = "lightgrey") +
    labs(
      x = xlab,
      y = ylab
    ) +
    theme_minimal_hgrid() +
    theme(
      axis.text  = element_text(size = 8),
      axis.title = element_text(size = 9)
    )
}

box_plot_ID <- function(data, y, ylab) {
  data |>
    box_plot(ID_MALE, {{ y }}, "Numéro du mâle", ylab) +
    scale_x_discrete(limits = as.character(seq(1, 6, 1)))
}

box_plot_DIF <- function(data, y, ylab) {
  data |>
    box_plot(DIFFUSION, {{ y }}, "", ylab) +
    scale_x_discrete(guide = guide_axis(angle = 45))
}

box_plot_DAY <- function(data, y, ylab) {
  data |> box_plot(JOUR, {{ y }}, "Jour", ylab)
}

plot_smooth <- function(data, x, y, xlab, ylab) {
  data |>
    ggplot(aes(x = {{ x }}, y = {{ y }})) +
    geom_point(alpha = .15) +
    geom_smooth(method = "loess", formula = y ~ x) +
    labs(
      x = xlab,
      y = ylab
    ) +
    theme(
      axis.text  = element_text(size = 8),
      axis.title = element_text(size = 9)
    )
}

plot_smooth_TIME <- function(data, y, ylab) {
  data |> plot_smooth(HEURE, {{ y }}, "Heure", ylab)
}

plot_smooth_TEMP <- function(data, y, ylab) {
  data |> plot_smooth(TEMPERATURE, {{ y }}, "Température (°C)", ylab)
}

hist_plot <- function(data, x, xlab) {
  data |>
    ggplot(aes(x = {{ x }})) +
    geom_histogram(
      fill     = "lightgrey",
      colour   = "black",
      binwidth = .1
    ) +
    labs(x = xlab) +
    theme(
      axis.text  = element_text(size = 8),
      axis.title = element_text(size = 9)
    )
}