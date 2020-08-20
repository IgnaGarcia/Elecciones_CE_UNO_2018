# Alumnos totales de la UNO


### Cargar alumnos por carrera
ID <- c(1, 2, 3, 4, 5)
Escuela <- c("Quimica", "Administracion", "Salud", "Humanidades", "Informatica")
Alumnos <- c(88, 389, 641, 189, 200)


### Guardarlos en un DataFrame
padron2019 <- data.frame(ID, Escuela, Alumnos)

### grabar los datos en un archivo .csv
write.csv2(padron2019, "data_padron_2019.csv",  row.names = FALSE, fileEncoding = "UTF-8")

