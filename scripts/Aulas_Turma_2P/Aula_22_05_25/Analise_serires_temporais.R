#artigo "Preenchimento de falhas em séries de dados meteorológicos de estações automáticas"
#https://ojs.ufgd.edu.br/rbclima/article/view/17599


# 1. Simulação e Preenchimento de Falhas em Dados Meteorológicos ----------



# Instalar pacotes necessários
# if (!require("imputeTS")) install.packages("imputeTS")
library(devtools)
install_github("SteffenMoritz/imputeTS")


# Carregar pacotes
library(imputeTS)
library(ggplot2)

# Gerar série temporal sintética
set.seed(123)
data <- ts(rnorm(100, mean = 25, sd = 3), start = c(2022, 1), frequency = 12) # Exemplo: temperatura

# Simular falhas (10% faltantes)
missing_indices <- sample(1:100, size = 10)
data_with_na <- data
data_with_na[missing_indices] <- NA

# Preenchimento dos valores faltantes com diferentes métodos
interp_filled <- na_interpolation(data_with_na)        # Interpolação
mean_filled <- na_mean(data_with_na)            # Média
seadec_filled <- na_seadec(data_with_na)        # Decomposição sazonal

# Comparar métodos graficamente
df <- data.frame(
  Time = time(data),
  Original = as.numeric(data),
  WithNA = as.numeric(data_with_na),
  Interpolation = as.numeric(interp_filled),
  Mean = as.numeric(mean_filled),
  SeasonalDecomposition = as.numeric(seadec_filled)
)

ggplot(df, aes(x = Time)) +
  geom_line(aes(y = Original, color = "Original"), size = 1) +
  geom_point(aes(y = WithNA, color = "Com Falhas"), size = 2) +
  geom_line(aes(y = Interpolation, color = "Interpolação"), linetype = "dashed") +
  geom_line(aes(y = Mean, color = "Média")) +
  geom_line(aes(y = SeasonalDecomposition, color = "Decomposição Sazonal")) +
  labs(y = "Valores", color = "Método") +
  theme_minimal()


# 2. Análise da Sazonalidade e Impacto no Preenchimento -------------------

# Dados sintéticos com sazonalidade
set.seed(456)
seasonal_data <- ts(25 + 5 * sin(2 * pi * time(data)) + rnorm(100, 0, 2),
                    start = c(2022, 1), frequency = 12)

# Simular falhas (10% nos meses secos)
dry_months <- c(6, 7, 8, 9) # Meses secos
missing_indices_dry <- which(cycle(seasonal_data) %in% dry_months)[1:10]
data_with_na_dry <- seasonal_data
data_with_na_dry[missing_indices_dry] <- NA

# Preencher com diferentes métodos
interp_dry <- na_interpolation(data_with_na_dry)
seadec_dry <- na_seadec(data_with_na_dry)

# Comparar graficamente
df_seasonal <- data.frame(
  Time = time(seasonal_data),
  Original = as.numeric(seasonal_data),
  WithNA = as.numeric(data_with_na_dry),
  Interpolation = as.numeric(interp_dry),
  SeasonalDecomposition = as.numeric(seadec_dry)
)

ggplot(df_seasonal, aes(x = Time)) +
  geom_line(aes(y = Original, color = "Original"), size = 1) +
  geom_point(aes(y = WithNA, color = "Com Falhas"), size = 2) +
  geom_line(aes(y = Interpolation, color = "Interpolação"), linetype = "dashed") +
  geom_line(aes(y = SeasonalDecomposition, color = "Decomposição Sazonal")) +
  labs(y = "Valores", color = "Método") +
  theme_minimal()


# 3. Desenvolvimento de Algoritmo Simples ---------------------------------

# Função para interpolação linear
linear_interpolation <- function(data) {
  n <- length(data)
  for (i in 1:n) {
    if (is.na(data[i])) {
      # Encontrar os vizinhos
      prev <- max(which(!is.na(data[1:(i-1)])), na.rm = TRUE)
      next <- min(which(!is.na(data[(i+1):n])) + i, na.rm = TRUE)
      # Calcular interpolação linear
      data[i] <- data[prev] + (data[next] - data[prev]) / (next - prev) * (i - prev)
    }
  }
  return(data)
}

# Aplicar interpolação manual
manually_filled <- linear_interpolation(data_with_na)


# Comparar com na_interp
interp_filled <- na_interp(data_with_na)

# Verificar diferenças
df_manual <- data.frame(
  Time = time(data),
  Original = as.numeric(data),
  WithNA = as.numeric(data_with_na),
  Manual = as.numeric(manually_filled),
  Interpolation = as.numeric(interp_filled)
)

ggplot(df_manual, aes(x = Time)) +
  geom_line(aes(y = Original, color = "Original"), size = 1) +
  geom_point(aes(y = WithNA, color = "Com Falhas"), size = 2) +
  geom_line(aes(y = Manual, color = "Manual"), linetype = "dashed") +
  geom_line(aes(y = Interpolation, color = "Interpolação")) +
  labs(y = "Valores", color = "Método") +
  theme_minimal()


# Materiais Adicionais ----------------------------------------------------

# Documentação do pacote imputeTS: ImputeTS CRAN
# 
# Guia de séries temporais em R: Time Series Analysis in R
# 
# Artigo Referência: Utilize o artigo que como base para explicar a aplicação em situações reais.
# 
# Esses scripts e materiais dão suporte à execução
