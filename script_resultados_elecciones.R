# Agregar Datos a los resultados absolutos
library(sqldf)


### leer los datos
resultados2018 <- read.csv("C:/work/Explotacion/EleccionesUNO/input_resultados2018.csv", sep=";")


### Completar con otros datos
for(escuela in resultados2018$ID){
  resultados2018$totalVotos[escuela] <- resultados2018$VotosGEA[escuela] + resultados2018$VotosNU[escuela]
  resultados2018$porcent_GEA[escuela] <- (resultados2018$VotosGEA[escuela] * 100)/ resultados2018$totalVotos[escuela]
  resultados2018$porcent_NU[escuela] <- (resultados2018$VotosNU[escuela] * 100)/ resultados2018$totalVotos[escuela]
}

totales <- sqldf("
              SELECT SUM(VotosGEA) as VotosGEA, SUM(VotosNU) as VotosNU, 
              SUM(totalVotos) as totalVotos
              FROM resultados2018")

resultados2018$VotosGEA[4] <- totales$VotosGEA
resultados2018$VotosNU[4] <- totales$VotosNU
resultados2018$totalVotos[4] <- totales$totalVotos
resultados2018$porcent_GEA[4] <- (totales$VotosGEA * 100)/ totales$totalVotos
resultados2018$porcent_NU[4] <- (totales$VotosNU * 100)/ totales$totalVotos


### grabar los datos en un archivo .csv
write.csv2(resultados2018, "data_resultados_2018.csv",  row.names = FALSE, fileEncoding = "UTF-8")



