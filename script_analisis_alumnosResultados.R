#Analisis de resultados en relacion al total de alumnos

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
Escuela <- resultados_2018$Escuela
Votantes <- resultados_2018$totalVotos
##### Cargar datos en un Data Frame
data <- data.frame(ID, Escuela, Alumnos, Votantes, porcentVotantes, porcentGEA, porcentNU)


##### Guardar en archivo .csv
write.csv2(data, "data_alumnosResultados.csv",  row.names = FALSE, fileEncoding = "UTF-8")
