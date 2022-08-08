# Oliver Mazariegos - oliver@mazariegos.gt
# En este script exploraremos como gráficar en R 

# plot() ----
plot(1,3) # output: Gráfica con un punto donde x = 1 y y = 3

# Gráfica de múltiples puntos
plot(c(1,8),c(3,10))
# La gráfica anterior es igual a
x = c(1,8)
y = c(3, 10)
plot(x, y)

# Para definir el color de los puntos se utiliza col
plot(c(1:10), col = "red")

# Para cambiar el titulo se utiliza el argumento main
plot(c(1:10), col = "red", main = "Mi grafica")

# Para cambiar la leyenda de los ejes se usa xlab e ylab
plot(c(1:10), col = "red", main = "Mi grafica", xlab = "El eje x", ylab = "El eje y")

# Para cambiar el tamaño de los puntos se utiliza cex
plot(c(1:10), col = "red", main = "Mi grafica", xlab = "El eje x", ylab = "El eje y", cex = 3)

# Para cambiar la figura del punto se utiliza pch 
plot(c(1:10), col = "red", main = "Mi grafica", xlab = "El eje x", ylab = "El eje y", cex = 3, pch = 9)


## Gráficos de línea ----
# El argumento type especifica el tipo de gráfico que queremos
plot(c(1:10), type = "l") # Para conocer que tipos existen correr ?plot

# El argumento de color sigue siendo el mismo
plot(c(1:10), type = "l", col = "blue")

# El grosor de la línea se edita con lwd
plot(c(1:10), type = "l", col = "blue", lwd = 2)

# Se pueden agregar múltiples líneas con lines()
linea1 = c(1:10)
linea2 = c(10:1)
plot(linea1, type = "l", col = "blue", lwd = 2)
lines(linea2, type = "l", col = "red", lwd = 2)

# Para cambiar el estilo de la línea se utiliza lty
plot(c(1:10), type = "l", col = "blue", lwd = 2, lty = 3)


## Gráficos de dispersión ----
x = c(5,7,8,7,2,2,9,4,11,12,9,6)
y = c(99,86,87,88,111,103,87,94,78,77,85,86)
# Es importante que los vectores x e y sean de la misma longitud
plot(x, y)

# Agreguemos títulos para que se comprendan los datos
plot(x, y, main="Precios promedio de carros", xlab="Edad del Carro", ylab="Precio (miles de dolares)")

# Supongamos que comparamos los precios con los de otro país
# Al igual que con las gráficas de líneas podemos agregar puntos con points()
x2 <- c(2,2,8,1,15,8,12,9,7,3,11,4,7,14,12)
y2 <- c(100,105,84,105,90,99,90,95,94,100,79,112,91,80,85)
plot(x, y, main="Precios promedio de carros", xlab="Edad del Carro", ylab="Precio (miles de dolares)")
points(x2, y2, col = "red")

# Histogramas ----
library(pacman)
p_load(rio)
# Cargamos la base de datos de ebola
ebola = import("../linelist_cleaned.rds")
# Histograma de edad
hist(ebola$age)
# Como en plot, los títulos se cambian con main, xlab e ylab
hist(ebola$age, main = "Histograma de Edad", xlab = "Edad", ylab = "Frecuencia")
# Tambien se puede definir el color del histograma con el argumento col
hist(ebola$age, 
     main = "Histograma de Edad", xlab = "Edad", ylab = "Frecuencia",
     col = "purple")

# EJERCICIO: crear un histograma de otra variables de ebola con títulos y color hexagesimal
#            Hint: el color blanco en hexagesimal es #FFFFFF


# Gráfico de barras ----
## plot() ----
# Gráfico de barras de grupos de edad
plot(ebola$age_cat)
# EJERCICIO: personalice el gráfico con títulos


## barplot() ----
# Generación de una tabla de frecuencias
age_cat_frecuencias = table(ebola$age_cat)
age_cat_frecuencias # output: Tabla de frecuencias de grupos de edad
barplot(age_cat_frecuencias)

