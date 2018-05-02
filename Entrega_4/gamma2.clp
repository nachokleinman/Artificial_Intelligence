;Entrega 4 Objetivo: Observar y manejar CF de consecuente concreto con antecedente borroso equiparado con valor concreto

;4.1 Definir una regla que elija para la selección definitiva, a ejecutar cuando
;ha concluido la preselección (usando hechos para regular esta secuencia y no la
;prioridad de las reglas),
;certeza (cf) sea mayor, cuyos temas no hayan sido seleccionados previamente,
;sin superar el número máximo de charlas total de esa edición del techfest.
;Ejecutarla estas dos reglas cómo únicas reglas y observar qué ocurre. Nota: usar get-cf

;made by @ignacioLavina and @ignaciokleinman

(deffacts numero_charlas "Numero de charlas" (charlas_disponibles 60))


(deftemplate interes 0.0 10.0
  (
    (escaso (z 3.0 5.0))
    (medio (PI 2.0 5.0))
    (alto (s 5.0 7.0))
  ))

(deftemplate notoriedad 0.0 10.0 importancia
  (
    (poca (3.0 1.0)(5.0 0.0))
    (mucha (5.5 0.0)(10.0 1.0))
  ))

(deftemplate edad-fuzzy 0.0 100.0
  (
    (joven (15 1)(26 0))
    (madurito (23 0)(25 1)(30 1)(35 0))
    (adulto (30 0)(35 1)(55 1)(60 0))
    (prejubilado (50 0)(55 1))
  ))

(deftemplate ponente
  (slot nombre(type STRING))
  (slot edad (type FUZZY-VALUE edad-fuzzy))
)

(deftemplate intereses
  (slot tema(type SYMBOL)(allowed-symbols Tecnologia Medicina Ciencias Economia))
  (slot interes (type FUZZY-VALUE interes))
)

(deftemplate notoriedades
  (slot entidad(type STRING))
  (slot notoriedad (type FUZZY-VALUE notoriedad))
)
(deftemplate charlas_plantilla
  (slot nombre(type STRING))
  (slot edad(type INTEGER))
  (slot titulo_charla(type STRING))
  (slot tema_charla(type SYMBOL)(allowed-symbols Tecnologia Medicina Ciencias Economia))
  (slot entidad(type STRING))
  (slot edicion_techfest(type INTEGER))
)
(deftemplate charlapreSeleccionada
  (slot index(type INTEGER))
  (slot nombre (type STRING))
  (slot tema_charla(type SYMBOL)(allowed-symbols Tecnologia Medicina Ciencias Economia))
  (slot titulo_charla (type STRING))
  (slot entidad (type STRING))
  (slot seleccion (type SYMBOL)(allowed-symbols NopreSeleccionada preSeleccionada))
  (slot CF (type FLOAT))
)
(deftemplate charlasDefinitivas
  (slot index(type INTEGER))
  (slot nombre (type STRING))
  (slot CF (type FLOAT))
)

(deffacts personas
  (charlas_plantilla (nombre "Juan")(edad 42)(titulo_charla "iPhone")(tema_charla Tecnologia)(entidad "Uc3m")(edicion_techfest 2013))
  (charlas_plantilla (nombre "Luis")(edad 67)(titulo_charla "Cardio")(tema_charla Medicina)(entidad "BBVA")(edicion_techfest 2015))
  (charlas_plantilla (nombre "Pedro")(edad 50)(titulo_charla "La crisis economica")(tema_charla Economia)(entidad "Uc3m")(edicion_techfest 2016))
  (charlas_plantilla (nombre "Antonio")(edad 22)(titulo_charla "Pobreza")(tema_charla Economia)(entidad "Salesforce")(edicion_techfest 2015))
  (charlas_plantilla (nombre "Rigoberto")(edad 19)(titulo_charla "Dioxidos")(tema_charla Ciencias)(entidad "Uc3m")(edicion_techfest 2016))
  (charlas_plantilla (nombre "Lucia")(edad 34)(titulo_charla "Coches del siglo xx")(tema_charla Economia)(entidad "Uc3m")(edicion_techfest 2015))
  (charlas_plantilla (nombre "Cris")(edad 37)(titulo_charla "Rascacielos del siglo xxi")(tema_charla Economia)(entidad "Salesforce")(edicion_techfest 2014))
  (charlas_plantilla (nombre "Marta")(edad 50)(titulo_charla "Android")(tema_charla Tecnologia)(entidad "BBVA")(edicion_techfest 2014))
  (charlas_plantilla (nombre "Sara")(edad 20)(titulo_charla "Apple")(tema_charla Tecnologia)(entidad "IE")(edicion_techfest 2014))
  (charlas_plantilla (nombre "Isabel")(edad 18)(titulo_charla "El espacio")(tema_charla Ciencias)(entidad "Uc3m")(edicion_techfest 2015))
)

(deffacts charlas_seleccionadas
  (charlapreSeleccionada (index 1)(nombre "Juan")(tema_charla Tecnologia)(titulo_charla "iPhone")(entidad "Uc3m")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 2)(nombre "Luis")(tema_charla Medicina)(titulo_charla "Cardio")(entidad "BBVA")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 3)(nombre "Pedro")(tema_charla Economia)(titulo_charla "La crisis economica")(entidad "Uc3m")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 4)(nombre "Antonio")(tema_charla Economia)(titulo_charla "Pobreza")(entidad "Salesforce")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 5)(nombre "Rigoberto")(tema_charla Ciencias)(titulo_charla "Dioxidos")(entidad "Uc3m")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 6)(nombre "Lucia")(tema_charla Economia)(titulo_charla "Coches del siglo xx")(entidad "Uc3m")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 7)(nombre "Cris")(tema_charla Economia)(titulo_charla "Rascacielos del siglo xxi")(entidad "Salesforce")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 8)(nombre "Marta")(tema_charla Tecnologia)(titulo_charla "Android")(entidad "BBVA")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 9)(nombre "Sara")(tema_charla Tecnologia)(titulo_charla "Apple")(entidad "IE")(seleccion NopreSeleccionada))
  (charlapreSeleccionada (index 10)(nombre "Isabel")(tema_charla Ciencias)(titulo_charla "El espacio")(entidad "Uc3m")(seleccion NopreSeleccionada))
)

