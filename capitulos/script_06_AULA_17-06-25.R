#=======================================================================#
#                 UNIVERSIDADE ESTADUAL DO MARANHÃO - UEMA              #
#           CENTRO DE EDUCAÇÃO, CIÊNCIAS EXATAS E NATURAIS - CECEN      #
#                          CURSO DE METEOROLOGIA                        #
#                            Aula 17/06/2024                            #
#=======================================================================#

#                      VISUALIZAÇÃO DE DADOS NO R                       #



# Carregando pacotes/bibliotecas ------------------------------------------

# install.packages("tidyverse")  #Para instalar descomente a linha
# install.packages("readr")  #Para instalar descomente a linha
# install.packages("patchwork")  #Para instalar descomente a linha


library(tidyverse)
library(readr)
library(patchwork)

# Carregando planilha -----------------------------------------------------

#caminho onde o arquivo dos dados está
Sao_Luis <- 'https://raw.githubusercontent.com/IzadoraSC/ebook-intro-computacao-meteorologia/refs/heads/main/dados/dados_82280_D_2024-01-01_2024-12-31.csv'
Imperatriz <- 'https://raw.githubusercontent.com/IzadoraSC/ebook-intro-computacao-meteorologia/refs/heads/main/dados/dados_82564_D_1991-01-01_2020-12-31.csv'


#carregando no R
dados <- read_delim(
  file = Sao_Luis,
  skip = 10,
  na = 'null',
  delim = ';',
  locale = locale(decimal_mark = ',')
) |> 
  select(!`...11`) |> 
  rename(
    "Data" = "Data Medicao",
    "Evap" = "EVAPORACAO DO PICHE, DIARIA(mm)",
    "Ins" = "INSOLACAO TOTAL, DIARIO(h)",
    "Prec" = "PRECIPITACAO TOTAL, DIARIO(mm)",
    "TempMax" = "TEMPERATURA MAXIMA, DIARIA(°C)",
    "TempMed" = "TEMPERATURA MEDIA COMPENSADA, DIARIA(°C)",
    "TempMin" = "TEMPERATURA MINIMA, DIARIA(°C)",
    "Umid" = "UMIDADE RELATIVA DO AR, MEDIA DIARIA(%)",
    "UmidMin" = "UMIDADE RELATIVA DO AR, MINIMA DIARIA(%)",
    "Vent" = "VENTO, VELOCIDADE MEDIA DIARIA(m/s)"
  ) |> 
  mutate(mes = month(Data, label = TRUE))

#Verificando tabela dos dados
str(dados)

glimpse(dados)

#Salvando dados
write.csv2(dados, 'dados/dados_slz_2024_org.csv')


#Lendo arquivo salvo
df <- read.csv2('dados/dados_slz_2024_org.csv')

# O `ggplot2` é um pacote de construção de gráficos pertencente ao `tidyverse`, 
# carregando uma filosofia de simplicidade e transparência nos códigos. O pacote 
# Opera em uma estrutura de camadas, onde cada elemento pode ser personalizado à vontade 
# do usuário. Assim, o pacote apresenta-se como uma ferramenta flexível capaz de 
# entender a diversas demandas. 

# As principais camadas do ‘ggplot2’ são:

# - Dados (data): Essa é uma camada fundamental, onde o usuário fornece os dados 
#   que deseja visualizar. Os dados são geralmente fornecidos como um dataframe do R.

# - Mapeamento Estético (Aesthetic Mapping): Nessa camada, o usuário associa variáveis 
#   do conjunto de dados às propriedades visuais do gráfico, como eixos, cor, forma, 
#   tamanho, etc. É importante destacar que o mapeamento pode operar em nível global,
#   afetando todas as camadas do gráfico, ou em nível local, afetando apenas uma camada. 

# - Geometria (Geometry): Essa camada determina o tipo de gráfico que se deseja criar, 
#   como pontos, linhas, barras, caixas, etc. Por exemplo, `geom_point()` cria um 
#   gráfico de pontos, `geom_col()` cria um gráfico de colunas, e assim por diante.

# - Escala (Scale): As escalas definem como os valores dos dados são mapeados para 
#   as propriedades visuais do gráfico. Por exemplo, pode-se ajustar a escala dos 
#   eixos x e y para se adaptar melhor aos dados.

# - Facetas (Facets): Essa camada é opcional e permite dividir o gráfico em várias 
#   facetas com base em uma ou mais variáveis. Isso é útil para comparar subgrupos 
#   de dados lado a lado.

# - Temas (Themes): Essa camada define o estilo geral do gráfico, incluindo aspectos 
#   como cores, fontes, tamanhos de texto, etc. O usuário pode utilizar os temas 
#   padrão fornecidos pelo `ggplot2`ou criar um tema personalizado.

# - Camadas Estatísticas (Statistical Layers): Em alguns casos, o usuário pode desejar 
#   adicionar camadas estatísticas aos gráficos, como linhas de regressão, intervalos 
#   de confiança, etc.

# Visualização (Gráficos) -------------------------------------------------


#Gáfico - Histograma

ggplot(data = dados) 

ggplot(data = dados, mapping = aes(x = TempMed))

ggplot(data = dados, mapping = aes(x = TempMed)) +
  geom_histogram()

ggplot(data = dados, mapping = aes(x = TempMed)) +
  geom_histogram(fill = "darkblue", color = "white")

ggplot(data = dados, mapping = aes(x = TempMed)) +
  geom_histogram(fill = "darkblue", 
                 color = "white", 
                 bins = 10)

