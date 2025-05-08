## Código 02
## Autora: Izador S. de Carvalho



# Criação de vetores -----------------------------------------------------------------

temperatura <- c(23, 26, 27, 30)

#Visualizando
temperatura

#Verificando a classe dos dados do vetor
class(temperatura)

#Acessando um valor do vetor
temperatura[5]

sensacoes <- c("Frio", "Agradável", "Quente", "Muito Quente", "Extremo")

sensacoes

#Verificando o tamanho do vetor
length(sensacoes)

class(sensacoes)

sensacoes[4]

#
v1 <- c("Frio", 20, "Quente", 35)

class(v1)

v1





#### Aplicando funções base do R 
      #   (sum, mean, min, max)

temperatura <- c(23, 26, 27, 30)

mean(temperatura)
min(temperatura)
max(temperatura)

temperatura_max <- max(temperatura)
temperatura_max

#Arredondando valores
mean(temperatura)
round(mean(temperatura), 0)
round(35.853, 2)

