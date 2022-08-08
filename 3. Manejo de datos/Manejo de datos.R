# Oliver Mazariegos - oliver@mazariegos.gt
# En este script aprenderemos a menejar datos

# Importar datos ----
# Cargar pacman
library(pacman)
# Cargar rio
pacman::p_load(rio)

# Cargar base de datos en formato excel
ebola = import("../linelist_raw.xlsx")
head(ebola) # output: Data Frame de brote de ebola

# Cargar base de datos en formato CSV
cancer = read.csv('../cancer_data.csv')
head(cancer) # output: un data frame con estadísticas del cáncer

# Análisis inicial ----
# Resumen de base de datos ----
# Resumen de base de datos utilizando summary()
summary(cancer) # output: resumen de las variables de cancer

# EJERCICIO: Haga un resumen de la base de datos de ebola

# Resumenes utilizando skim
pacman::p_load(skimr)
# Resumen de base de datos utilizando skim()
skim(cancer) # output: resumen de las variables de cancer

# EJERCICIO: Haga un resumen de la base de dato de ebola utilizando skim

## Dimensiones de un Data Frame ----
# La función dim devuelve #FILAS #COLUMNAS
dim(cancer) # output: 35 11

# EJERCICIO: Determine la dimensión de ebola

## Cantidad de columnas de un Data Frame ----
# La función ncol() devuelve el #COLUMNAS
ncol(cancer)

## Cantidad de filas de un Data Frame ----
# La función nrow() devuelve el #FILAS
# EJERCICIO: calcule la cantidad de filas de cáncer


## Nombres de columnas de un Data Frame ----
# colnames recibe como parámetro un Data Frame
colnames(cancer) # output: nombre de las 11 columnas de cáncer
variables_cancer = colnames(cancer)
variables_cancer # output: nombre de las 11 columnas de cáncer

# con colnames también podemos cambiar el nombre de las variables utilizando []
colnames(cancer)[1] = 'tipo'
colnames(cancer) # output: nombre de las 11 columnas, con la primera renombrada a 'tipo'
# También nos permite acceder al nombre de una columna en específica con []
colnames(cancer)[1] # output: tipo
# También nos permite cambiar todos los nombres al mismo tiempo
# para esto necesitamos indicar un vector con longitud igual al
# número de columnas del Data Frame
colnames(cancer) = variables_cancer
colnames(cancer) # output: nombre original de las 11 columnas de cáncer

# EJERCICIO: Traduzca al español las variables de cáncer y asignárselas a cáncer

# EJERCICIO: Vuelva el nombre de las variables de cáncer a su nombre original


## Valores únicos ----
# Para determinar los valores únicos utilizamos unique()
unique(ebola$hospital) # output: 14 valores únicos para la variable hospital

## Frecuencias de variables categóricas ----
# La función table() nos cuenta las ocurrencias de variables categóricas
table(ebola$outcome) # output: Death = 2898, Recover = 2213

# EJERCICIO: Haga que el comando anterior tome en cuenta los NA
#            hint: pida ayuda utilizando ?

# EJERCICIO: Haga otro recuenta de ocurrencias de otra variable de ebola

## Proporciones de variables categóricas ----
# Para generar las proporciones debemos primero crear una tabla de frecuencias
frecuencias_outcome = table(ebola$outcome)
# Como segundo paso, pasamos la tabla como parámetro de prop.table()
prop.table(frecuencias_outcome) # output: Death = 0.5670123, Recover = 0.4329877

# EJERCICIO: Realizar una tabla de proporción de otra variable de ebola 
#.           reto: en solo una línea de código

# Limpieza de datos ----
# Cargamos paquetes a utilizar
pacman::p_load(janitor, dplyr)

## Nombres de variables ----
colnames(ebola) # output: nombres de variables de ebola
### clean_names() ----
# utilizaremos %>% para mandar en secuencia ebola
ebola_nombres = ebola %>%
  clean_names() # Aplicamos la función a lo mandado en secuencia (en este caso el DF ebola)

colnames(ebola_nombres) # output: nombres de ebola estandarizados

### rename() ----
# utilizamos %>% para mandar en secuencia ebola_nombres
ebola_nombres_renombre = ebola_nombres %>%
  # Renombramos de manera manual
  # NUEVONOMBRE          # VIEJO NOMBRE
  rename(
    date_infection       = infection_date,
    date_hospitalisation = hosp_date,
    date_outcome         = date_of_outcome
  )

