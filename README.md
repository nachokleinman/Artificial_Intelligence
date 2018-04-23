# Inteligencia-Artificial

Ejercicios de Inteligencia artifical usando FuzzyClips.

**ENUNCIADO:**

Práctica de razonamiento borroso (FuzzyCLIPS) Inteligencia Artificial Curso 2017/18
Univ. Carlos III de Madrid

Los organizadores del TECHFEST (https://t3chfest.uc3m.es/2018/?lang=es) se han propuesto para el año 2020 elegir de forma automática las charlas que ofertarán en dicho evento. El TechFest es un evento organizado por los alumnos tecnológicos de la Univ. Carlos III de Madrid. Durante dos días ponentes de empresas y universidades dan unas 60 charlas que han propuestos ellos a las que asisten unas 1200 personas sobre todo tipo de temas tecnológicos. Los organizadores buscan temas que sean de interés, que haya charlas de entidades significativas, que los temas no se repitan mucho, aunque un mismo ponente pueda dar más de una charla, y que la imagen ser moderna y actual (la edad de los ponentes suele ser baja). Unos meses antes convocan una call for talks abierta a cualquier tema tecnológico a través de la cual consiguen muchas más propuestas de charlas que las que físicamente da tiempo a dar, así que la tarea de seleccionar las más interesantes se hace ardua y compleja.
Para llevar a cabo dicha selección tendrán en cuenta aspectos (algunos subjetivos) como el interés del tema de la charla, el solapamiento del tema con otras charlas, la edad del ponente y la notoriedad de la entidad a la que pertenece el ponente. Una vez realizado el evento, se modificarán las valoraciones de algunos de estos aspectos de acuerdo a la asistencia y la opinión de los asistentes de cara a mejorar el procedimiento de selección en años venideros.
Ejercicios a realizar en FuzzyCLIPS:


1. *Entrega 1 Objetivo: familiarizar se con CLIPS, razonamiento clásico sin nada fuzzy)*
  - Definir un hecho simple que indique el número de charlas que se impartirán en una determinada edición del techfest.
  - Definir una plantilla (template) para declarar hechos estructurados concretos sobre los ponentes: su nombre, su edad concreta, titulo de la charla (hace de identificador de la misma), tema de la charla, entidad a la que pertenece y el año del techfest en el que opta a participar. Nota: un mismo ponente puede proponer varias charlas.
  - Definir una regla que como consecuente añada como hecho simple la selección del titulo de una charla para una edición particular del techfest, y que como antecedente elija charlas de temas no seleccionados previamente sin repetir ponente ni superar el numero total de charlas del tehcfest. Ejecutarla con hechos creados adhoc a vuestro gusto y observar qué ocurre.

2. *Entrega 2 Objetivo: Definición de plantillas y hechos borrosos.*
  - Definir una plantilla (template) para declarar hechos borrosos sobre el (escaso, medio y alto) interés de un tema utilizando las funciones s, pi y z z, pi y s respectivamente.
  - Definir una plantilla para declarar hechos borrosos sobre la (poca y mucha) notoriedad de una la entidad a la que pertenece el ponente usando una definición por puntos.
  - Definir una plantilla (template) para declarar hechos borrosos sobre la edad del ponente (joven, madurito, adulto, prejubilado) interés de un tema utilizando una definición por puntos.
  - Declarar el interés de cada tema propuesto como hechos borrosos usando la plantilla del apartado 2.0. Nota: puede haber más de una charla de un mismo tema. Por ejemplo debéis declarar hechos como que el interés del tema blockchain es escaso y el de los videojuegos alto.
  - Declarar la notoriedad de cada entidad a la que pertenece el ponente usando la plantilla del aparatado 2-1. Nota: puede haber más de un ponente de una misma entidad. Por ejemplo debéis declarar hechos como que la notoriedad de la entidad Electronic Arts es mucha.

