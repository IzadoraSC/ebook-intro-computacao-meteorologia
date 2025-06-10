# Bibliotecas ----
if (!require(tidyverse)) {
  install.packages("tidyverse", dependencies = TRUE)
  cat("Pacote Instalado com sucesso!")
} else {
  cat("Pacote já instalado. Carregando...")
  library(tidyverse)
}

loadedNamespaces()

# Baixar os dados ----
Belo_Horizonte <- 
  'https://raw.githubusercontent.com/PExCCA-UENF/Scripts-R-Cursos/main/Visualiza%C3%A7%C3%A3o%20de%20Dados%20no%20R/Dados/dados_83587_D_1991-01-01_2020-12-31.csv'

Vitoria <- 
  'https://raw.githubusercontent.com/PExCCA-UENF/Scripts-R-Cursos/main/Visualiza%C3%A7%C3%A3o%20de%20Dados%20no%20R/Dados/dados_83648_D_1991-01-01_2020-12-31.csv'

Rio_de_Janeiro <- 
  'https://raw.githubusercontent.com/PExCCA-UENF/Scripts-R-Cursos/main/Visualiza%C3%A7%C3%A3o%20de%20Dados%20no%20R/Dados/dados_83743_D_1991-01-01_2017-04-04.csv'

Sao_Paulo <- 
  'https://raw.githubusercontent.com/PExCCA-UENF/Scripts-R-Cursos/main/Visualiza%C3%A7%C3%A3o%20de%20Dados%20no%20R/Dados/dados_83781_D_1991-01-01_2020-12-31.csv'

# Criar pastas
if (!dir.exists("dados")){
  dir.create("dados")
  cat("Pasta criada com sucesso!")
}

# Lendo dados 
df_Belo_Horizonte <-
  read_csv2(
    file = Belo_Horizonte,
    na = "null",
    skip = 10
  )

df_Rio_de_Janeiro <-
  read_csv2(
    file = Rio_de_Janeiro,
    na = "null",
    skip = 10
  )

df_Sao_Paulo <-
  read_csv2(
    file = Sao_Paulo,
    na = "null",
    skip = 10
  )

df_Vitoria <-
  read_csv2(
    file = Vitoria,
    na = "null",
    skip = 10
  )

# Manipulação dos dados

dados <-
  bind_rows(
    df_Belo_Horizonte |> mutate(Nome = "Belo Horizonte"),
    df_Rio_de_Janeiro |> mutate(Nome = "Rio de Janeiro"),
    df_Sao_Paulo |> mutate(Nome = "São Paulo"),
    df_Vitoria |> mutate(Nome = "Vitória")
  ) |> 
  select(
    !`...7`
  ) |> 
  rename(
    "Data" = "Data Medicao",
    "Evap" = "EVAPORACAO DO PICHE, DIARIA(mm)",
    "Prec" = "PRECIPITACAO TOTAL, DIARIO(mm)",
    "Temp" = "TEMPERATURA MEDIA COMPENSADA, DIARIA(°C)",
    "Umid" = "UMIDADE RELATIVA DO AR, MEDIA DIARIA(%)",
    "Vent" = "VENTO, VELOCIDADE MEDIA DIARIA(m/s)",
    "Nome" = "Nome"
  )

str(dados)

# Salvando dados
getwd(
)

write_csv2(
  x = dados,
  file = 'dados/dados_organizados.csv'
)

#Visualização

# graphics::plot((1:10))

ggplot(
  data = dados,
  mapping = aes(x = Temp)  
  ) +
  geom_histogram(fill = 'darkblue', color = 'white')

ggplot(
  data = dados,
  mapping = aes(x = Temp, y = Prec)  
) +
  geom_point()

ggplot(
  data = dados,
  mapping = aes(x = Temp, y = Prec, color = Nome)  
) +
  geom_point()

tibble(
  x=1:5,
  y=1:5,
  z=1:5
) |> 
  ggplot(
    mapping = aes(x=x, y=y, stroke=z)
  )+
  geom_point(shape = 21, fill = 'blue', size = 6)

