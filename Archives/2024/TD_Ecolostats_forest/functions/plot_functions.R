hist_row_sum <- function(data, column1) {
    data |> 
      group_by({{ column1 }}) |>
      summarise(across(`25-34`:`115-124`, sum)) |>
      rowwise({{ column1 }}) |> 
      mutate(sum = sum(c_across(`25-34`:`115-124`))) |>
      ggplot(aes(x = {{ column1 }}, y = sum)) +
        geom_bar(stat = "identity") +
        labs(y = "Nombre d'arbres") +
        theme_bw()
}

hist_row_sum2 <- function(data, column1, column2) {
  data |>
    group_by({{ column1 }}, {{ column2 }}) |>
    summarise(across(`25-34`:`115-124`, sum)) |>
    rowwise() |>
    mutate(sum = sum(c_across(`25-34`:`115-124`))) |>
    ggplot(aes(x = {{ column1 }}, y = sum)) +
    geom_bar(stat = "identity") +
    ylab("Nombre d'arbres") +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    facet_wrap(vars({{ column2 }}))
}

hist_row_sum3 <- function(data, column1, column2, column3) {
  data |>
    group_by({{ column1 }}, {{ column2 }}, {{ column3 }}) |> 
    summarise(across(`25-34`:`115-124`, sum)) |> 
    rowwise() |>
    mutate(sum = sum(c_across(`25-34`:`115-124`))) |>
    ggplot(aes(x = {{ column1 }}, y = sum)) +
      geom_bar(stat = "identity") +
      ylab("Nombre d'arbres") +
      theme_bw() +
      theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 1)) +
      facet_grid(rows = vars({{ column2 }}),
                 cols = vars({{ column3 }}))
}