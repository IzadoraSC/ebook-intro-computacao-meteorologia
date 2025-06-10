#Trabalhando com Vetores

#Criando vetores

temperaturas <- c(25.2, 26.1, 27.0, 26.8)
temperaturas

class(temperaturas)

temp_1 <- c(25.2, 26.1, '27.0')
class(temp_1)

#extraindo a média
mean(temperaturas)

length(temperaturas)

min(temperaturas)


round(mean(temperaturas))


round(mean(temperaturas), 2)



#Acessando valores com base na localização dentro do vetor
temperaturas[1]
temperaturas[4]
temperaturas[5]

#Criando o vetor
sensacoes <- c("Frio", "Agradável", 
               "Quente", "Muito Quente",
               "Extremo")
#Visualizando
sensacoes


##
chuvas <- c('30 mm', '5 mm', '10 mm')

chuvas <- c(30, 5, 10, 0, 7, 11, 10)
length(chuvas) #Conferindo quantos dados
                #tem o vetor
max(chuvas) #Valor máximo

###3
media_chuva <- mean(chuvas)
media_chuva
print(media_chuva)
round(media_chuva, 2)
####

round(mean(chuvas), 2)













## Data Frame - Tabelas

dados <- data.frame(dia = 1:4, 
                    temperatura = c(25.2, 26.1, 27.0, 26.8))
View(dados)

dados$dia

class(dados$dia)
class(dados$temperatura)


tab_2 <- data.frame(
  data = as.Date('2025-01-01') + 0:6,
  temperatura = c(27.5, 28.2, 26.9, 29.1, 30.0, 28.4, 27.8)
)

View(tab_2)

head(tab_2, 4)
tail(tab_2)


str(tab_2)

class(tab_2$data)

summary(tab_2$temperatura)


#Gerando
plot(y=tab_2$temperatura,x=tab_2$data,
     type = 'o', col = 'darkblue')



#### Acessando tabelas de dados já 
##   disponível no R

airquality

head(airquality)
str(airquality)


.

co2

nhtemp
head(nhtemp)

tb_precip <- as.data.frame(precip)
View(tb_precip)
tb_precip2 <- precip

tb_precip2

View(tb_precip)



# banco de dados em português
install.packages('dados')

library(dados)

head(clima)
str(clima)
