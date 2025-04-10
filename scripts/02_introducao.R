# Prática 02 ------------------------------------------------------
#By: Izadora Carvalho

# Criando objetos ---------------------------------------------------------

# operador de atribuicao: <-  ou =   sendo o mais utilizado <-

temp <- 'temperatura'
# temp = 'precipitacao'
precip <- 'precipitacao'
t1 <- 30
t2 <- 35
t3 <- 27

#Remover objetos

remove(temp)

rm(precip)


#Verificar objetos criado
ls()

#Comando para limpar o ambiente de trabalho
remove(list = ls())


# Funcoes base ------------------------------------------------------------

#Funcoes base (ja instaladas)
mean(t1,t2,t3)
sum(t1, t2, t3)

# temp_med <- mean(t1,t2,t3)
# temp_sum <- sum(t1, t2, t3)

  #Obs: dados faltantes: NA (not avaible, nao disponivel)
sum(t1,t2,t3,NA)
sum(t1, t2, t3,NA, na.rm = TRUE)

min()
max()
range()
median()
var()
sd()
sqr()


# Buscando ajuda ----------------------------------------------------------

help(mean)
?sum


# Tipos de dados ----------------------------------------------------------

#texto (caractere)

estacao1 <- 'A205'

estacao2 <- 'A355'

Estacao2 <- 'B110'

est2
Est2

#númerico

temperatura1 <- 23

temperatura2 <- 28

temperatura3 <- 31

#lógico

frio <- 'FALSE'

calor <- 'TRUE'


# Estruturas de dados -----------------------------------------------------


#VETOR
vet1 <- c(30, 35, 27)
vet1
mean(vet1)

vet2 <- c('A205', 'A355', 'B110')
vet2

vet3 <- c(30, 'A205', 35)

#Verificando o tipo de dado
is.vector(vet1)
is.data.frame(vet1)
str(vet2)
class(vet1)

#Criando um vetor com o seq
vet4 <- seq(from=0, to=100, by=10)
vet4

seq1 <- seq(from=1, to = 9, by=1)

#MATRIZ (ou númerica ou caractere)

mtx <- matrix(
  data = seq1,
  nrow = 3,
  ncol = 3,
  byrow = F
)
mtx <- matrix(data = seq1, nrow = 3, ncol = 3, byrow = FALSE)
mtx
dim(mtx)
is.matrix(mtx)

#DATAFRAME (Tabela)

df <- data.frame(vet2, vet1)
df
View(df)

is.data.frame(df)

dim(df)
nrow(df)
ncol(df)

names(df)

str(df)
dplyr::glimpse(df)


# Manipulando dados -------------------------------------------------------

#acessando colunas (crtl + espaco)
df$vet1
df$vet2
mean(df$vet1)

#acessando linha ou/e coluna
#df[linha,coluna]
df[1,1]
df[1:2,]
df[, 2]
df[3,]
df[, 'vet1']
df[, c('vet2', 'vet1')]

#Dataframe que ja vem no R
airquality #qualidade do ar de Nova York
View(airquality)
#data() #para ver todos os banco de dados que podemos acessar

str(airquality)

head(airquality)
head(airquality, n=10)
tail(airquality)


# Exercicio ---------------------------------------------------------------

# Considerando o conjunto de dados 'airquality'
# 1. Calcular a media, maxima e minimo da variavel radiacao solar (Solar.R)
mean.R <- mean(airquality$Solar.R, na.rm = T)
mean.R

max.R <- max(airquality$Solar.R, na.rm = T)
max.R

min.R <- min(airquality$Solar.R, na.rm = T)
min.R

# 2. Selecionar apenas as colunas temperatura (Temp) e quantidade de ozonio (Ozone)
# utilizando o operador de indexasao [,]. Salve o resultado em um novo objeto: dados_sel
# oz_NY <- airquality[, 1]
# temp_NY <- airquality[, 4]
# dados_sel <- data.frame(oz_NY, temp_NY)
# dados_sel

dados_sel <- airquality[,c('Temp', 'Ozone')]
dados_sel
View(dados_sel)


# Instalando pacotes ------------------------------------------------------

install.packages("tidyverse")
install.packages("dados")
install.packages("openair")


# Carregando pacotes ------------------------------------------------------
library(tidyverse)
library(dados)
library(openair)
library(hexbin)

search()
tidyverse_packages()


getwd() #obter o caminho do diretorio
setwd() #mudar o caminho do diretorio

dat2004 <- selectByDate(mydata, year = 2004)
scatterPlot(dat2004, x = "nox", y = "no2")

# scatterPlot by year
scatterPlot(dat2004, x = "nox", y = "no2", type = "weekday", key =
              FALSE)
scatterPlot(mydata, x = "nox", y = "no2", type = "year", smooth =
              FALSE, linear = TRUE, avg.time = "day", log.x = TRUE, log.y = TRUE)
scatterPlot(mydata, x = "date", y = "no2", avg.time = "month",
            key = FALSE)
scatterPlot(mydata, x = "nox", y = "no2", z = "o3", type = c("season", "weekend"))

scatterPlot(mydata, x = "nox", y = "no2", method = "hexbin")
scatterPlot(mydata, x = "nox", y = "no2", type = "year", method =
              "hexbin")
