#Script Prática 01
#Autor(a): Izadora S. De C.


# Criação de objetos ------------------------------------------------------

nome <- "Izadora"
idade <- 32
temperatura <- 28.5
chuva <- TRUE

chuva <- FALSE

estacao <- 'A230'

# Tipo de cada objeto
class(nome)
class(estacao)
class(idade)
class(temperatura)
class(chuva)

#Apagando objetos
remove(estacao)
rm(idade)

# Verificar lista dos objetos criados
ls()

## Pacotes
#Instalando pacotes

install.packages("tidyverse")

install.packages("readxl")

install.packages("writexl")
install.packages('dados')
install.packages("opneair")

install.packages(c("tidyverse","readxl", "writexl"))

###carregando pagotes
library(readxl)
library(tidyverse)
require(dplyr)

#Verificando pacotes carregando
search()

#Verificando funções do pacote
ls("package:readxl")

??readxl
  