ggplot(dados, aes(x = TempMed)) +
  geom_histogram(fill = "skyblue", 
                 color = "black", 
                 bins = 10) +
  labs(
    title = "Distribuição da Temperatura Média",
    x = "Temperatura Média (°C)",
    y = "Frequência"
  ) +
  theme_minimal()

#Gráfico - Pontos

ggplot(data = dados, 
       mapping = aes(x = TempMed, y = Prec)) +
  geom_point()

ggplot(data = dados, 
       mapping = aes(x = TempMed, y = Prec, color = mes)) +
  geom_point()

ggplot(data = dados, 
       mapping = aes(x = TempMed, y = Prec, color = mes)) +
  geom_point(shape = 18, size = 3) +
  scale_color_manual(values = c("red", "blue", "green", 
                                 "orange", "purple", "brown",
                                 "pink", "cyan", "darkgreen",
                                 "gold", "darkred", "gray"
                                ))


ggplot(data = dados, 
       mapping = aes(x = TempMed, y = Prec, color = mes)) +
  geom_point(shape = 18, size = 3) +
  scale_color_brewer(palette = 'Set1')
  # scale_colour_viridis_d(option = "A")

ggplot(
  data = dados,
  mapping = aes(x = TempMed, y = Evap)
) +
  geom_point()


ggplot(
  dados, aes(x = TempMed, y = Umid, color = mes)
)+
  geom_point() +
  geom_smooth(method = 'lm')


ggplot(dados, aes(x = TempMed, y = Umid, color = mes))+
  geom_point(alpha=0.05) +
  geom_smooth(method = 'lm')


#Boxplot ou Gráfico de Caixas
ggplot(dados, aes(x=mes, y=TempMed)) +
  geom_boxplot()

ggplot(dados, aes(x=mes, y=TempMed)) +
  geom_boxplot(fill = c("red", "blue", "green", 
                        "orange", "purple", "brown",
                        "pink", "cyan", "darkgreen",
                        "gold", "lightblue"),
               color = "black",
               outlier.colour = 'gray')


ggplot(dados, aes(x=mes, y=TempMed)) +
  geom_violin(fill='lightgray') 
  geom_boxplot(fill = 'steelblue')

ggplot(dados, aes(x = mes, y = TempMed, fill = mes)) +
  geom_boxplot() +
  labs(
      title = "Distribuição da Temperatura Média por Mês",
      x = "Mês",
      y = "Temperatura Média (°C)"
    ) +
  theme_minimal() +
  theme(legend.position = "none")
  

#Gráfico de barras

##precipitação
ggplot(dados, aes(x=mes, y=Prec))+
  stat_summary(geom = 'bar',
               fun = sum,
               fill = 'lightblue')
# temperatura
ggplot(tb_2, aes(x = mes, y = TempMed, fill = mes)) +
  geom_col() +
  labs(title = "Temperatura Média por Mês", x = "Mês", y = "Temperatura (°C)") +
  # scale_fill_brewer(palette = 'Spectral') +
  theme_minimal()

#Filtrando dados
dados |> 
  group_by(mes) |> 
  summarise(Media_Tmed = mean(TempMed, na.rm = T)) |> 
  View()

tb_2 <- dados |> 
  group_by(mes) |> 
  summarise(
    TempMed = mean(TempMed, na.rm = T),
    TempMin = mean(TempMin, na.rm = T),
    TempMax = mean(TempMax, na.rm = T)
  ) |> 
  slice(-12)

ggplot(tb_2, aes(x=mes, y=TempMed, fill=mes))+
    geom_col() +
  labs(
    title = "Temperatura Média por Mês",
    x = "Mês",
    y = "Temperatura Média (°C)"
  ) +
    scale_y_continuous(
      breaks = seq(from = 0, to = 30, by = 2)
    )

#Complete os dados faltantes para gerar o gráfico
ggplot() +
  geom_col() +
  labs() 
  # theme_bw() +
  # theme(legend.position = "none")


#Gráfico de Linhas

ggplot(tb_2) +
  geom_line(
    aes(x = mes, y = TempMed, group = 1),
    color = "steelblue", linewidth = 1) +
  geom_point(aes(x = mes, y = TempMed),
             size = 3,color = "steelblue") +
  labs(
    title = "Evolução da Temperatura Média ao Longo dos Meses",
    x = "Mês",
    y = "Temperatura Média (°C)"
  ) +
  theme_minimal()

#Gerar gráfico com temperaturas (MÉDIA, MÍNIMA E MÁXIMA)


#Gráfico de Densidade
g1 <- ggplot(dados, aes(x = Umid)) +
  geom_density(fill = "lightgreen", alpha = 0.5) +
  labs(
    title = "Densidade da Umidade Média",
    x = "Umidade Média (%)",
    y = "Densidade"
  )

#Temas
g1 + theme_minimal()    # Limpo
g1 + theme_classic()    # Clássico
g1 + theme_light()      # Claro com grades
g1 + theme_dark()       # Fundo escuro
g1 + theme_bw()         # Preto e branco


# library(ggthemes)
# library(ThemePark)

#Salvando gráfico

ggsave(plot = g1,
       filename = "Graf_Disp.png",
       device = "png",
       width = 1000,
       height = 1000,
       units = "px",
       bg = "white")

#Buscando nome te paletas de cores
colours()

  
# Referências -------------------------------------------------------------

# https://ggplot2-book.org
# https://r-graph-gallery.com/index.html
# https://www.data-to-viz.com