# También se puede renombrar utilizando la posición de la columna
ebola_nombres_renombre = ebola_nombres %>%
  # Renombramos de manera manual
  # NUEVONOMBRE          # POSICIÓN
  rename(
    date_infection       = 3,
    date_hospitalisation = 5,
    date_outcome         = 6
  )

# El poder de %>% es que podemos secuenciar las funciones
# por lo que podríamos haber realizado lo siguiente
# utilizaremos %>% para mandar en secuencia ebola
ebola_nombres_renombre = ebola %>%
  # Aplicamos la función a lo mandado en secuencia (en este caso el DF ebola)
  clean_names() %>% # Mandamos en secuencia el resultado de clean_names
  # Renombramos de manera manual
  # NUEVONOMBRE          # VIEJO NOMBRE
  rename(
    date_infection       = infection_date,
    date_hospitalisation = hosp_date,
    date_outcome         = date_of_outcome
  )

# Seleccionar variables ----
# pasaremos a select como argumentos la variables de ebola_limpia que queremos utilizar
ebola_fechas = ebola_nombres %>% # Mandamos ebola_limpia en secuencia
  select(
    # Agregamos las variables que queremos seleccionar separadas por coma (,)
    infection_date,
    date_onset,
    hosp_date,
    date_of_outcome,
  )
ebola_fechas # output: El Data Frame de ebola solo con las variables indicadas

# EJERCICIO: Encadene el proceso de ebola_nombres como en el ejemplo de rename()

# select() también nos permite renombrar las variables al seleccionarlas
ebola_fechas = ebola_nombres %>% # Mandamos ebola_limpia en secuencia
  select(
    # Agregamos las variables que queremos seleccionar separadas por coma (,)
    # NUEVONOMBRE        # VIEJO NOMBRE
    date_infection       = infection_date,
    date_onset,
    date_hospitalisation = hosp_date,
    date_outcome         = date_of_outcome
  )
ebola_fechas # output: El Data Frame de ebola solo con las variables indicadas y renombradas

# select también define el orden en que están las variables
ebola_fechas = ebola_nombres %>% # Mandamos ebola_limpia en secuencia
  select(
    date_of_outcome,
    hosp_date,
    date_onset,
    infection_date,
  )
ebola_fechas # output: El Data Frame de ebola solo con las variables indicadas en el orden inverso al anterior ejemplo

# Si utilizamos el símbolo - podemos des seleccionar variables
ebola_fechas_deseleccion = ebola_fechas %>%
  select(
    -date_onset
  )
ebola_fechas_deseleccion # output: El Data Frame del ejemplo anterior sin la variable date_onset

# Seleccionar dada una condición
ebola %>% # se envía en secuencia ebola
  select(where(is.numeric)) %>% # se seleccionan las variables que son numéricas con la función is.numeric
  colnames() # se imprimen los nombres de columnas para ver cuales fueron seleccionadas

# EJERCICIO: seleccione de ebola las variables que son de tipo character

# Seleccionar columnas que contengan una cadena de caracteres en su nombre
ebola %>% # se envía en secuencia ebola
  select(contains("date")) %>% # se seleccionan las variables que contengan "date" en su nombre
  colnames() # se imprimen los nombres de columnas para ver cuales fueron seleccionadas

# Seleccionar columnas si es que existan
ebola %>% # se envía en secuencia ebola
  select(any_of(c("date onset", "pais", "departamento"))) %>% # se seleccionan las variables que contengan "date" en su nombre
  colnames() # se imprimen los nombres de columnas para ver cuales fueron seleccionadas

# De-duplicación ----
nrow(ebola) # output: 6611
nrow(ebola %>% distinct()) # output: 6609

ebola_limpia = ebola %>%
  # Aplicamos la función a lo mandado en secuencia (en este caso el DF ebola)
  clean_names() %>% # Mandamos en secuencia el resultado de clean_names
  # Renombramos de manera manual
  # NUEVONOMBRE          # VIEJO NOMBRE
  rename(
    date_infection       = infection_date,
    date_hospitalisation = hosp_date,
    date_outcome         = date_of_outcome
  ) %>%
  # Seleccionamos variables
  select(
    -x28, # Removemos variable x28
    -merged_header # Removemos variable merged_header
  ) %>%
  distinct() # De-duplicamos los registros