ggplot(
  data = dados,
  mapping = aes(x = Temp, y = Prec, 
                color = Nome, shape = Nome)) +
  geom_point()


ggplot(
  data = dados,
  mapping = aes(x = Temp, y = Prec, 
                color = Nome, shape = Nome)) +
  geom_point(shape = '☼', size = 10)

# plot(1:30, 1:30, pch = 1:30)


ggplot(
  dados, aes(x = Temp, y = Umid, color = Nome)
)+
  geom_point() +
  geom_smooth(method = 'lm')


ggplot(
  dados, aes(x = Temp, y = Umid, color = Nome)
)+
  geom_point(alpha=0.05) +
  geom_smooth(method = 'lm')
  # geom_rug() 

ggplot(dados, aes(x=Nome, y=Temp)) +
  geom_boxplot(fill = c("red", "blue", "yellow", "green"))

ggplot(dados, aes(x=Nome, y=Temp)) +
  geom_boxplot(fill = c("red", "blue", "yellow", "green"),
               color = "black",
               outlier.colour = 'gray')

ggplot(dados, aes(x=Nome, y=Temp)) +
    geom_violin(fill='lightgray') +
  geom_boxplot(fill = 'steelblue')
  


colours()

#Mapas
library(geobr)

br_biomas <- read_biomes()

ggplot(br_biomas, aes(fill = name_biome)) +
  geom_sf()

ggplot(br_biomas) +
  geom_sf(aes(fill = name_biome)) +
  geom_point(aes(x= -47.9333,
                 y=-15.7833),
             shape = '☼',
             size = 5
             ) +
  geom_text(
    aes(x= -47.9333,
        y=-15.7833,
        label = "Brasília")
  )



gr <- ggplot(
  data = dados,
  mapping = aes(x = Temp, y = Prec, color = Nome,
                shape= Nome)) +
  geom_point() +
  labs(
    title="Título",
    subtitle = 'Subtítulo',
    caption = 'Rodapé-Fonte',
    tag = "TAG",
    x = 'Eixo X',
    y = 'Eixo y',
    color = 'Legenda Cor',
    shape = "Legenda Formato"  #'Legenda Cor'
  ) +
  # scale_color_viridis_d(option = "A")
  scale_color_manual(values = c("red", 'green',
                                'yellow', 'blue')) +
  # facet_wrap(~Nome) +
  facet_grid(rows = vars(Nome)) +
  theme_bw()


remotes::install_github("MatthewBJane/ThemePark")
library(ThemePark)

gr + theme_barbie()

#######
# 5. PRODUÇÃO DE GRÁFICOS -----------------------------------------------------#

# Agora que já discutimos a base do ggplot, podemos avançar na produção de alguns gráficos.
# Nesta etapa do curso, preparamos alguns exemplos de gráficos utilizando funções do
# `ggplot2` e de outros pacotes.

# O pacote `camcorder` é utilizado para plotar os gráficos já em sua resolução final,
# assim facilitando o processo de ajuste fino dos elementos gráficos.

if (!require(camcorder)) install.packages("camcorder")
library(camcorder)

gg_record(
  dir = "plots",
  width = 1000,
  height = 1000,
  device = "png",
  units = "px",
  bg = "white")

# O pacote `showtext` permite importar facilmente fontes extras para utilizar nos gráficos.
# Podemos buscar as fontes em <fonts.google.com>.

if (!require(showtext)) install.packages("showtext")
library(showtext)

font_add_google(name = "Montserrat", family = "Montserrat")
showtext_auto()

# O pacote `ggtext` adiciona algumas funções interessantes para trabalhar com textos
# nos gráficos, seja internamente, como geometrias, ou nos rótulos dos gráficos.

if (!require(ggtext)) install.packages("ggtext")
library(ggtext)

# Utilizaremos o pacote `ggdist` para adicionar geometrias que trabalham com densidade.

if (!require(ggdist)) install.packages("ggdist")
library(ggdist)

# O pacote `ggside` nos permite criar gráficos marginais com pouco trabalho.

