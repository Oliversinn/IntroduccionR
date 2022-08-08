# Oliver Mazariegos - oliver@mazariegos.gt
# En este script exploraremos los Básicos de R


# Al escribir un símbolo "#" se pueden escribir comentarios.
# Esto es un comentario.
# Los comentarios nos pueden ayudar a dividir el código y explicar lo que el código hace en un lenguaje coloquial.
# Sección 1 ----
# En RStudio terminar un comentario en (----) lo convertirá en una sección

# Variables ----
nombre = "Oliver"
apellido = "Mazariegos"
edad <- 24

nombre # resultado: Oliver
apellido # resultado: Mazariegos
edad # resultado: 24

## Numeric ----
a = 10
b = 456.876

a # resultado: 10
b # resultado: 456.876

## Integer ----
a = 10L
b = 456L

a # resultado: 10
b # resultado: 456

## Character ----
a = "Hola"
b = 'Mundo' 

a # resultado: Hola
b # resultado: Mundo

## Date ----
hoy = Sys.Date() # Sys.Date() es una función de R que devuelve la fecha actual

hoy # resultado: la fecha de hoy en formato "Año-Mes-Día"

fecha1 = "10-01-1998" # Fecha en formato "Día-Mes-Año"
# Utilizaremos la función as.Date() para convertir la fecha1 de string a date
fecha1_convertida = as.Date(fecha1, format = "%d-%m-%Y")
fecha1_convertida # resultado: "1998-01-10"
# Utilizaremos la función class() para saber el tipo de variable de una variable
class(fecha1) # resultado: character
class(fecha1_convertida) # resultado: Date

fecha2 = "10/01/1998" # Fecha en formato "Día/Mes/Año"
# Utilizaremos la función as.Date() para convertir la fecha1 de string a date
fecha2_convertida = as.Date(fecha2, format = "%d/%m/%Y")
fecha2_convertida # resultado: "1998-01-10"
# Utilizaremos la función class() para saber el tipo de variable de una variable
class(fecha2) # resultado: character
class(fecha2_convertida) # resultado: Date

fecha3 = "10/01/98" # Fecha en formato "Día/Mes/Año 2 dígitos"
# Utilizaremos la función as.Date() para convertir la fecha1 de string a date
fecha3_convertida = as.Date(fecha3, format = "%d/%m/%y")
fecha3_convertida # resultado: "1998-01-10"
# Utilizaremos la función class() para saber el tipo de variable de una variable
class(fecha3) # resultado: character
class(fecha3_convertida) # resultado: Date

# EJERCICIO: Convertir la fecha4 de string a Date
fecha4 = "2022/23/06" # Fecha en formato "Año/Día/Mes


# Formatear una fecha a nuestra conveniencia
hoy # output: fecha de hoy en formato "Año-Mes-Día"
format(hoy, "%d/%m/%Y") # output: fecha de hoy en formato "Día/Mes/Año"


# Logical/Boolean ----
a = TRUE
b = T # si escribimos solo la T mayúscula, R lo toma como TRUE

a # resultado: TRUE
b # resultado: TRUE

a = FALSE
b = F # si escribimos solo la F mayúscula, R lo toma como FALSE

a # resultado: FALSE
b # resultado: FALSE


# Vectors ----
dias_de_la_semana = c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo") # La función c() significa combine
dias_de_la_semana # resultado: "lunes" "martes" "miércoles" "jueves" "viernes" "sábado" "domingo"

# Para acceder a un elemento del vector se utiliza [] colocando dentro la posición del elemento que se quiere seleccionar
lunes = dias_de_la_semana[1]
lunes # resultado: "lunes"

# Para modificar un elemento de la lista se define cual elemento con []
dias_de_la_semana[1] = "LUNES"
lunes_mayuscula = dias_de_la_semana[1]
lunes_mayuscula # resultado: "LUNES"
dias_de_la_semana # resultado: "LUNES" "martes" "miércoles" "jueves" "viernes" "sábado" "domingo"

# EJERCICIO: Extraiga el día miércoles de dias_de_la_semana

# El operador ":" nos permite generar una secuencia de números sencillamente
# La secuencia se genera de la siguiente forma inicio:fin
1:5 # resultado: 1 2 3 4 5

# EJERCICIO: crear un vector con los números del 17-47

# EJERCICIO: Extraer los días entre semana de dias_de_la_semana. Hint: utilizar el operador ":"

# EJERCICIO: Extraer los días del fin de semana de dias_de_la_semana.

# EJERCICIO: Combinar los días entre semana y los días del fin de semana para crear los días de la semana
#            hint: utilizar c()


# Listas ----
frutas = list("manzana", "banano", "naranja")
frutas # resultado: "manzana" "banano" "naranja" Pero representado en una estructura diferente, en estructura de lista

# En las listas se pueden acceder y modificar elementos igual que en vectores
# EJERCICIO: extraiga banano de frutas y guárdela en una variable

# EJERCICO: modifique naranja en frutas por arándano

# Las listas nos permiten agregar un elemento al final con append()
frutas = append(frutas, "piña")
frutas # resultado: "manzana", "banano", "arándano", "piña"