# Transformación de columnas ----
## mutate() ----
# Agregar una nueva columna
ebola_mutate = ebola_limpia %>%
  mutate(
    nueva_columna = 100 # Creamos una variable llamada nueva_columna con 100 como valor
  )
ebola_mutate$nueva_columna # output: vector con solo 100

# Podemos referenciar otra columna para hacer cálculos
ebola_mutate = ebola_limpia %>%
  mutate(
    wt_lb = wt_kg * 2.5 # Creo una variable de peso en libras a partir del peso en kilo gramos
  )
ebola_mutate$wt_lb # output: peso en libras de todos los casos

# EJERCICIO: cree una variable del indice de masa corporal (BMI por sus siglas en ingles)
#            formula: BMI = kg/m^2

# Podemos convertir variables al formato más conveniente
# Cuando hicimos un resumen de ebola, vimos que las fechas no eran Date
# y que la edad era character en lugar de numeric. Para crear o modificar
# varias variables con mutate se separan con coma (,)
ebola_mutate = ebola_limpia %>%
  mutate(
    date_infection = as.Date(date_infection), # as.Date() es una función que nos permite convertir una variable a tipo Date
    date_onset = as.Date(date_onset),
    date_hospitalisation = as.Date(date_hospitalisation),
    date_outcome = as.Date(date_outcome),
    age = as.numeric(age),
  )
skim(ebola_mutate) # output: nuestras variables ya serán del tipo de dato especificado

# Como vimos en los ejemplos anteriores, mutate puede utilizar funciones también
# La edad normalizada
ebola_mutate = ebola_mutate %>%
  mutate(age_norm = age / mean(age, na.rm = T)) # mean() es la función de media
ebola_mutate$age_norm # output: la edad normalizada

### across() ----
# across() recibe como parámetros las columnas (.cols) y la función (.fns) que se les aplicara
ebola_mutate = ebola_limpia %>%
  mutate(
    across(.cols = c(date_infection, date_onset, date_hospitalisation, date_outcome), .fns = as.Date),
    age = as.numeric(age)
  )
skim(ebola_mutate) # output: nuestras variables ya serán del tipo de dato especificado

# incluso across() comprende las funciones de tidyselect
# EJERCICIO: en el ejemplo anterior no especifique todas las columnas de fechas,
#            utilicé alguna función de tidyselect para seleccionarlas todas.
#            hint: regrese a la sección de select()

ebola_limpia = ebola %>%
  # Aplicamos la función a lo mandado en secuencia (en este caso el DF ebola)
  clean_names() %>% # Mandamos en secuencia el resultado de clean_names
  # Renombramos de manera manual
  # NUEVONOMBRE          # VIEJO NOMBRE
  rename(
    date_infection       = infection_date,
    date_hospitalisation = hosp_date,
    date_outcome         = date_of_outcome
  ) %>%
  # Seleccionamos variables
  select(
    -x28, # Removemos variable x28
    -merged_header # Removemos variable merged_header
  ) %>% 
  distinct() %>% # De-duplicamos registros
  mutate(
    bmi = wt_kg / (ht_cm/100)^2 # Creamos una variable
  ) %>%
  mutate(
    # Cambiamos el tipo de dato de variables
    across(.cols = c(date_infection, date_onset, date_hospitalisation, date_outcome), .fns = as.Date),
    age = as.numeric(age)
  )

### recode() ----
# recode() nos permite re-codificar una variable. Esto nos permite estandarizar una variable
unique(ebola_limpia$hospital) # output: valores únicos de hospital con muchas opciones mal escritas
ebola_mutate = ebola_limpia %>% 
  mutate(hospital = recode(hospital,
                           # sintaxis:    VIEJO = NUEVO
                           "Mitylira Hopital"  = "Military Hospital",
                           "Mitylira Hospital" = "Military Hospital",
                           "Military Hopital"  = "Military Hospital",
                           "Port Hopital"      = "Port Hospital",
                           "Central Hopital"   = "Central Hospital",
                           "other"             = "Other",
                           "St. Marks Maternity Hopital (SMMH)" = "St. Mark's Maternity Hospital (SMMH)"
  ))
unique(ebola_mutate$hospital) # output: valores únicos de hospital ya estandarizados

