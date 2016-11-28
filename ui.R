# ui

fluidPage(
  tabsetPanel(type = "tabs",
              tabPanel("Sněmovní volby 2017",
                       tabsetPanel(type = "tabs", 
                                   tabPanel("Podíl hlasů",
                                            h3("Jaký je aktuální podíl hlasů pro stranu?"),
                                            sidebarLayout(
                                              sidebarPanel(
                                                actionButton(inputId = "psp_votes_update", label = "Aktualizovat graf"),
                                                p(),
                                                radioButtons(inputId = "psp_votes_time",
                                                                   label = "Časové období",
                                                                   choices = list(
                                                                     "Poslední tři měsíce" = Sys.Date()-90,
                                                                     "Poslední rok" = Sys.Date()-365,
                                                                     "Od posledních voleb" = as.Date("2013-10-26", format = "%Y-%m-%d")
                                                                   ),
                                                                   selected = Sys.Date()-365
                                                             ),
                                                checkboxGroupInput(inputId = "psp_votes_parties",
                                                                   label = "Politické strany",
                                                                   choices = psp_parties_choices,
                                                                   selected = psp_parties_selected
                                                                   ),
                                                checkboxGroupInput(inputId = "psp_votes_poll_types",
                                                                   label = "Průzkumy",
                                                                   choices = psp_poll_types_choices,
                                                                   selected = psp_poll_types_selected
                                                                   ),
                                                checkboxGroupInput(inputId = "psp_votes_features",
                                                                   label = "Zobrazení",
                                                                   choices = list(
                                                                     "4G model" = 1,
                                                                     "80% interval spolehlivosti 4G modelu" = 2,
                                                                     "Spojnice výsledků průzkumů" = 3,
                                                                     "80% interval spolehlivosti průzkumů" = 4),
                                                                   selected = c(1, 2)
                                                ),
                                                
                                                width = 3
                                              ),
                                              mainPanel(
                                                htmlOutput("psp_votes_chart"),
                                                width = 9
                                              )
                                            )
                                            ),
                                   tabPanel("Šance vítězství",
                                            h3("Jaká je pravděpodobnost, že strana získá nejvíce hlasů?"),
                                            sidebarLayout(
                                              sidebarPanel(
                                                actionButton(inputId = "psp_victor_update", label = "Aktualizovat graf"),
                                                p(),
                                                radioButtons(inputId = "psp_victor_time",
                                                             label = "Časové období",
                                                             choices = list(
                                                               "Poslední tři měsíce" = Sys.Date()-90,
                                                               "Poslední rok" = Sys.Date()-365,
                                                               "Od posledních voleb" = as.Date("2013-10-26", format = "%Y-%m-%d")
                                                             ),
                                                             selected = Sys.Date()-365
                                                ),
                                                checkboxGroupInput(inputId = "psp_victor_parties",
                                                                   label = "Politické strany",
                                                                   choices = psp_parties_choices,
                                                                   selected = psp_parties_selected
                                                ),
                                                checkboxGroupInput(inputId = "psp_victor_features",
                                                                   label = "Zobrazení",
                                                                   choices = list(
                                                                     "80% interval spolehlivosti 4G modelu" = 1),
                                                                   selected = 1
                                                ),
                                                
                                                width = 3
                                              ),
                                              mainPanel(
                                                width = 9
                                              )
                                            )
                                            ),
                                   tabPanel("Šance vstupu do Sněmovny",
                                            h3("Jaká je pravděpodobnost, že se strana dostane do Sněmovny?"),
                                            sidebarLayout(
                                              sidebarPanel(
                                                actionButton(inputId = "psp_threshold_update", label = "Aktualizovat graf"),
                                                p(),
                                                radioButtons(inputId = "psp_threshold_time",
                                                             label = "Časové období",
                                                             choices = list(
                                                               "Poslední tři měsíce" = Sys.Date()-90,
                                                               "Poslední rok" = Sys.Date()-365,
                                                               "Od posledních voleb" = as.Date("2013-10-26", format = "%Y-%m-%d")
                                                             ),
                                                             selected = Sys.Date()-365
                                                ),
                                                checkboxGroupInput(inputId = "psp_threshold_parties",
                                                                   label = "Politické strany",
                                                                   choices = psp_parties_choices,
                                                                   selected = psp_parties_selected
                                                ),
                                                checkboxGroupInput(inputId = "psp_threshold_features",
                                                                   label = "Zobrazení",
                                                                   choices = list(
                                                                     "80% interval spolehlivosti 4G modelu" = 1),
                                                                   selected = 1
                                                ),
                                                
                                                width = 3
                                              ),
                                              mainPanel(
                                                width = 9
                                              )
                                            )
                                            )
                       )
              ),
              tabPanel("Prezidentské volby 2018",
                       tabsetPanel(type = "tabs", 
                                   tabPanel("Podíl hlasů",
                                            h3("Tato data Vám nabídneme po prvním průzkumu")
                                   ),
                                   tabPanel("Šance vítězství v 1. kole",
                                            h3("Tato data Vám nabídneme po prvním průzkumu")
                                   )
                       )
                       ),
              tabPanel("Metodologie a data",
                       includeMarkdown(("www/methodology.md")))
  )
)