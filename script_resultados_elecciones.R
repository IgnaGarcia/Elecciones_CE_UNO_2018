# Agregar Datos a los resultados absolutos
library(sqldf)
library(readr)

### leer los datos
resultados2018 <- read_delim("input_resultados_2018.csv", ";", escape_double = FALSE, trim_ws = TRUE)

resultados2018$totalVotos <- NULL
resultados2018$porcent_GEA <- NULL
resultados2018$porcent_NU <- NULL

### Completar con otros datos
for(escuela in resultados2018$ID){
  resultados2018$totalVotos[escuela] <- resultados2018$VotosGEA[escuela] + resultados2018$VotosNU[escuela]
  resultados2018$porcent_GEA[escuela] <- round((resultados2018$VotosGEA[escuela] * 100)/ resultados2018$totalVotos[escuela], 2)
  resultados2018$porcent_NU[escuela] <- round((resultados2018$VotosNU[escuela] * 100)/ resultados2018$totalVotos[escuela], 2)
}

totales <- sqldf("
              SELECT SUM(VotosGEA) as VotosGEA, SUM(VotosNU) as VotosNU, 
              SUM(totalVotos) as totalVotos
              FROM resultados2018")

resultados2018$VotosGEA[4] <- totales$VotosGEA
resultados2018$VotosNU[4] <- totales$VotosNU
resultados2018$totalVotos[4] <- totales$totalVotos
resultados2018$porcent_GEA[4] <- round((totales$VotosGEA * 100)/ totales$totalVotos, 2)
resultados2018$porcent_NU[4] <- round((totales$VotosNU * 100)/ totales$totalVotos, 2)


### grabar los datos en un archivo .csv
write.csv2(resultados2018, "data_resultados_2018.csv",  row.names = FALSE, fileEncoding = "UTF-8")