# EJERCICIO: re-codificar gender a Male y Female

### replace() ----
ebola_mutate = ebola_limpia %>%
  mutate(
    gender = replace(gender, case_id == "2195", "Female") # Re-codificamos por la condición que el case_id sea 2195
  )
ebola_mutate %>%
  filter(case_id == "2195") %>%
  select(gender) # otuput: Female

### ifelse() ----
# utilizaremos la variable source para crear una variable source_known
# esta variable tendrá known si tiene algún valor y uknown si no lo tiene
ebola_mutate = ebola_limpia %>%
  mutate(
    source_known = ifelse(!is.na(source), "known", "unknown") # is.na() devuelve TRUE si el valor es NA
    # el operador ! niega is.na()
  )
table(ebola_mutate$source_known) # output: known = 4286, unknown = 2323

### if_else() ----
# Crearemos una variable date_death si el outcome es Death
# utilizamos if_else() porque el nuevo valor es tipo Date
ebola_mutate = ebola_limpia %>%
  mutate(
    date_death = if_else(outcome == "Death", date_outcome, NA_real_) # NA_real_ se usa para asignar NA a variables de tipo Date
  )

### case_when() ----
# En age tenemos edades en años y en meses (age_unit)
# utilizaremos case_when para volverlas todas a años
ebola_mutate = ebola_limpia %>%
  mutate(
    # age_years sera la variable con las edades en años
    age_years = case_when(
      age_unit == "years"  ~ age,       # cuando la edad esta en years, utilizamos age
      age_unit == "months" ~ age/12,    # cuando la edad esta en months, dividimos age/12 para convertirlo a años
      is.na(age_unit)      ~ age,       # si no se especifica la unidad, asumimos que está en años
      TRUE                 ~ NA_real_   # en cualquier otra circunstancia, asignamos NA
    )
  )

# EJERCICIO: re-codifique hospital con case_when() en vez de recode()

### replace_na() ----
p_load(tidyr) # cargamos el paquete tidyr
unique(ebola_limpia$hospital) # output: los valores posibles de hospital incluyendo NA
ebola_mutate = ebola_limpia %>%
  mutate(
    hospital = replace_na(hospital, "Missing") # Reemplaza NA a Missing
  )
unique(ebola_mutate$hospital) # output: los valores posibles de hospital sin NA y con Missing

### na_if() ----
unique(ebola_mutate$hospital) # output: los valores posibles de hospital sin NA y con Missing
ebola_mutate = ebola_mutate %>%
  mutate(
    hospital = na_if(hospital, "Missing") # Reemplaza Missing a NA
  )
unique(ebola_mutate$hospital) # output: los valores posibles de hospital incluyendo NA

### na.rm
# Calcular el promedio de la variable lat
mean(ebola_limpia$lat) # output: NA
mean(ebola_limpia$lat, na.rm = TRUE) # output: 8.469682

ebola_limpia = ebola %>%
  # Aplicamos la función a lo mandado en secuencia (en este caso el DF ebola)
  clean_names() %>% # Mandamos en secuencia el resultado de clean_names
  # Renombramos de manera manual
  # NUEVONOMBRE          # VIEJO NOMBRE
  rename(
    date_infection       = infection_date,
    date_hospitalisation = hosp_date,
    date_outcome         = date_of_outcome
  ) %>%
  # Seleccionamos variables
  select(
    -x28, # Removemos variable x28
    -merged_header # Removemos variable merged_header
  ) %>% 
  distinct() %>% # De-duplicamos registros
  mutate(
    bmi = wt_kg / (ht_cm/100)^2 # Creamos una variable
  ) %>%
  mutate(
    # Cambiamos el tipo de dato de variables
    across(.cols = c(date_infection, date_onset, date_hospitalisation, date_outcome), .fns = as.Date),
    age = as.numeric(age)
  ) %>%
  mutate(
    hospital = recode(hospital,
                      # sintaxis:    VIEJO = NUEVO
                      "Mitylira Hopital"  = "Military Hospital",
                      "Mitylira Hospital" = "Military Hospital",
                      "Military Hopital"  = "Military Hospital",
                      "Port Hopital"      = "Port Hospital",
                      "Central Hopital"   = "Central Hospital",
                      "other"             = "Other",
                      "St. Marks Maternity Hopital (SMMH)" = "St. Mark's Maternity Hospital (SMMH)"
    )
  ) %>%
  mutate(
    # age_years sera la variable con las edades en años
    age_years = case_when(
      age_unit == "years"  ~ age,       # cuando la edad esta en years, utilizamos age
      age_unit == "months" ~ age/12,    # cuando la edad esta en months, dividimos age/12 para convertirlo a años
      is.na(age_unit)      ~ age,       # si no se especifica la unidad, asumimos que está en años
      TRUE                 ~ NA_real_   # en cualquier otra circunstancia, asignamos NA
    )
  ) %>%
  mutate(
    hospital = replace_na(hospital, "Missing")
  )

