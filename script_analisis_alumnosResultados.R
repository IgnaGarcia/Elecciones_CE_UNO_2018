#Analisis de resultados en relacion al total de alumnos
library(readr)
library(ggplot2)
library(plotly)
library(tidyr)
##### Cargar datos
padron_2019 <- read_delim("data_padron_2019.csv", ";", escape_double = FALSE, trim_ws = TRUE)
resultados_2018 <- read_delim("data_resultados_2018.csv", ";", escape_double = FALSE, locale = locale(decimal_mark = ","), trim_ws = TRUE)


##### Creacion de variables

#Total alumnos y porcentaje de votantes
alumnosTotales <- sum(padron_2019$Alumnos)
por100votantes <- round(max(resultados_2018$totalVotos)*100 / alumnosTotales, 2) 


#Alumnos por sede
jujy_alumnosTotales <- padron_2019$Alumnos[5]
cente_alumnosTotales <- padron_2019$Alumnos[2] + padron_2019$Alumnos[4]
cba_alumnosTotales <- padron_2019$Alumnos[1] + padron_2019$Alumnos[3]
### Vector de Alumnos
Alumnos <- c(jujy_alumnosTotales, cente_alumnosTotales, cba_alumnosTotales, alumnosTotales)



#Porcentaje de votantes por sede
jujuy_porcentVotantes <- round(resultados_2018$totalVotos[1]*100 / jujy_alumnosTotales, 2)
cente_porcentVotantes <- round(resultados_2018$totalVotos[2]*100 / cente_alumnosTotales, 2)
cba_porcentVotantes <- round(resultados_2018$totalVotos[3]*100 / cba_alumnosTotales, 2)
### Vector de porcentVotantes
porcentVotantes <- c(jujuy_porcentVotantes, cente_porcentVotantes, cba_porcentVotantes, por100votantes)



#Porcentaje de votantes por GEA
geaVotantes <- round(max(resultados_2018$VotosGEA)*100 / alumnosTotales, 2)
jujuy_geaVotantes <- round(resultados_2018$VotosGEA[1]*100 / jujy_alumnosTotales, 2)
cente_geaVotantes <- round(resultados_2018$VotosGEA[2]*100 / cente_alumnosTotales, 2)
cba_geaVotantes <- round(resultados_2018$VotosGEA[3]*100 / cba_alumnosTotales, 2)
###Vector de votantes por GEA
porcentGEA <- c(jujuy_geaVotantes, cente_geaVotantes, cba_geaVotantes, geaVotantes)



#Porcentaje de votantes por NU
nuVotantes <- round(max(resultados_2018$VotosNU)*100 / alumnosTotales, 2)
jujuy_nuVotantes <- round(resultados_2018$VotosNU[1]*100 / jujy_alumnosTotales, 2)
cente_nuVotantes <- round(resultados_2018$VotosNU[2]*100 / cente_alumnosTotales, 2)
cba_nuVotantes <- round(resultados_2018$VotosNU[3]*100 / cba_alumnosTotales, 2)
###Vector de votantes por NU
porcentNU <- c(jujuy_nuVotantes, cente_nuVotantes, cba_nuVotantes, nuVotantes)

### Variables traidas
ID <- resultados_2018$ID 
Escuela <- as.factor(resultados_2018$Escuela)
Votantes <- resultados_2018$totalVotos

##### Cargar datos en un Data Frame
data <- data.frame(ID, Escuela, Alumnos, Votantes, porcentVotantes, porcentGEA, porcentNU)

##Columna nueva para no votantes
data$NoVotantes <- 100 - data$porcentVotantes


##### Guardar en archivo .csv
write.csv2(data, "data_alumnosResultados.csv",  row.names = FALSE, fileEncoding = "UTF-8")


fig <- plot_ly(data, x = ~Escuela) %>%
  add_trace(y = ~porcentGEA, name = 'GEA', width= .3, 
            text = porcentGEA, textposition = 'auto',
            marker = list(color = 'rgb(44, 160, 44)')) %>% 
  add_trace(y = ~porcentNU, name = 'NU', width= .3, 
            text = porcentNU, textposition = 'auto',
            marker = list(color = 'rgb(31, 119, 180)')) %>%
  layout(title = "Resultados Elecciones CE UNO",
         xaxis = list(title = ""),
         yaxis = list(title = "", range= c(0,100)))
fig

fig2 <- plot_ly(data, x = ~Escuela) %>%
  add_trace(y = ~porcentGEA, name = 'GEA', width= .3,
            text = porcentGEA, textposition = 'auto',
            marker = list(color = 'rgb(44, 160, 44)')) %>% 
  add_trace(y = ~porcentNU, name = 'NU', width= .3, 
            text = porcentNU, textposition = 'auto',
            marker = list(color = 'rgb(31, 119, 180)')) %>%
  layout(title = "Resultados Elecciones CE UNO",
         xaxis = list(title = ""),
         yaxis = list(title = "", range= c(0,100)),
         barmode = 'stack')
fig2

fig1 <- plot_ly(data, x = ~Escuela) %>%
  add_trace(y = ~porcentNU, name = 'NU', width= .2, 
            text = porcentNU, textposition = 'auto',
            marker = list(color = 'rgb(31, 119, 180)')) %>%
  add_trace(y = ~NoVotantes, name = 'Ausentes', width= .2,
            text = NoVotantes, textposition = 'auto',
            marker = list(color = 'rgb(204,204,204)')) %>%
  add_trace(y = ~porcentGEA, name = 'GEA', width= .2, 
            text = porcentGEA, textposition = 'auto',
            marker = list(color = 'rgb(44, 160, 44)')) %>% 
  layout(title = "Resultados Elecciones CE UNO",
         xaxis = list(title = ""),
         yaxis = list(title = ""))
fig1

fig3 <- plot_ly(data, x = ~Escuela) %>%
  add_trace(y = ~porcentGEA, name = 'GEA', width= .3, 
            text = porcentGEA, textposition = 'auto',
            marker = list(color = 'rgb(44, 160, 44)')) %>% 
  add_trace(y = ~porcentNU, name = 'NU', width= .3, 
            text = porcentNU, textposition = 'auto',
            marker = list(color = 'rgb(31, 119, 180)')) %>%
  add_trace(y = ~NoVotantes, name = 'Ausentes', width= .3,
            text = NoVotantes, textposition = 'auto',
            marker = list(color = 'rgb(204,204,204)')) %>%
  layout(title = "Resultados Elecciones CE UNO",
         xaxis = list(title = ""),
         yaxis = list(title = ""),
         barmode = 'stack')
fig3

data1 <- subset(data, Escuela != "Total")

fig4 <- plot_ly(data1, labels = ~Escuela, values = ~porcentGEA, type = 'pie') %>% 
  layout(title = 'Votantes de GEA',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig4

fig5 <- plot_ly(data1, labels = ~Escuela, values = ~porcentNU, type = 'pie') %>% 
  layout(title = 'Votantes de NU',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig5

data2 <- subset(data, Escuela == "Total")
data2 <- data2 %>% gather(seccion, porcent, 6:ncol(data2))

fig4 <- plot_ly(data2, labels = ~seccion, values = ~porcent, type = 'pie') %>% 
  layout(title = 'Votantes Totales',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

fig4