(deffacts interes_notoriedad
  (intereses (tema Tecnologia) (interes alto))
  (intereses (tema Medicina) (interes medio))
  (intereses (tema Ciencias) (interes alto))
  (intereses (tema Economia) (interes escaso))
  (notoriedades (entidad "Uc3m") (notoriedad mucha))
  (notoriedades (entidad "BBVA") (notoriedad mucha))
  (notoriedades (entidad "Salesforce") (notoriedad poca))
  (notoriedades (entidad "IE") (notoriedad poca))
)

(defrule fuzifica_edad
  (charlas_plantilla (nombre ?nom_candidata)(edad ?edad_candidata))
=>
  (assert
    (ponente (nombre ?nom_candidata)(edad (?edad_candidata 0) (?edad_candidata 1) (?edad_candidata 0)))
  )
)

(defrule preseleccion

  (charlapreSeleccionada (index ?indice)(nombre ?nom_preseleccionado)(titulo_charla ?tit_preseleccionado)(entidad ?entidad_preseleccionado)(tema_charla ?tem_preseleccionado)(seleccion ?seleccion & NopreSeleccionada))
  (notoriedades (entidad ?entidad_preseleccionado)(notoriedad ?notoriedad &  mucha))
  (intereses (tema ?tem_preseleccionado)(interes ?interes & somewhat alto))
  (ponente (nombre ?nom_preseleccionado)(edad joven))

=>
  (assert
    (charlapreSeleccionada
      (index ?indice)
      (nombre ?nom_preseleccionado)
      (titulo_charla ?tit_preseleccionado)
      (entidad ?entidad_preseleccionado)
      (tema_charla ?tem_preseleccionado)
      (seleccion preSeleccionada)

    )
  )

  ;(printout t "El ponente " ?nom_preseleccionado ", " ?entidad_preseleccionado " nototierdad: " ?notoriedad " intereses " ?interes " seleccion: " crlf)
)


(defrule getCF
  ?f<-(charlapreSeleccionada (index ?indice) (nombre ?nom_preseleccionado)(titulo_charla ?tit_preseleccionado)(entidad ?entidad_preseleccionado)(tema_charla ?tem_preseleccionado)(seleccion ?seleccion & preSeleccionada))

=>
  (assert
    (charlapreSeleccionada
      (index ?indice)
      (nombre ?nom_preseleccionado)
      (titulo_charla ?tit_preseleccionado)
      (entidad ?entidad_preseleccionado)
      (tema_charla ?tem_preseleccionado)
      (seleccion preSeleccionada)
      (CF (get-cf ?f))
    )
  )

  (printout t "El ponente " ?nom_preseleccionado ", " ?entidad_preseleccionado  " seleccion: " ?seleccion "" (get-cf ?f) crlf)
)

(defrule ordenarPreSeleccion
  (charlapreSeleccionada
    (index ?indice)
    (nombre ?nom_preseleccionado)
    (titulo_charla ?tit_preseleccionado)
    (entidad ?entidad_preseleccionado)
    (tema_charla ?tem_preseleccionado)
    (seleccion preSeleccionada)
    (CF ?cf1)
  )
  (forall
    (charlapreSeleccionada
      (index ?indice2)
      (nombre ?nom_preseleccionado2)
      (titulo_charla ?tit_preseleccionado2)
      (entidad ?entidad_preseleccionado2)
      (tema_charla ?tem_preseleccionado2)
      (seleccion preSeleccionada)
      (CF ?cf2)
    )

    ?f1 <- (charlapreSeleccionada (index ?indice) (value ?cf1))
    ?f2 <- (charlapreSeleccionada2 (index ?indice2 &:(= ?indice2 (+ ?indice 1)))  (value ?cf2 &:(< ?cf2 ?cf1)))

  )
=>
  (modify ?f1 (index ?indice2)(nombre ?nom_preseleccionado2)(titulo_charla ?tit_preseleccionado2)(entidad ?entidad_preseleccionado2)(tema_charla ?tem_preseleccionado2)(seleccion preSeleccionada)(value ?cf2))

  (modify ?f2 (index ?indice)(nombre ?nom_preseleccionado)(titulo_charla ?tit_preseleccionado)(entidad ?entidad_preseleccionado)(tema_charla ?tem_preseleccionado)(seleccion preSeleccionada)(value ?cf1))
)


(defrule seleccionados
  ?preseleccion<-(charlapreSeleccionada
  (index ?indice)
  (nombre ?nom_preseleccionado)
  (titulo_charla ?tit_preseleccionado)
  (entidad ?entidad_preseleccionado)
  (tema_charla ?tem_preseleccionado)
  (seleccion preSeleccionada)
  (CF ?cf1)
)

=>
  (modify ?preseleccion
  (index ?indice)
  (nombre ?nom_preseleccionado)
  (titulo_charla ?tit_preseleccionado)
  (entidad ?entidad_preseleccionado)
  (tema_charla ?tem_preseleccionado)
  (seleccion Seleccionada)
  (CF ?cf1)

  )
  (printout t "El ponente " ?nom_preseleccionado ", " ?indice ", " ?cf1 crlf)
)
