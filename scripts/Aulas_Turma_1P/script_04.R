# Aula: Manipulação e Visuzalição Dados
# Autor(a): Izadora S. de Carvalho
# Data: 10/06/2025

# Carregando pacotes ------------------------------------------------------

# install.packages('tidyverse')
library(tidyverse)
library(dplyr)
library(ggplot2) #pacote para construção de gráficos
library(readr) #pacote para ler arquivos .cvs
library(readxl) #pacote para ler arquivos excel (.xls, .xlsx)

# Acessando Dados ---------------------------------------------------------

dados <- read_excel('dados/TMAX_INMET.xlsx')
# dados <- read_excel('TMAX_INMET.xlsx')
# dados <- read_excel("C:/Users/Izadora/Documents/projeto_1p/dados/TMAX_INMET.xlsx")


head(TMAX_INMET)

# Explorando e Organizando os dados ------------------------------------------------------

head(dados)

dim(dados)

str(dados)

View(dados)

#Explorando os dados
names(dados) 
colnames(dados)

any(is.na(dados))

#Removendo valores faltantes
dados_limpos <- drop_na(dados)
dim(dados_limpos)


# Renomeando coluna

colnames(dados)

TMAX_INMET <- dados |>  
  rename(
    Cod = `Código`,
    Estacao = `Nome da Estação`,
    Jan = Janeiro,
    Fev = Fevereiro,
    Mar = Março,
    Abr = Abril,
    Mai = Maio,
    Jun = Junho,
    Jul = Julho,
    Ago = Agosto,
    Set = Setembro,
    Out = Outubro,
    Nov = Novembro,
    Dez = Dezembro
  )

head(TMAX_INMET)

# Pivotando 

TMAX_longer <- 
  TMAX_INMET |> 
  mutate(Ano = NULL) |> 
  pivot_longer(
    cols = Jan:Dez,      
    names_to = 'Meses',  
    values_to = 'Tmax'
  )


head(TMAX_longer)

TMAX_MA <- TMAX_longer |> 
  filter(UF == 'MA')

ggplot(data = TMAX_MA) +
  geom_point(aes(x = Meses, y = Tmax, color = Meses),
             shape = 18, size = 3) +
  theme_bw()


#organizando cores
paleta_cor <- colorRampPalette(c('blue', 'goldenrod', 'red'))

#Organizando ordem dos meses

TMAX_MA <-
  TMAX_MA |>
  mutate(Meses = factor(Meses,
                        levels = c('Jan', 'Fev', 'Mar', 'Abr', 'Mai',
                                   'Jun','Jul', 'Ago', 'Set', 'Out',
                                   'Nov', 'Dez')))

g1 <- ggplot(data = TMAX_MA) +
  geom_point(aes(x = Meses, y = Tmax, color = Meses),
             shape = 18, size = 3) +
  # scale_color_brewer(palette='Set1') +
  # scale_color_viridis_d() +
  scale_color_manual(values=paleta_cor(12)) +
  theme_bw()

g1
