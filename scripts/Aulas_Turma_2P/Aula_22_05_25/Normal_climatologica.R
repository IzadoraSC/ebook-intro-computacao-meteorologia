#==============================================================================#
#                  UNIVERSIDADE ESTADUAL DO MARANHÃO - UEMA                    #
#            CENTRO DE EDUCAÇÃO, CIÊNCIAS EXATAS E NATURAIS - CECEN            #
#                       DEPARTAMENTO DE GEOGRAFIA                              #
#                         CURSO DE METEOROLOGIA                                #
#                 DISCIPLINA INT. A COMPUTAÇÃO APLICADA                        #
#                                                                              #
# Profa.: IZADORA SANTOS DE CARVALHO                                           #
#==============================================================================#

# Prática Utilizando as Normais Climatológicas (1991-2020) de Temperatura Máxima
# Mensal obtidas do INMET, 

#1.Acessando dados diretamente no site
#2.Organizar daos
#3.Selecionar dados para a área de estudo
#4.Gerando gráficos


# IMPORTAÇÃO E EXPORTAÇÃO DE DADOS ----------------------------------------

# Download das Normais Climatológicas (1991-2020) de Temperatura 
# Máxima Mensal (°C).

# Carregando pacotes
library(tidyverse)
library(readxl)
library(writexl)

# Criando pasta
if(!dir.exists('Dados/')){
  dir.create('Dados')
}

# Baixando dados
# Link para baixar os dados:
url.tmax <- 'https://portal.inmet.gov.br/uploads/normais/Normal-Climatologica-TMAX.xlsx'

download.file(url.tmax,                    # URL do arquivo a ser baixado.
              './Dados/Tmax.xlsx',   # Caminho e Nome do arquivo que será gerado.
              mode = 'wb')                 # Modo de gravação do arquivo: 'wb' para Windows.

dir('./Dados')   # Verifique se o arquivo foi salvo na pasta 'Dados_INMET/'.

TMAX <- read_excel(
  path = './Dados/Tmax.xlsx',   # Caminho e nome do arquivo que será importado.
  sheet = 1,                          # Planilha de interesse.
  na = '-',                           # Identificação dos valores ausentes.
  skip = 2)                           # Número de linhas a serem ignoradas antes de ler os dados. 

# Salvando os dados em csv.
write.table(x = TMAX,                      # Nome do arquivo que será exportado.
            file = './Dados/TMAX_INMET.csv',     # Nome e extensão do arquivo que será gerado.
            dec = ',',                     # Separador de decimais.
            row.names = TRUE,              # FALSE: os nomes das linhas não devem ser considerados.
            sep = ';',                     # Separador de colunas.
            na = 'NA',                     # Identificação dos valores ausentes.
            fileEncoding = 'ISO-8859-1')   # Especifica a codificação a ser usada.

# Salvando os dados em .xlsx, podemos usar a função write_xlsx() do pacote 'writexl'.

write_xlsx(x = TMAX,            # Nome do arquivo que será exportado.
           path = './Dados/TMAX_INMET.xlsx')   # Nome e extensão do arquivo que será gerado.


#Acessando planilha baixada


# Renomeando variáveis
TMAX_INMET <- TMAX |> 
  rename(
    Estação = `Nome da Estação`,
    Jan = Janeiro,
    Fev = Fevereiro,
    Mar = Março,
    Abr = Abril,
    Mai = Maio,
    Jun = Junho,
    Jul = Julho,
    Ago = Agosto,
    Set = Setembro,
    Out = Outubro,
    Nov = Novembro,
    Dez = Dezembro
  )



# Pivotando ---------------------------------------------------------------

TMAX_longer <- 
  TMAX_INMET |> 
  dplyr::mutate(Ano = NULL) |> 
  tidyr::pivot_longer(
    cols = Jan:Dez,      
    names_to = 'Meses',  
    values_to = 'Tmax'
  )
TMAX_longer


# Filtrando os dados UF == SP ---------------------------------------------

TMAX_SP <- 
  TMAX_longer |> 
  dplyr::filter(UF == 'SP')

TMAX_SP


# Gerando gráfico de pontos -----------------------------------------------

TMAX_SP <- 
  TMAX_SP |> 
  mutate(Meses = factor(Meses, 
                        levels = c('Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 
                                   'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez')))


corDegrade <- colorRampPalette(c('red', 'blue', 'goldenrod'))

gr1 <- ggplot(data = TMAX_SP) +
  geom_point(aes(x = Meses, y = Tmax, color = Meses), shape = 18, size = 3)+
  scale_color_manual(values = corDegrade(12)) +
  theme_classic()

gr1


# Salvando o gráfico ------------------------------------------------------

ggsave(
  filename = 'imagens/Grafico_1.png',       # Nome e extensão do arquivo (ex. '.png')
  plot = gr1,
  device = 'png',                        # Extensão do arquivo
  width = 3000, height = 1500,           # Largura e altura, respectivamente
  units = 'px'
)


#Gráficos de barras
gr2 <- ggplot(data = TMAX_SP) +
  geom_bar(aes(x = Meses, y = Tmax, fill = Meses), stat = 'identity')+
  scale_fill_viridis_d(option = "D", begin = 0.2, end = 0.9) +
  theme_classic()

gr2