# Generación de una tabla de contingencia
age_cat_gender = table(ebola$gender, ebola$age_cat)
age_cat_gender # output: Tabla de contingencia para grupos de edad por sexo
barplot(age_cat_gender)
# Para agregar la leyenda se utiliza legend()
barplot(age_cat_gender, col = c("pink", "blue"))
legend(x = "topright",            # Posición de la leyenda
       legend = c("f", "m"),     # Clases
       fill = c("pink", "blue"), # Colores
       title = "Sexo")         # Genero


# Gráficos de Caja ----
# Boxplot simple de edad
boxplot(ebola$age)

# Boxplot de edad por sexo
boxplot(formula = age ~ gender, data = ebola)

p_load(dplyr, tidyr, ggplot2)
# Previa limpieza de ebola
ebola = ebola %>%
  mutate(
    gender_disp = case_when(gender == "m" ~ "Male",        # m a Male 
                            gender == "f" ~ "Female",      # f a Female,
                            is.na(gender) ~ "Unknown"),    # NA a Unknown
    
    outcome_disp = replace_na(outcome, "Unknown")          # reemplazar NA en outcome con "Unknown"
  )

# ggplot2 ----
## Estructura de ejemplo ----
ggplot(data = mis_datos) +               # Utilizar Data Frame "mis_datos" y crea un lienzo en blanco
  geom_point(                            # Agregar una capa de puntos
    mapping = aes(x = col1, y = col2),   # "mapear" las columnas a los ejes
    color = "red"                        # Otras especificaciones del geom
  ) +
  labs() +                               # Aca se agregan los titulos
  theme()                                # Aca se puede cambiar el color, fuente y tamaño de los titulos y otros elementos


## Mapeo de datos ----
# Gráfico de dispersion de edad y peso
ggplot(data = ebola, mapping = aes(x = age, y = wt_kg)) +   # Se crea un lienzo para los datos de ebola y se mapea a x la edad e y el peso en kg
  geom_point()                                              # Se crea un geom_point que edera el mapeo de ggplot()

# EJERCICIO: Con ggplot haga un histograma de la edad

# El mapeo se puede hacer de múltiples formas y dependerá de la aplicación
# Los siguientes comandos generan la misma gráfica
ggplot(data = ebola, mapping = aes(x = age)) +
  geom_histogram()

ggplot(data = ebola)+
  geom_histogram(mapping = aes(x = age))

ggplot()+
  geom_histogram(data = ebola, mapping = aes(x = age))


### Estética ----
# histograma de edad
ggplot(data = ebola, mapping = aes(x = age))+       # mapea datos a los ejes
  geom_histogram(              # hace un histograma
    binwidth = 7,                # Ancho de los contenedores de histograma
    color = "red",               # Color de la línea del contenedor
    fill = "blue",               # Color interior del contenedor
    alpha = 0.1)  


#### Valores estáticos ----
# Gráfico de dispersión de edad y peso
ggplot(data = ebola, mapping = aes(x = age, y = wt_kg))+  # Se mapean las columnas a los ejes
  geom_point(color = "darkgreen", size = 0.5, alpha = 0.2)         # Esteticas estáticas

#### Valores dinámicos ----
# Gráfico de dispersión de edad y peso con color dinámico
ggplot(data = ebola,   # Se define la base de daots
       mapping = aes(     # Mapeo de estética
         x = age,           # eje x a age            
         y = wt_kg,         # eje y a weight
         color = age)       # color a age
)+     
  geom_point()

# Gráfico de dispersión de edad y peso con color y tamaño dinámico
ggplot(data = ebola,     # Se define la base de daots
       mapping = aes(
         x = age,         # eje x a age            
         y = wt_kg,       # eje y a weight
         color = age,     # color a age
         size = age,      # tamaño a age
       ))+     
  geom_point(
    shape = "diamond",    # Que los puntos se vean como diamantes
    alpha = 0.3           # Transparencia del punto al 30%
  )


# Importancia del orden
ggplot(data = ebola, 
       mapping = aes(
         x = age, 
         y = wt_kg,
         color = age_years)
)+                     # Se mapean las columnas a los ejes
  geom_point(size = 1,         # Tamaño de los puntos
             alpha = 0.2) +   # Transparencia de los puntos
  geom_smooth(                 # Agregar línea de tendencia
    method = "lm",             # Con el método lineal
    size = 2)  


