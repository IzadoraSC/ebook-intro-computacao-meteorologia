## Código 03
## Autora: Izadora S. de Carvalho

# Criando tabela (Data frames)
tabela_1 <- data.frame(
  data = as.Date("2024-01-01") + 0:6,
  temperatura = c(27.5, 28.2, 26.9, 29.1,
                  30.0, 28.4, 27.8)
)

tabela_1

View(tabela_1)








tabela_2 <- data.frame(
  dia = 1:4,
  chuva = c(30, 40, 32, 5))

View(tabela_2)

#Gerando gráfico.

plot(tabela_1$data, 
     tabela_1$temperatura, type= "o", col ="blue")