if (!require(ggside)) install.packages("ggside")
library(ggside)

# Histograma ---

# Iniciando um Histograma:
df |>
  ggplot(aes(x = Temp)) +
  geom_histogram()

# Vamos adicionar as cores de acordo com a Capital:
df |>
  ggplot(aes(x = Temp, fill = ID)) +
  geom_histogram()

# Agora, podemos quebrar em 4 gráficos com facet_grid():
df |>
  ggplot(aes(x = Temp, fill = ID)) +
  geom_histogram() +
  facet_grid(rows = vars(ID), axes = "all")

# Para aprimorar a ilustração, podemos adicionar um boxplot junto do histograma:
df |>
  ggplot(aes(x = Temp, fill = ID)) +
  geom_histogram() +
  geom_boxplot(aes(y = -100)) +
  facet_grid(rows = vars(ID), axes = "all")

# Vamos ajustar as cores e o tamanho de alguns elementos:
df |>
  ggplot(aes(x = Temp, fill = ID)) +
  geom_histogram(aes(x = Temp), color = "black", bins = 50) +
  geom_boxplot(aes(x = Temp, y = -100), width = 100, outlier.size = 0.5, color = "black") +
  scale_fill_viridis_d() +
  facet_grid(rows = vars(ID), axes = "all")