## Agrupación de valores ----
# Gráfica de dispersión de edad y peso por sexo
ggplot(data = ebola,
       mapping = aes(x = age, y = wt_kg, color = gender))+
  geom_point(alpha = 0.5)


## Facetas ----
# Gráfica de dispersión de edad y peso en facetas por sexo
ggplot(data = ebola,
       mapping = aes(x = age, y = wt_kg))+
  geom_point(alpha = 0.5) +
  facet_wrap(~gender)

# Gráfica de dispersión de edad y peso en facetas por sexo y por hospital
ggplot(data = ebola,
       mapping = aes(x = age, y = wt_kg))+
  geom_point(alpha = 0.5) +
  facet_grid(hospital~gender)

## Guardar gráficas ----
# Gráfico de dispersión de años y peso
dispersion_edad_peso = ggplot(data = ebola, mapping = aes(x = age_years, y = wt_kg, color = age_years))+
  geom_point(alpha = 0.1)
dispersion_edad_peso

# Agregar línea de tendencia
dispersion_edad_peso +
  geom_smooth(                 # Agregar línea de tendencia
    method = "lm",             # Con el método lineal
    size = 2)

# Agregar línea vertical
dispersion_edad_peso +
  geom_vline(xintercept = 50)


## Etiquetas ----
# EJERCICIO: agréguele etiquetas a la gráfica dispersion_edad_peso
#            Tip: Para cambiar el titulo de la leyenda utilice color


## Temas ----
dispersion_edad_peso = ggplot(data = ebola, mapping = aes(x = age_years, y = wt_kg, color = age_years))+
  geom_point(alpha = 0.1) +
  labs(
    title = "Distribución de edad y peso",
    subtitle = "Brote ficticio de ébola, 2014",
    x = "Edad en años",
    y = "Peso en kilos",
    color = "Edad",
    caption = "Datos a la fecha del 10-01-2020")
### Temas completos ----
dispersion_edad_peso +
  labs(title = "Tema clasico") +
  theme_classic()

dispersion_edad_peso +
  labs(title = "Tema bw") +
  theme_bw()

dispersion_edad_peso +
  labs(title = "Tema minimal") +
  theme_minimal()

dispersion_edad_peso +
  labs(title = "Tema gris") +
  theme_gray()


### Modificar temas ----
dispersion_edad_peso +
  theme_classic() +                              # Tema base
  theme(
    legend.position = "bottom",                   # Mover legenda hacia abajo
    plot.title = element_text(size = 30),         # Tamaño del título
    plot.caption = element_text(hjust = 0),       # Alinear a la izquierda el caption
    plot.subtitle = element_text(face = "italic"),# Subtitulo en itálica
    axis.text.x = element_text(color = "red", size = 15, angle = 90), # Ajustar el texto del eje x
    axis.text.y = element_text(size = 15),        # Ajustar el texto del eje y
    axis.title = element_text(size = 20)          # Ajustar el titulo de ambos ejes
  )


## Histogramas ----
# A) Histograma normal
ggplot(data = ebola, aes(x = age))+  
  geom_histogram()+
  labs(title = "A) Histograma por defecto (30 bins)")

# B) Más barras
ggplot(data = ebola, aes(x = age))+  
  geom_histogram(bins = 50)+
  labs(title = "B) Configurado a 50 bins")

# C) Menos barras
ggplot(data = ebola, aes(x = age))+  
  geom_histogram(bins = 5)+
  labs(title = "C) Configurado a 5 bins")

# D) Mas barras
ggplot(data = ebola, aes(x = age))+ 
  geom_histogram(binwidth = 1)+
  labs(title = "D) binwidth de 1")


# Frecuencia suavizada
ggplot(data = ebola, mapping = aes(x = age)) +
  geom_density(size = 2, alpha = 0.2)+
  labs(title = "Densidad Proporcional")

# Frecuencia suavizada apilada
ggplot(data = ebola, mapping = aes(x = age, fill = gender)) +    # Colores por sexo
  geom_density(size = 2, alpha = 0.2, position = "stack")+          # position = stack hace que se apilen
  labs(title = "Densidad Proporcional Apilada")