# EJERCICIO: Condensar aun más el código

# Agregar una fila ----
nrow(ebola_limpia) # output: 6609
ebola_add_row = ebola_limpia %>%
  add_row( # Agregamos una nueva fila con add_row()
    #     Variable = Valor
    case_id        = "abc",
    generation     = 4,
    date_infection = as.Date("2020-10-10"),
    .before        = 2 # este campo es para especificar la posición en la que queremos colocar la fila
    # si no se especifica la fila se crea al final del Data Frame
  )
nrow(ebola_add_row) # output: 6610

# Filtros en variables ----
# Para filtrar hay que pasarle a filter() las condiciones
ebola_limpia %>%
  filter(
    hospital == "Port Hospital" # Que la variable hospital sea igual a "Port Hospital"
  ) # output: ebola_limpia filtrada por los que tienen como hospital "Port Hospital"

# Se pueden colocar múltiples condiciones separadas por comas
ebola_limpia %>%
  filter(
    hospital == "Port Hospital",
    gender == "m",
  ) # output: ebola_limpia filtrada por los que tienen como hospital "Port Hospital" y gender "m"

# Se pueden colocar operadores booleanos
ebola_limpia %>%
  filter(
    hospital == "Port Hospital" | # Que la variable hospital sea igual a "Port Hospital" OR (|)
      hospital == "Central Hospital"
  ) # output: ebola_limpia filtrada por los que tienen como hospital "Port Hospital"

# EJERCICIO: Del ejemplo anterior, en vez de utilizar OR realizar el filtro con %in%

# EJERCICIO: Realice un filtro en ebola_limpia de pacientes del hospital St. Mark's Maternity Hospital (SMMH),
#            que sean hombres y que sean mayores de edad.



## drop_na() ----
ebola_limpia %>%
  # filtrar filas si hay NAs en case_id o en age_years
  drop_na(
    case_id, 
    age_years
  ) # output: ebola_limpia filtrada por case_id y age_year donde no tengan NAs

# arrange() ----
ebola_limpia %>%
  # ordenamos las filas de ebola_limpia con arrange() en base
  # a las variables hospital y date_onset
  arrange(
    hospital,         # Variable de mayor prioridad para ordenar
    desc(date_onset)  # desc() se utiliza cuando se quiere ordenar de manera descendente
  )

# group_by() ----
ebola_limpia %>%
  # agrupamos con group_by()
  group_by(
    gender,   # agrupar por sexo
    hospital  # agrupar por hospital
  ) %>%
  # Se aplican funciones sobre los grupos
  # tally() es una función que cuenta
  tally() # output: las frecuencias de las ocurrencias de todas las combinaciones de gender y hospital

# summarise() ----
ebola_limpia %>%
  # agrupamos con group_by()
  group_by(
    gender,   # agrupar por sexo
    hospital  # agrupar por hospital
  ) %>%
  # Generamos age_mean calculando el promedio de age_years
  summarise(age_mean = mean(age_years, na.rm = TRUE)) # output: las medias de edad para las combinaciones de gender y hospital

# EJERCICIO: Haga lo anterior con mutate en vez de summarise. ¿Nota la diferencia?

# Unir bases de Datos ----
ebola = import("../linelist_cleaned.rds")
## Bases de datos ----
# Prepararemos los Data frames
# DF mini de ebola
ebola_mini = ebola %>%
  select(case_id, date_onset, hospital) %>%
  head(10) # head(n) es una función que devuelve las primeras n filas de un Data Frame
ebola_mini # output: nuestro mini Data Frame con 10 filas y las columnas case_id, date_onset, hospital