# Corrigindo nomes dos eixos e adicionando um título:
df |>
  ggplot(aes(x = Temp, fill = ID)) +
  geom_histogram(aes(x = Temp), color = "black", bins = 50) +
  geom_boxplot(aes(x = Temp, y = -100), width = 100, outlier.size = 0.5, color = "black") +
  scale_fill_viridis_d() +
  facet_grid(rows = vars(ID), axes = "all") +
  labs(
    title = "Distribuição das Temperaturas (°C) nas capitais do Sudeste de 1990 a 2020 ",
    x = "Temperatura (°C)",
    y = "Contagem",
    caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R")

# Alterações no tema:
df |>
  ggplot(aes(x = Temp, fill = ID)) +
  geom_histogram(aes(x = Temp), color = "black", bins = 50) +
  geom_boxplot(aes(x = Temp, y = -100), width = 100, outlier.size = 0.5, color = "black") +
  scale_fill_viridis_d() +
  facet_grid(rows = vars(ID), axes = "all") +
  labs(
    title = "Distribuição das Temperaturas (°C) nas capitais do Sudeste de 1990 a 2020 ",
    x = "Temperatura (°C)",
    y = "Contagem",
    caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R") +
  theme_void() +
  theme(
    text = element_text(family = "Montserrat", margin = margin(1,1,1,1,"mm")),
    axis.title = element_text(size = 18),
    axis.text = element_text(size = 14),
    axis.title.y = element_text(angle = 90),
    axis.ticks = element_line(),
    axis.ticks.length = unit(0.5, "mm"),
    axis.line = element_line(linewidth = 0.5),
    legend.position = "none",
    plot.margin = margin(2,2,2,2,"mm"),
    plot.title = element_textbox_simple(size = 25, lineheight = 0.3, margin = margin(1,1,1,1,"mm") ),
    plot.caption = element_text(size = 12),
    panel.background = element_rect(fill = "gray95"),
    panel.grid.major.y = element_line(color = "gray70", linetype = "dotted"),
    panel.border = element_blank(),
    strip.text = element_text(angle = 270, size = 12)
  ) -> Histograma

# Gráficos de dispersão ---

gg_record(dir = "plots", 
          width = 1000, 
          height = 1000, 
          device = "png", 
          bg = "white", 
          units = "px")

# Iniciando o gráfico de dispersão:
df |>
  filter(ID == "São Paulo") |>
  ggplot(aes(x = Temp, y = Umi)) +
  geom_point()

# Alterando aspectos visuais dos pontos:
df |>
  filter(ID == "São Paulo") |>
  ggplot(aes(x = Temp, y = Umi)) +
  geom_point(shape = 21, fill = rgb(1, 1, 1, 0.2),
             color = "steelblue2", stroke = 1, alpha = 0.7)

# Adicionando um geom_density_2d():
df |>
  filter(ID == "São Paulo") |>
  ggplot(aes(x = Temp, y = Umi)) +
  geom_point(shape = 21, fill = rgb(1,1,1,0.2),
             color = "steelblue2", stroke = 1, alpha = 0.7) +
  geom_density_2d(color = "steelblue4", linewidth = 0.6)

# Adicionando boxplots marginais:
df |>
  filter(ID == "São Paulo") |>
  ggplot(aes(x = Temp, y = Umi)) +
  geom_point(shape = 21, fill = rgb(1,1,1,0.2),
             color = "steelblue2", stroke = 1, alpha = 0.7) +
  geom_density_2d(color = "steelblue4", linewidth = 0.6) +
  geom_xsideboxplot(orientation = "y", color = "steelblue2") +
  geom_ysideboxplot(orientation = "x", color = "steelblue2")

# Alterações de tema e rótulos:
df |>
  filter(ID == "São Paulo") |>
  ggplot(aes(x = Temp, y = Umi)) +
  geom_point(shape = 21, fill = rgb(1,1,1,0.2),
             color = "steelblue2", stroke = 1, alpha = 0.7) +
  geom_density_2d(color = "steelblue4", linewidth = 0.6) +
  geom_xsideboxplot(orientation = "y", color = "steelblue2") +
  geom_ysideboxplot(orientation = "x", color = "steelblue2") +
  labs(
    x = "Temperatura(°C)",
    y = "Umidade Relativa(%)",
    title = "Relação Entre Temperatura e Umidade Relativa em São Paulo-SP",
    caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "Montserrat", size = 25),
    plot.title = element_textbox_simple(lineheight = 0.4, margin = margin(2,2,2,2,"mm")),
    plot.margin = margin(4,4,4,4, "mm"),
    ggside.axis.text = element_blank(),
    ggside.panel.grid = element_blank()
  ) -> Dispersao

# Gráficos de Série Temporal ---

gg_record(dir = "plots", 
          width = 2000, 
          height = 800, 
          device = "png", 
          bg = "white", 
          units = "px")

# Calculando médias mensais de Temperatura das cidades de interesse:
df_gr <-
  df |>
  filter(ID %in% c("Vitória", "Belo Horizonte")) |>
  group_by(Mês = month(Data), Ano = year(Data), ID) |>
  summarise(me = mean(Temp),
            sd = sd(Temp)) |>
  mutate(Data = ym(paste(Ano, Mês, sep = "-")))

# Iniciando o gráfico:
df_gr |>
  ggplot(
    aes(x = Data, y = me, color = ID)
  ) +
  geom_line() +
  geom_point()

# Alterando aspectos visuais dos pontos e escalas:
df_gr |>
  ggplot(
    mapping = aes(x = Data, y = me, color = ID)
  ) +
  geom_line(lwd = 1.1, alpha = 0.5) +
  geom_point(size = 1.5, alpha = 0.5) +
  scale_y_continuous(limits = c(17, 30), breaks = seq(16,30,2)) +
  scale_x_date(breaks = "5 years", date_labels = "%Y") +
  scale_color_manual(values = c("#ed2024", "#023a99"))

# Adicionando título e rótulo de eixos:
# Aqui utilizaremos uma tag HTML para utilizar o título como legenda do gráfico.
df_gr |>
  ggplot(
    mapping = aes(x = Data, y = me, color = ID)
  ) +
  geom_line(lwd = 1.1, alpha = 0.5) +
  geom_point(size = 1.5, alpha = 0.5) +
  scale_y_continuous(limits = c(17, 30), breaks = seq(16,30,2)) +
  scale_x_date(breaks = "5 years", date_labels = "%Y") +
  scale_color_manual(values = c("#ed2024", "#023a99")) +
  labs(x = "Data", y = "Temperatura (°C)",
       title = "Médias Mensais de Temperatura(°C) nas capitais <span style = color:#023a99>Vitória-ES</span> e <span style = color:#ed2024>Belo Horizonte-MG</span>",
       caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R", color = "")

# Adicionando tema:
df_gr |>
  ggplot(
    mapping = aes(x = Data, y = me, color = ID)
  ) +
  geom_line(lwd = 1.1, alpha = 0.5) +
  geom_point(size = 1.5, alpha = 0.5) +
  scale_y_continuous(limits = c(17, 30), breaks = seq(16,30,2)) +
  scale_x_date(breaks = "5 years", date_labels = "%Y") +
  scale_color_manual(values = c("#ed2024", "#023a99")) +
  labs(x = "Data", y = "Temperatura (°C)",
       title = "Médias Mensais de Temperatura(°C) nas capitais <span style = color:#023a99>Vitória-ES</span> e <span style = color:#ed2024>Belo Horizonte-MG</span>",
       caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R", color = "") +
  theme_minimal() +
  theme(
    text = element_text(family = "Montserrat", size = 30),
    legend.position = "none",
    plot.title = element_textbox_simple(lineheight = 0.3, size = 40, maxwidth = 0.8, hjust = 0),
    plot.margin = margin(5,5,5,5, "mm")
  ) -> SerieTemporal

# Boxplot ---

gg_record(dir = "plots", 
          width = 2000, 
          height = 800, 
          device = "png", 
          bg = "white", 
          units = "px")

# Iniciando o gráfico:
df |>
  mutate(Ano = year(Data)) |>
  ggplot(aes(y = Temp, x = Ano, fill = ID)) +
  geom_boxplot()

# Para aprimorar a visualização, podemos adicionar outros elementos, como os próprios 
# pontos ilustrados e uma curva de distribuição.
df |>
  ggplot(aes(y = Temp, x = ID, fill = ID)) +
  geom_boxplot(width = 0.2) +
  geom_point(shape = 95, size = 20, alpha = 0.006,
             position = position_nudge(x = -0.20)) +
  stat_halfeye(
    adjust = 0.9,
    width = .4,
    color = NA,
    position = position_nudge(x = .14)
  )

# Ajustes de cores:
df |>
  ggplot(aes(y = Temp, x = ID, fill = ID)) +
  geom_boxplot(width = 0.2) +
  geom_point(shape = 95, size = 20, alpha = 0.006,
             position = position_nudge(x = -0.20)) +
  stat_halfeye(
    adjust = 0.9,
    width = .4,
    color = NA,
    position = position_nudge(x = .14)
  ) +
  scale_fill_viridis_d()

# Adicionando legendas:
df |>
  ggplot(aes(y = Temp, x = ID, fill = ID)) +
  geom_boxplot(width = 0.2) +
  geom_point(shape = 95, size = 20, alpha = 0.006,
             position = position_nudge(x = -0.20)) +
  stat_halfeye(
    adjust = 0.9,
    width = .4,
    color = NA,
    position = position_nudge(x = .14)
  ) +
  scale_fill_viridis_d() +
  labs(
    x = "Capitais", y = "Temperatura (°C)",
    title = "Distribuição de Temperaturas nas Capitais do Sudeste",
    subtitle = "Intervalo 1991 a 2020",
    caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R"
  )

# Alterando tema:
df |>
  ggplot(aes(y = Temp, x = ID, fill = ID)) +
  geom_boxplot(width = 0.2) +
  geom_point(shape = 95, size = 20, alpha = 0.006,
             position = position_nudge(x = -0.20)) +
  stat_halfeye(
    adjust = 0.9,
    width = .4,
    color = NA,
    position = position_nudge(x = .14)
  ) +
  scale_fill_viridis_d() +
  labs(
    x = "Capitais", y = "Temperatura (°C)",
    title = "Distribuição de Temperaturas nas Capitais do Sudeste",
    subtitle = "Período de 1991 a 2020",
    caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "Montserrat", size = 30),
    plot.caption = element_text(color = "gray40"),
    legend.position = "none"
  ) -> Boxplot

# Gráfico de Barras ---

gg_record(dir = "plots",
          width = 1200, 
          height = 1000, 
          device = "png", 
          bg = "white", 
          units = "px")

# Cálculo de precipitação acumulada anual em cada capital:
df_gr <-
  df |>
  group_by(Ano = year(Data), ID) |>
  summarise(
    Prec_Acc = sum(Prec)
  ) |>
  filter(ID != "Rio de Janeiro")

# Vamos quebrar o gráfico em facets:
df_gr |>
  ggplot(aes(x = Ano, y = Prec_Acc, fill = ID)) +
  geom_col() +
  facet_grid(rows = vars(ID), axes = "all")

# Agora, podemos adicionar o valor de precipitação calculado:
df_gr |>
  ggplot(aes(x = Ano, y = Prec_Acc, fill = ID)) +
  geom_col() +
  geom_text(
    aes(label = paste(round(Prec_Acc), "mm"), family = "Montserrat"),
    nudge_y = -390, angle = 90, size = 4.5) +
  facet_grid(rows = vars(ID), axes = "all")

# Vamos alterar as cores e as quebras na escala do Ano
df_gr |>
  ggplot(aes(x = Ano, y = Prec_Acc, fill = ID)) +
  geom_col() +
  geom_text(
    aes(label = paste(round(Prec_Acc), "mm"), family = "Montserrat"),
    nudge_y = -450, angle = 90, size = 5) +
  facet_grid(rows = vars(ID), axes = "all") +
  scale_x_continuous(breaks = seq(1991, 2020, 2)) +
  scale_fill_brewer(type = "qual")

# O próximo passo é inserir rótulos e alterações estéticas do tema:
df_gr |>
  ggplot(aes(x = Ano, y = Prec_Acc, fill = ID)) +
  geom_col() +
  geom_text(
    aes(label = paste(round(Prec_Acc), "mm"), family = "Montserrat"),
    nudge_y = -490, angle = 270, size = 5) +
  facet_grid(rows = vars(ID)) +
  scale_x_continuous(breaks = seq(1991, 2020, 3)) +
  scale_fill_brewer(type = "qual") +
  labs(x = "Ano", y = "Precipitação Acumulada (mm)", title = "Precipitação Anual Acumulada em Capitais do Sudeste",
       caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R") +
  theme_light() +
  theme(
    legend.position = "none",
    text = element_text(family = "Montserrat", size = 25),
    plot.title = element_textbox_simple(lineheight = 0.3, size = 30, margin = margin(2,0,2,0, "mm")),# maxwidth = 0.8, hjust = 0),
  ) -> Barras

# Heatmap ---

gg_record(dir = "plots", 
          width = 1000, 
          height = 1000, 
          device = "png", 
          bg = "white", 
          units = "px")

# Calculando médias mensais de Temperatura:
df_gr <-
  df |>
  filter(ID == "Vitória") |>
  group_by(Ano = year(Data), Mês = month(Data)) |>
  summarise(
    me = mean(Temp)
  )

# Iniciando o gráfico:
df_gr |>
  ggplot(aes(x = Mês, y = Ano, fill = me)) +
  geom_tile()

# Vamos alterar a escala de cores:
df_gr |>
  ggplot(aes(x = Mês, y = Ano, fill = me)) +
  geom_tile() +
  scale_fill_viridis_c(option = "turbo")

# Aplicando alterações estéticas no geom_tile() e adicionando geom_text().
# Para escrever a temperatura e o símbolo °, utilizaremos a função paste0(). Contudo, 
# caso a temperatura informada seja "NA", a função escreverá "NA°". Para evitar isso, 
# utilizaremos um case_when() para criar uma nova coluna contendo o que será passado à geom_text().

df_gr |>
  mutate(lab = case_when(
    !is.na(me) ~ paste0(round(me, 1), "°")
  )) |>
  ggplot(aes(x = Mês, y = Ano, fill = me)) +
  geom_tile(color = "white", linewidth = 0.5) +
  geom_text(aes(label = lab, family = "Montserrat", fontface = "bold"), size = 4.5, color = "gray95") +
  scale_fill_viridis_c(option = "turbo")

# Agora, devemos inverter a escala de y para que 2020 fique no final do gráfico.
df_gr |>
  mutate(lab = case_when(
    !is.na(me) ~ paste0(round(me, 1), "°")
  )) |>
  ggplot(aes(x = Mês, y = Ano, fill = me)) +
  geom_tile(color = "white", linewidth = 0.5) +
  geom_text(aes(label = lab, family = "Montserrat", fontface = "bold"), size = 4.5, color = "gray95") +
  scale_fill_viridis_c(option = "turbo") +
  scale_y_continuous(transform = "reverse", breaks = seq(1991, 2020, 3)) +
  scale_x_continuous(breaks = 1:12,
                     labels = month(1:12, label = T))

# Agora, vamos adicionar rótulos e alterar aspéctos do tema:
df_gr |>
  mutate(lab = case_when(
    !is.na(me) ~ paste0(round(me, 1), "°")
  )) |>
  ggplot(aes(x = Mês, y = Ano, fill = me)) +
  geom_tile(color = "white", linewidth = 0.5) +
  geom_text(aes(label = lab, family = "Montserrat", fontface = "bold"), size = 4.5, color = "gray95") +
  scale_fill_viridis_c(option = "turbo", breaks = seq(22, 30, 2), label = ~paste0(.x, "°")) +
  scale_y_continuous(transform = "reverse", breaks = seq(1991, 2020, 3)) +
  scale_x_continuous(breaks = 1:12,
                     labels = month(1:12, label = T)) +
  labs(x = "Mêses", y = "Ano", caption = "Fonte dos dados: INMET • Elaborado por @Proamb.R",
       title = "Temperaturas Médias Mensais em Vitória-ES",
       fill = "Temperatura (°C)") +
  theme_minimal() +
  theme(
    text = element_text(family = "Montserrat", size = 15),
    panel.grid.minor = element_blank(),
    legend.margin = margin(0,0,0,0,"mm"),
    legend.position = "bottom",
    legend.key.size = unit(3, "mm"),
    legend.key.height = unit(1, "mm"),
    legend.title.position = "top",
  ) -> Heatmap

# Exportando Gráficos ---
# A função `ggsave()` permite salvar gráficos criados em arquivos externos em
# diversos formatos, como PNG, JPEG, PDF, SVG e outros.

# Alguns argumentos da função `ggsave()`:
# plot:           O gráfico que será salvo. Por padrão, vai salvar o último gráfico plotado.
# filename:       O nome do arquivo/gráfico que será salvo, com a extensão (ex: .png).
# width e height: Largura e altura do gráfico em unidades especificadas pelo argumento units.
# units:          Unidades para largura e altura do gráfico, que podem ser:
#                 'in' (polegadas), 'cm' (centímetros), 'mm' (milímetros) e 'px' (pixels).

# Salvando os gráficos:
ggsave(
  plot = Histograma,
  filename = "GrHistograma.png",
  device = "png",
  width = 1000,
  height = 1000,
  units = "px",
  bg = "white"
)
ggsave(
  plot = Dispersao,
  filename = "GrDispersao.png",
  device = "png",
  width = 1000,
  height = 1000,
  units = "px",
  bg = "white"
)
ggsave(
  plot = Barras,
  filename = "GrBarras.png",
  device = "png",
  width = 1200,
  height = 1000,
  units = "px",
  bg = "white"
)
ggsave(
  plot = SerieTemporal,
  filename = "GrSerieTemporal.png",
  device = "png",
  width = 2000,
  height = 800,
  units = "px",
  bg = "white"
)
ggsave(
  plot = Heatmap,
  filename = "GrHeatmap.png",
  device = "png",
  width = 1000,
  height = 1000,
  units = "px",
  bg = "white"
)
ggsave(
  plot = Boxplot,
  filename = "GrBoxplot.png",
  device = "png",
  width = 2000,
  height = 800,
  units = "px",
  bg = "white"
)

# Referências# Referênciayear = # Referências# ReferênciasTemp
# https://ggplot2-book.org
# https://r-graph-gallery.com/index.html