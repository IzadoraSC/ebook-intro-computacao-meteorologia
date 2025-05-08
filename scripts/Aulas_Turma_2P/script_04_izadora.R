## Código 04
## Autora: Izadora S. de Carvalho

# Criando tabela (Data frames) (CONTINUAÇÃO)

dados <- data.frame(
  data = as.Date("2025-03-24") + 0:4,
  temperatura_min = c(22.1, 21.8, 22.4, 23.0, 21.5),
  temperatura_max = c(30.2, 29.8, 31.0, 30.5, 29.7),
  precipitacao = c(0.0, 5.2, 1.0, 0.0, 3.1)
)

#Visualização

print(dados)
View(dados)

#Acessando dados do data frame e realizando operações

media_5D <- mean(dados$temperatura_min)

###
head(dados, 2) #Visualizando as primeiras 2 linhas da tabela
tail(dados, 2)  #Visualizando as últimas 2 linhas da tabela

str(dados) #Visualizando o tipo de dado de cada variável

### Criando uma nova coluna
dados$estado <- "MA"
View(dados)


# Criando Lista -----------------------------------------------------------

estacao <- list(
  nome = "Estação Chapada das Mesas",
  codigo = "MA123",
  localizacao = c(latitude = -7.3, longitude = -46.0),
  temperaturas = c(28.5, 29.1, 27.8, 30.2),  # em °C
  precipitacoes = c(2.4, 0.0, 1.1, 5.6),     # em mm
  status = TRUE
)

estacao$nome
View(estacao)

str(estacao)







# Criando Matrizes --------------------------------------------------------

mt_temperatura <- matrix(
  c(22.1, 24.3, 25.5, 23.0,   # Dia 1
    21.8, 23.5, 26.2, 24.1,   # Dia 2
    20.0, 22.4, 24.0, 23.3),  # Dia 3
  nrow = 3,
  ncol = 4,
  byrow = TRUE
)

mt_temperatura

dim(mt_temperatura)
length(mt_temperatura)

#Acessando dados da Matrix
mt_temperatura[1,1] # [linha, coluna]
mt_temperatura[2,3]

mean(mt_temperatura[3, ])
rowMeans(mt_temperatura)

