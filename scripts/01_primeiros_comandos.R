###############################################
# Prática 01
# By: Izadora Carvalho
###############################################


# Para saber a versao do R
version

# Para saber como citar (referenciar)
citation()

# Para citar pacotes
citation("ggplot")

# Para acessar ajuda (sobre um pacote, um comando)

help()

?base #outra forma de pesquisar (buscar informacao sobe um pacote ou comando) ? 
        #colocar o sinal '?' na frente do que se deseja pesquisar

# Para saber a pasta (diretorio) que estamos trabalhando
getwd()

# Para determinar ou alterar a pasta (diretorio) que estamos 
# trabalhando (QUANDO NÃO TRABALHAMOS COM PROJETOS - .Rproj)
setwd('D:/Cursos/curso_r/')

setwd('D:/Cursos/curso_r/Dia_01')


# Instalando pacotes
  #Instalar um único pacote
install.packages('ggplot')
  #Instalar varios pacotes de uma vezes
install.packages('tidyr', 'dplyr')

# Para carregar o pacote que sera utilizado

library('ggplot')  #esse ? o mais utilizado
require('dplyr')

#Atualizar pacotes
update.packages('dplyr')

#Atualizar TODOS os pacotes
update.packages(ask = FALSE)

objects()




