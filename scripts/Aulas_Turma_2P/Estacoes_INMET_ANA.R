# ESTACOES METEOROLOGICAS -------------------------------------------------
# BY: Izadora S. de Carvalho

# Carregando pacotes
library(httr)
library(jsonlite)
library(leaflet)
library(dplyr)
library(sf)

# Dados das estações do site do INMET

#estacoes automaticas
# url <- "https://apitempo.inmet.gov.br/estacoes/T"

#estacoes convencionais
url <- "https://apitempo.inmet.gov.br/estacoes/M"

response <- httr::GET(url)

estacoes <- jsonlite::fromJSON(content(response, "text"),
                               flatten = TRUE)

head(estacoes)
str(estacoes)
dplyr::glimpse(estacoes)

estacoes$VL_ALTITUDE <- as.numeric(estacoes$VL_ALTITUDE)
estacoes$VL_LONGITUDE <- as.numeric(estacoes$VL_LONGITUDE)
estacoes$VL_LATITUDE <- as.numeric(estacoes$VL_LATITUDE)

# Visualizando os dados

leaflet(estacoes) |> 
  addTiles() |> # Adicionar mapa base
  addCircleMarkers(
    lng = estacoes$VL_LONGITUDE,
    lat = estacoes$VL_LATITUDE,
    radius = 5,
    color = "blue",
    popup = ~paste("Estação:", DC_NOME, "<br>", "Código:", CD_ESTACAO, "<br>", 
                   "UF:", SG_ESTADO)
  ) |> 
  addLegend(
    position = "bottomright",
    title = "Estações INMET",
    colors = "blue",
    labels = "Estação Meteorológica"
  )

# Dados das estações do site da ANA
#estacoes ANA - Rede Hidrometeorólogia Nacional (RHN)
#https://metadados.snirh.gov.br/geonetwork/srv/api/records/f85dbf06-a869-414c-afc5-bb01869e9156
#https://metadados.snirh.gov.br/geonetwork/srv/por/catalog.search#/home

# url <- "https://metadados.snirh.gov.br/files/f85dbf06-a869-414c-afc5-bb01869e9156/EstacoesRHN.gpkg"
url <- 'https://metadados.snirh.gov.br/files/f85dbf06-a869-414c-afc5-bb01869e9156/geoft_estacao_hidrometeorologica.gpkg'
salvarArquivo <- "dados/EstacoesRHN.gpkg"

# Fazendo download do arquivo

download.file(url, destfile = salvarArquivo, mode = "wb" )

# Carregar o arquivo baixado
estacoes_rhn <- sf::st_read(salvarArquivo)

head(estacoes_rhn)
colnames(estacoes_rhn)
str(estacoes_rhn)
# Selecionar colunas relevantes
# estacoes_rhn <- estacoes_rhn %>%
#   mutate(
#     longitude = st_coordinates(.)[, 1], # Extrair a coordenada X (longitude)
#     latitude = st_coordinates(.)[, 2]  # Extrair a coordenada Y (latitude)
#   ) |> 
#   dplyr::select(Nome, TipoEstacao, Operando, 
#                 CodigoAdicional, UF, longitude,latitude)

estacoes_rhn <- estacoes_rhn %>%
  dplyr::select(Nome, TipoEstacao, Operando, 
                CodigoAdicional, UF, Latitude, Longitude)

estacoes_rhn_func <- estacoes_rhn %>%
  filter(Operando == "Sim",
         UF == "MARANHÃO")

# Criar mapa interativo com leaflet
leaflet(estacoes_rhn_func) %>%
  addTiles() %>% # Adicionar mapa base
  addCircleMarkers(
    data = estacoes_rhn_func,
    lng = estacoes_rhn_func$Longitude, # Extrair longitude
    lat = estacoes_rhn_func$Latitude, # Extrair latitude
    radius = 5,
    color = "blue",
    popup = ~paste(
      "Nome:", Nome, "<br>",
      "Tipo:", TipoEstacao, "<br>",
      "Operando", Operando, "<br>",
      "Código:", CodigoAdicional, "<br>",
      "UF:", UF
    )
  ) %>%
  addLegend(
    position = "bottomright",
    title = "Estações RHN",
    colors = "blue",
    labels = "Estação Hidrometeorológica",
    opacity = 0.7
  )

#Todas 
estacoes_rhn_all <- estacoes_rhn %>%
  filter(UF == "MARANHÃO")

# Criar mapa interativo com leaflet
leaflet(estacoes_rhn_all) %>%
  addTiles() %>% # Adicionar mapa base
  addCircleMarkers(
    data = estacoes_rhn_func,
    lng = estacoes_rhn_func$Longitude, # Extrair longitude
    lat = estacoes_rhn_func$Latitude, # Extrair latitude
    radius = 5,
    color = "blue",
    popup = ~paste(
      "Nome:", Nome, "<br>",
      "Tipo:", TipoEstacao, "<br>",
      "Operando", Operando, "<br>",
      "Código:", CodigoAdicional, "<br>",
      "UF:", UF
    )
  ) %>%
  addLegend(
    position = "bottomright",
    title = "Estações RHN",
    colors = "blue",
    labels = "Estação Hidrometeorológica",
    opacity = 0.7
  )