# Las listas incluso nos permiten agregar un elemento en una posición en especifico
frutas = append(frutas, "naranja", after = 2)
frutas # resultado: "manzana", "banano", "naranja", "arándano", "piña"

# Las listas tambien se pueden combinar utilizando c()
verduras = list("perulero", "zanahoria")
vegetales = c(frutas, verduras)

# EJERCICIO: Haga una lista de ingredientes para hacer panqueques

# EJERCICIO: Haga una lista de utensilios para hacer panqueques

# EJERCICIO: Combine los ingredientes y utensilios en una variable llamada receta

# EJERCICIO: Agréguele un ingrediente nuevo a la receta



# Factores ----
sexo = factor(c("Masculino", "Femenino", "Femenino", "Femenino", "Masculino", "Femenino"))
sexo # output: Masculino Femenino Femenino Femenino Masculino Femenino, Levels: Masculino Femenino

# levels son las distintos niveles/opciones que tiene dicho vector. 
# Con la función levels() podemos extraer los niveles de un factor
levels(sexo) # Levels: Masculino Femenino

# Tambien se pueden definir los niveles de un factor con el parametro levels en la función factor()
sexo = factor(c("Masculino", "Femenino", "Femenino", "Femenino", "Masculino", "Femenino"), levels = c("Masculino", "Femenino", "Desconocido"))
sexo # output: Masculino Femenino Femenino Femenino Masculino Femenino, Levels: Masculino Femenino Desconocido

# A los factores tambien se pueden modificar y accesar con []
sexo[3] # output: Femenino, Levels: Masculino Femenino Desconocido
sexo[3] = "Masculino" 
sexo[3] # output: Masculino, Levels: Masculino Femenino Desconocido

# EJERCICIO: Haga un factor para Leve/Moderado/Grave/Severo

# EJERCICIO: Agréguele un nivel más

# EJERCICIO: Modifique algún elemento del factor por un valor que no esté en los niveles. ¿Que pasa?


# Data Frames ----
## Desde cero ---- 
# Al colocar 2 "#" en un comentario de sección (los que terminan en ----)
# Crear Data  Frame
heroes = data.frame (
  Nombre = c("Bruce", "Clark", "Peter"),
  Apellido = c("Wayne", "Kent", "Parker"),
  Edad = c(37, 34, 17)
)
heroes # output: un data frame con las variables Nombre, Apellido y Edad

# Para acceder a las variables de un Data Frame se puede utilizar
# 1. []: La posición de la variable
heroes[2] # output: Apellido

# 2. [[]]: Por nombre de la variable
heroes[["Edad"]] # output: Edad

# 3. $: Por nombre de la variable
heroes$Nombre # output: Nombre

# EJERCICIO: Extraiga con [] las variables Nombre y Apellido de heroes al mismo tiempo

# EJERCICIO: Extraiga con [[]] las variables Nombre y Edad de heroes al mismo tiempo

# Para agregar una nueva variable podemos asignarla utilizando $
# Nueva variable con un valor por cada fila
heroes$Universo = c("DC", "DC", "MARVEL")
# Nueva variable con un mismo valor para todas las filas
heroes$Ubicación = NA

# EJERCICIO: Agregar la variable "Ciudad" con los valores para cada héroe

# Guardar un dataframe en un archivo csv con write.csv()
write.csv(heroes, 'heroes.csv')


## Cargandolo de archivo ----
# Para cargar una base de datos en formato CSV se utiliza read.csv()
cancer = read.csv('../cancer_data.csv')
cancer # output: un data frame con estadísticas del cáncer


# Operadores ----
## Matemáticos ----
# Suma +
5 + 5 # output: 10

# Resta -
25 - 10 # output: 15

# Multiplicación *
5 * 5 # output: 25

# Division /
25 / 5 # output: 5

# Exponente ^
5 ^ 2 # output: 25

# Módulo %%
25 %% 5 # output: 0

# División entera %/%
15 %/% 2 # output: 7

# Estos operadores también funcionan sobre vectores
x = c(1:10)
x # output: 1 2 3 4 5 6 7 8 9 10
x + 5 # output: 6  7  8  9 10 11 12 13 14 15
x - 5 # output: -4 -3 -2 -1  0  1  2  3  4  5
x * 2 # output: 2  4  6  8 10 12 14 16 18 20

# EJERCICIO: Opere x con los operadores /, ^, %% y %/%

# EJERCICIO: Cree un vector (y) distinto a x con 10 números.

# EJERCICIO: Opere x con y con al menos 3 operadores matemáticos

# Los operadores de + y - pueden utilizarse con fechas
# EJERCICIO: cree una variable llamada hoy de tipo Date con la fecha de hoy

# EJERCICIO: utilizando + calcule la fecha que será en 9 días

# EJERCICIO: utilizando - calcule la fecha que fue hace 23 días

# EJERCICIO: obtenga el día de la semana (lunes, martes, miércoles..., domingo) que fue hace 438 días.
#            hint: format()