# DF con información de hospitales
hospitales = data.frame(
  hosp_name     = c("central hospital", "military", "military", "port", "St. Mark's", "ignace", "sisters"), # Nombre del hospital
  catchment_pop = c(1950280, 40500, 10000, 50280, 12000, 5000, 4200), # Población de captación
  level         = c("Tertiary", "Secondary", "Primary", "Secondary", "Secondary", "Primary", "Primary") # Nivel de atención
)
hospitales #output: nuestro Data Frame con 7 filas con las columnas hosp_name, catchment_pop, level

# EJERCICIO: Que ven de interesante en hospitales$hosp_name

## Preprocesamiento ----
# EJERCICIO: obtenga los valores únicos de hospital de ebola_mini

# EJERCICIO: obtenga los valores únicos de hosp_name de hospitales


# EJERCICIO: Estandarizar hospitales de hospitales para que coincidan con hospitals de ebola_mini
#            hint: recode() o case_when()


# Chequeo de que estén corregidos los nombres
unique(hospitales$hosp_name) # output: Central Hospital, Military Hospital, Port Hospital, St. Mark's Maternity Hospital (SMMH), ignace, sisters


## Sintaxis de JOINS ----
### Variable en común con diferente nombre ----
# Join basado en la columna ID del df1 e identificador del df2
joined = left_join(df1, df2, by = c("ID" = "identificador"))

### Variable en común con mismo nombre ----
# Join basado en la columna ID
joined = left_join(df1, df2, by = "ID")

### Multiples variables en común ----
# Join basado en las columnas nombre, apellido del df1 y primernombre, primerapellido del df2
joined = left_join(df1, df2, by = c("nombre" = "primernombre", "apellido" = "primerapellido"))

## Left Join ----
ebola_joined = left_join(ebola_mini, hospitales, by = c("hospital" = "hosp_name")) # Left join directo
ebola_joined = ebola_mini %>%
  left_join(hospitales, by = c("hospital" = "hosp_name")) # Left join en secuencia

# EJERCICIO: Explorar ebola_joined y anotar cambios

## Right Join ----
# EJERCICIO: crear ebola_joined utilizando right_join()


## Full Join ----
ebola_joined = full_join(ebola_mini, hospitales, by = c("hospital" = "hosp_name"))

# EJERCICIO: Explorar ebola_joined y anotar cambios


## Inner Join ----
ebola_joined = inner_join(ebola_mini, hospitales, by = c("hospital" = "hosp_name"))

# EJERCICIO: Explorar ebola_joined y anotar cambios


# Grupos de edad ----
# EJERCICIO: Crear una variable en ebola que se llame age_group
#            que represente el grupo de edade al que pertenece
#            cada observación usando case_when()

## age_categories() ----
# Cargar paquete epikit
p_load(epikit)

ebola = ebola %>%
  mutate(
    # Creamos los grupos utilizando age_categories() en la variable age_group
    age_group = age_categories(
      age_years,    # Variable que contiene las edades
      breakers = c(0, 5, 10, 15, 20,
                   30, 40, 50, 60, 70) # Puntos de quiebre para los grupos
    )
  )
# Posibles valores en age_group
table(ebola$age_group, useNA = "always") # output: table con los grupos de edad creados anteriormente

# Semanas epidemiológicas ----
## incidence() ----
# Cargar paquete incidence2
p_load(incidence2)
# Crear objeto de incidencia
incidencia = incidence(    # incidence() crea un objeto especial de tipo incidence2
  x = ebola,               # Base de datos
  date_index = date_onset, # Columna con fechas
  interval = "week"        # Agrupar por semana
)
incidencia # output: date_index(fecha) count(cantidad de incidencias)

# EJERCICIO: cree un resumen de incidencia

# Los objetos incidence2 se pueden graficar fácilmente con
# plot() pero en la siguiente sección veremos como hacer 
# gráficas de una manera más elegante
plot(incidencia)

# Analizar incidencia por grupos de edad
incidencia_edad = incidence(    # incidence() crea un objeto especial de tipo incidence2
  x = ebola,               # Base de datos
  date_index = date_onset, # Columna con fechas
  interval = "week",       # Agrupar por semana
  groups = age_group,      # Grupos por grupos de edad
  na_as_group = TRUE       # Tomar en cuenta los NA en los grupos
)
plot(
  incidencia_edad,      # Base de datos
  fill = age_group      # Colorear en base a los grupos de edad
)






