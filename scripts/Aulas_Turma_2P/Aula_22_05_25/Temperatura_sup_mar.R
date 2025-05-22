## Monitoramento da temperatura do mar

library(tidyverse)
library(lubridate)

#https://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/ONI_change.shtml
#https://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/ONI_v5.php


# Acessando os dados diretamente do site
url <- "https://origin.cpc.ncep.noaa.gov/products/analysis_monitoring/ensostuff/detrend.nino34.ascii.txt"
dados <- read_table(url, col_names = T)

# Ver os primeiros dados
head(dados)
tail(dados)

# Define períodos de 30 anos 
periodos <- list(
  "1936" = 1936:1965, "1941" = 1941:1970, "1946" = 1946:1975,
  "1951" = 1951:1980, "1956" = 1956:1985, "1961" = 1961:1990,
  "1966" = 1966:1995, "1971" = 1971:2000, "1976" = 1976:2005,
  "1981" = 1981:2010, "1986" = 1986:2015, "1991" = 1991:2020
)

# Loop para calcular médias e combinar tudo em um único dataframe
dados_periodos <- map_dfr(names(periodos), function(p) {
  dados %>%
    filter(YR %in% periodos[[p]]) %>%
    group_by(MON) %>%
    summarise(TOTAL = mean(TOTAL, na.rm = TRUE)) %>%
    mutate(Periodo = p)
})

# Definir linhas sólidas para períodos mais antigos, tracejadas para mais recentes
dados_periodos <- dados_periodos %>%
  mutate(linha = ifelse(as.numeric(Periodo) <= 1960, "solid", "dashed"),
         Periodo = as.factor(Periodo))

# Gráfico
ggplot(dados_periodos, aes(x = MON, y = TOTAL, group = Periodo, color = Periodo, linetype = linha)) +
  geom_line(size = 1.1) +
  scale_x_continuous(breaks = 1:12, labels = month.abb) +
  scale_linetype_manual(values = c("solid" = "solid", "dashed" = "dashed")) +
  labs(title = "Average SST in the Niño-3.4 Region (ERSST.v5) - 30yr base periods",
       x = "Month", y = "Sea Surface Temperatures (°C)") +
  theme_minimal() +
  theme(legend.title = element_blank())

# Em português

ggplot(dados_periodos, aes(x = MON, y = TOTAL, group = Periodo, color = Periodo, linetype = linha)) +
  geom_line(size = 1.1) +
  scale_x_continuous(breaks = 1:12, labels = c("Jan", "Fev", "Mar", "Abr", "Mai", "Jun", 
                                               "Jul", "Ago", "Set", "Out", "Nov", "Dez")) +
  scale_linetype_manual(values = c("solid" = "solid", "dashed" = "dashed")) +
  labs(
    title = "Temperatura Média da Superfície do Mar na Região Niño-3.4 (ERSST.v5) - Períodos base de 30 anos",
    x = "Mês",
    y = "Temperatura da Superfície do Mar (°C)"
  ) +
  theme_bw() +
  theme(
    legend.title = element_blank(),
    plot.title = element_text(size = 13, face = "bold")
  )

#Salvando gráfico
ggsave("temperatura_sm.png", width = 10, height = 6, dpi = 300)