## Boxplots ----
# A) Boxplot simple
ggplot(data = ebola)+  
  geom_boxplot(mapping = aes(y = age))+   # se define solo y
  labs(title = "A) Boxplot simple")

# B) Boxplot por grupos
ggplot(data = ebola, mapping = aes(y = age, x = gender, fill = gender)) + 
  geom_boxplot()+                     
  theme(legend.position = "none")+   # remover la leyenda (redundante)
  labs(title = "B) Boxplot agrupado por genero")


## Barplots ----
# De manera directa
## Barras verticales
ggplot(data = ebola, aes(x = hospital)) + geom_bar()
## Barras horizontales
ggplot(data = ebola, aes(y = hospital)) + geom_bar()

# Preparando los datos
frecuencias_hospitales = ebola %>%
  group_by(hospital) %>%
  tally()
frecuencias_hospitales # output: dataframe con "hospitals" y "n"

ggplot(frecuencias_hospitales, aes(x = hospital, y = n)) + 
  geom_bar(stat = "identity")

# Agrupando por variables
ggplot(data = ebola, aes(y = hospital, fill = outcome)) + geom_bar()


# Pirámides demográficas ----
# Cargamos el paquete
p_load(apyramid)
# Gráfica de pirámide demográfica
age_pyramid(data = ebola,             # Data Frame ebola
            age_group = "age_cat5",  # Grupos de edad cada 5 años
            split_by = "gender")     # Dividido por sexo

# Pirámide demográfica agrupada por hospital
age_pyramid(data = ebola,             # Data Frame ebola
            age_group = "age_cat5",  # Grupos de edad cada 5 años
            split_by = "gender",     # Dividido por sexo
            stack_by = "hospital")  # Agrupada por hospital

# Pirámide demográfica personalizada
age_pyramid(
  data = ebola,
  age_group = "age_cat5",
  split_by = "gender",
  proportional = TRUE,              # Mostrar proporción en vez de cantidad
  show_midpoint = FALSE,            # remover la linea de punto medio
) +                 
  theme_minimal()+                               # Tema de ggplot
  scale_fill_manual(                             # Especificar color y etiquetas
    values = c("orange", "purple"),              
    labels = c("m" = "Masculino", "f" = "Femenino"))+
  labs(y = "Porcentaje de casos",              # Notar que los títulos de los ejes estan cambiados
       x = "Grupos de edad",                          
       fill = "Sexo", 
       caption = "Este es el caption",
       title = "Casos de Ebola por Grupos de Edad",
       subtitle = "Brote Ficticio")+
  theme(
    legend.position = "bottom",                          # Posición de la leyenda
    axis.text = element_text(size = 10, face = "bold"),  # fuentes y tamaños de texto
    axis.title = element_text(size = 12, face = "bold"))


# Curvas Epidemiológicas ----
p_load(incidence2)
# Gráfica estándar
incidencia_edad = incidence(    # incidence() crea un objeto especial de tipo incidence2
  x = ebola,               # Base de datos
  date_index = date_onset, # Columna con fechas
  interval = "week",       # Agrupar por semana
  groups = hospital,       # Grupos por hospital
  na_as_group = TRUE,      # Tomar en cuenta los NA en los grupos
)
plot(incidencia_edad)
plot(incidencia_edad, fill = hospital)

# Preparación de datos
# Analizar incidencia por hospital
incidencia_edad = incidence(    # incidence() crea un objeto especial de tipo incidence2
  x = ebola,               # Base de datos
  date_index = date_onset, # Columna con fechas
  interval = "week",       # Agrupar por semana
  groups = hospital,       # Grupos por hospital
  na_as_group = TRUE,      # Tomar en cuenta los NA en los grupos
) %>% 
  mutate(date_index = as.Date(date_index)) %>%  # Convertir a formato Date la variable de fecha
  as.data.frame(.)                              # Convertir a formato data.frame la tabla

# Curva Epidemiológica
ggplot(incidencia_edad, aes(x=date_index, y=count, fill=hospital)) +
  geom_bar(stat="identity", color = 'black') +
  labs(x="Semana epidemiológica", y="No. de Casos", title="Casos de Ebola")