## Comparativos ----
# Igualdad
5 == 5 # output: TRUE
5 == 3 # output: FALSE
2 + 3 == 5 # output: TRUE
5 == 2 + 3 # output: TRUE
"Hola" == "Adios" # output: FALSE
"Hola" == "hola" # output: FALSE
"Hola" == "Hola" # output: TRUE

# Desigualdad
5 != 5 # output: FALSE
5 != 3 # output: TRUE
"Hola" != "Adios" # output: TRUE
"Hola" != "Hola" # output: FALSE

# Mayor que
5 > 3 # output: TRUE
3 > 5 # output: FALSE
3 > 3 # output: FALSE

# Menor que
5 < 3 # output: FALSE
3 < 5 # output: TRUE
3 < 3 # output: FALSE

# Mayor o igual que
5 >= 5 # output: TRUE

# Menor o igual que
5 <= 5 # output: TRUE



## Lógicos ----
# AND (&): Devuelve TRUE is ambas condiciones son TRUE
TRUE & TRUE # output: TRUE
TRUE & FALSE # output: FALSE
FALSE & FALSE # output: FALSE
5 + 5 == 10 & 2 + 2 == 4 # output: TRUE
5 + 5 == 10 & 2 + 2 == 3 # output: FALSE
5 + 5 == 9 & 2 + 2 == 3 # output: FALSE

# OR (|): Devuelve TRUE is alguno de los elementos son TRUE
TRUE | TRUE # output: TRUE
TRUE | FALSE # output: TRUE
FALSE | FALSE # output: FALSE
5 + 5 == 10 | 2 + 2 == 4 # output: TRUE
5 + 5 == 10 | 2 + 2 == 3 # output: TRUE
5 + 5 == 9 | 2 + 2 == 3 # output: FALSE

# NOT (!): Niega el valor booleano.
!TRUE # output: FALSE
!FALSE # output: TRUE
!5 + 5 == 10 # output: FALSE


# IF ELSE ----
# Los if se escriben con la estructura if (condición) { codigo }
a = 5
b = 3

if (a > b) {
  print("a es mayor que b") 
} # output: a es mayor que b
if (a < b) {
  print("a es menor que b") 
} # output: No se ejecuta nada


if (a > b) {
  print("a es mayor que b") 
} else {
  print("a es menor que b") 
} # output: a es menor que b

# EJERCICIO: Crear una condición para cuando a y b son iguales

# Podemos probar múltiples condiciones con operadores lógicos
if (a > b & a > 4) {
  print("a es mayor que b y que 4") 
} else {
  print("a no es mayor que b y que 4") 
}

# Podemos tener más de una condición
if (a > b) {
  print("a es mayor que b") 
} else if (a == b) {
  print("a es igual que b") 
} else {
  print("a es menor que b")
} # output: a es menor que b

# EJERCICIO: Dado tres números, diga cual es el numero mayor utilizando if



# While ----
x = 0
# Mientras x sea menor que 10 entonces
while (x < 10) {
  print(x)
  # Hago que x aumente para que cuando llegue a 10 se termine el ciclo
  x = x + 1
} # output: 0 1 2 3 4 5 6 7 8 9

# EJERCICIO: Haga un ciclo while como el anterior pero que solo imprima números pares


# For ----
for (x in 1:10) {
  print(x)
} # output: 1 2 3 4 5 6 7 8 9 10

frutas = list("manzana", "banano", "naranja")
for (fruta in frutas) {
  print(fruta)
} # output: manzana, banano, naranja

# EJERCICIO: Recorra la lista frutas con un for y solo imprima la fruta si es un banano

# Funciones ----
# Creación de la función
mi_funcion = function() {
  print("Hola Mundo")
}
# Llamada a la función
mi_funcion() # output: Hola Mundo

# Función con parámetros
al_cuadrado = function(x) {
  cuadrado = x ^ 2
  print(cuadrado)
}

al_cuadrado(5) # output: 5

# Función con valores de retorno
al_cuadrado = function(x) {
  return(x ^ 2)
}

z = al_cuadrado(5)
z # output: 25

# EJERCICIO: Haga una función que calcule el área de un circulo dado su radio

# Paquetes ----
# Instalar un paquete
# install.packages("pacman") # Correr solo una vez
# Cargar un paquete
library("pacman")

# Ahora que ya tenemos descargado pacman podemos utilizar p_load()
# Instala si es necesario y carga el paquete
p_load(dplyr)
# Puede que múltiples paquetes tenga funciones con nombres similares
# para especificar de que paquete se quiere utilizar la funcion se
# utiliza nombre_paquete::funcion()
pacman::p_load(ggplot2)

# Podemos pedir ayuda sobre las funciones que no sabemos utilizar
# para eso se utiliza ?nombre_funcion
?pacman::p_load
?sum
?mean

# Extra ----
## %in% ----
"Bruce" %in% heroes$Nombre # output: TRUE
74 %in% c(1:10) # output: FALSE

## %like% ----
p_load(data.table) 
heroes$Nombre %like% "Bruce" #output: TRUE FALSE FALSE
heroes$Nombre %like% "Bruc" #output: TRUE FALSE FALSE
heroes$Nombre %like% "uce" #output: TRUE FALSE FALSE