3. *Entrega 3 Objetivo: Definir reglas con antecedente borroso, uso de modificadores*
  - Definir una regla que incluya en el techfest a las charlas de interés muy alto (uso de modificador very) cuyos temas no hayan sido seleccionados previamente sin superar el máximo número de charlas del techfest. Nota: consiste en modificar la regla del apartado 1.2 incluyendo un nuevo antecedente. Ejecutarla como única regla y observar qué ocurre.
  - Definir una regla que incluya en el techfest a las charlas cuya entidad sea de notoriedad más o menos mucha (uso de modificador somewhat) cuyos temas no hayan sido seleccionados previamente sin superar el máximo número de charlas del techfest. Nota: consiste en modificar la regla del apartado 1.2 incluyendo un nuevo antecedente. Ejecutarla cómo única regla y observar qué ocurre.
  - Definir una regla que incluya en el techfest a las charlas cuya entidad sea de no poca notoriedad (modificador not), de interés medio o alto (or), cuyos temas no hayan sido seleccionados previamente sin superar el máximo número de charlas del techfest. Nota: consiste en modificar la regla del apartado 1.2 incluyendo dos nuevos antecedente. Ejecutarla cómo única regla y observar qué ocurre.

4. *Entrega 4 Objetivo: Observar y manejar CF de consecuente concreto con antecedente borroso equiparado con valor concreto.*
  - Definir una regla que concluya una preselección (ojo: no selección definitiva) en el techfest a las charlas cuyo ponente sea joven, cuya entidad sea de mucha notoriedad yde interés más o menos alto. Nota: consiste en modificar la regla del apartado 3.2
  - Definir una regla que elija para la selección definitiva, a ejecutar cuando ha concluido la preselección (usando hechos para regular esta secuencia y no la prioridad de las reglas), entre los preseleccionados aquellos cuyo factor de certeza (cf) sea mayor, cuyos temas no hayan sido seleccionados previamente, sin superar el número máximo de charlas total de esa edición del techfest. Ejecutarla estas dos reglas cómo únicas reglas y observar qué ocurre. Nota: usar get-cf

5. *Entrega 5 Objetivo: observar contribución global de varias reglas a un mismo consecuente.*
  - Definir una regla que concluya una preselección (ojo: no selección definitiva) en el techfest a las charlas cuyo ponente sea joven y cuya entidad sea de mucha notoriedad.
  - Definir una regla que concluya una preselección (ojo: no selección definitiva) en el techfest a las charlas de interés más o menos alto y su edad sea madurito. Nota: consiste en modificar la regla del apartado 3.2
  - Definir una regla que elija para la selección definitiva, a ejecutar cuando ha concluido la preselección (usando hechos para regular esta secuencia y no la prioridad de las reglas), entre los preseleccionados aquellos cuyo factor de certeza (cf) sea mayor, cuyos temas no hayan sido seleccionados previamente, sin superar el número máximo de charlas total de esa edición del techfest. Ejecutarla estas tres reglas cómo únicas reglas y observar qué ocurre. Nota: usar get-cf

6. *Entrega 6 Objetivo: Observar defuzzificación de hecho borroso mediante centro de gravedad y media de los máximos.*
  - Definir una plantilla para declarar hechos borrosos sobre la (buena, media y mala) opinión de un asistente sobre una charla usando una definición por puntos.
  - Una vez realizado un techfest, cada asistente ha indicado una opinión borosa (buena, normal, mala), y tendremos por tanto varios hechos asociado la charla a distintos tipos borrodos de opinion (opinion charla buena, charla buena, charla mala, etc.). Definir reglas que conviertan esas valoraciones borrosas en valores concretos (defuzzificar) y concluyan la media de esos valores como la opinión (concreta numérica) agregada de la charla. Nota: usar y ejecutar por un lado moment- defuzzify y por otro maximum-defuzzify y observar las diferencias.

7. *Entrega 7 Objetivo: Observar consecuente borroso con antecedente borroso usando los métodos de inferencia maxmin y maxprod.*
  - Definir una plantilla para declarar hechos borrosos sobre la (escasa, regular y abundante) asistencia a una charla usando una definición por puntos.
  - Una vez concluida la opinión concreta agregada de los asistentes del apartado 6, y contando con un hecho que indique el número concreto de asistentes a la charla, definir una regla que tenga como antecedentes que la opinion sobre la charla sea buena y la asistencia asistencia alta y como consecuente el futuro interés del tema. Nota: usar set-fuzzy-inference-type con max-min por un lado y max-prod por otro y observar las diferencias.
