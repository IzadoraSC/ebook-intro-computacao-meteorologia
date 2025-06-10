# Primeiros passos no R - Parte 2
# Autora: Izadora S. De.

# Instalando Pacotes

install.packages('ggplot2') #para geração de gráficos
install.packages('tidyverse')

install.packages('dados') #pacotes para dados em português

library(dados)


#Dados em inglês
data()

tb_1 <- airquality
View(tb_1)

#Dados em português
#Carregando pacote
library(dados)

dados::clima #conferindo dados da tabela clima

tb_2 <- clima

# Outra função para carregar pacotes
require(ggplot2) #mesma finalidade do 'library'