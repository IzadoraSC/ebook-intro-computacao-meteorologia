library(ggplot2)
library(dplyr)

dados_clima <- data.frame(
  Mes = factor(c("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
                 "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"),
               levels = c("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
                          "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro")),
  Temperatura = c(28.5, 28.2, 27.8, 27.0, 26.0, 25.5, 25.3, 26.2, 27.0, 27.5, 28.0, 28.4),
  Precipitacao = c(220, 210, 240, 180, 90, 40, 30, 5, 10, 10, 10, 60)
)

# Visualizar
print(dados_clima)
str(dados_clima)

dados_clima |> 
  ggplot(aes(x=Mes, y=Precipitacao)) +
  geom_bar(aes(x=Mes, y=Precipitacao), fill='darkblue',
           stat="identity")

dados_clima |> 
  ggplot(aes(x=Mes, y=Temperatura)) +
  geom_line(aes(x=Mes, y=Temperatura), colour='red',
            stat="identity", group = 1)

dados_clima |> 
  ggplot(aes(x=Mes, y=Precipitacao)) +
  geom_bar(aes(x=Mes, y=Precipitacao, fill = "Precipitacao"),
           stat="identity") +
  geom_line(aes(x=Mes, y=Temperatura*10, colour = "Temperatura"),
            stat = 'identity', group = 1) +
  geom_point(aes(x=Mes, y=Temperatura*10, colour = "Temperatura"),
             colour = 'darkred') +
  scale_y_continuous(
    'Precipitação \nAcumulada (mm)',
    limits = c(0,300),
    n.breaks = 10,
    expand = c(0,0),
    sec.axis = sec_axis(
      breaks = c(0,5,10,15,20,25,30),
      ~./10, name = "Temperatura do Ar (°C)", guide = )) +
  labs(x = 'Meses', title = "Precipitação e Temperatura Mensal") +
  theme_light() +
  theme(
    axis.title = element_text(size = 16, colour = 'black', face = 'bold'), #titulo dos eixos
    axis.title.y.right = element_text(angle = 90),
    axis.text.x = element_text(angle = 40, hjust = 1), #texto/números do eixo x
    axis.text = element_text(size = 14, colour = 'black'), # texto/números do eixo y
    text = element_text(family = 'Times New Roman'),
    title = element_text(size = 16, face = 'bold'),
    legend.position = 'top',
    legend.title = element_blank(),
    legend.text = element_text(size = 12, colour = 'black')
  ) +
  scale_fill_manual(
    labels = "Precipitação",
    values = 'darkblue') + #mudar cor das barras
  scale_colour_manual(
    labels = "Temperatura",
    values = 'orange') #mudar cor da linha
