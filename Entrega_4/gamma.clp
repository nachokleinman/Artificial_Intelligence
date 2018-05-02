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
(deftemplate charlaSeleccionada
  (slot nombre (type STRING))
  (slot tema_charla(type SYMBOL)(allowed-symbols Tecnologia Medicina Ciencias Economia))
  (slot titulo_charla (type STRING))
  (slot entidad (type STRING))
  (slot seleccion (type SYMBOL)(allowed-symbols NoSeleccionada Seleccionada))
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
  (charlaSeleccionada (nombre "Juan")(tema_charla Tecnologia)(titulo_charla "iPhone")(entidad "Uc3m")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Luis")(tema_charla Medicina)(titulo_charla "Cardio")(entidad "BBVA")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Pedro")(tema_charla Economia)(titulo_charla "La crisis economica")(entidad "Uc3m")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Antonio")(tema_charla Economia)(titulo_charla "Pobreza")(entidad "Salesforce")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Rigoberto")(tema_charla Ciencias)(titulo_charla "Dioxidos")(entidad "Uc3m")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Lucia")(tema_charla Economia)(titulo_charla "Coches del siglo xx")(entidad "Uc3m")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Cris")(tema_charla Economia)(titulo_charla "Rascacielos del siglo xxi")(entidad "Salesforce")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Marta")(tema_charla Tecnologia)(titulo_charla "Android")(entidad "BBVA")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Sara")(tema_charla Tecnologia)(titulo_charla "Apple")(entidad "IE")(seleccion NoSeleccionada))
  (charlaSeleccionada (nombre "Isabel")(tema_charla Ciencias)(titulo_charla "El espacio")(entidad "Uc3m")(seleccion NoSeleccionada))
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
  (charlaSeleccionada (nombre ?nom_preseleccionado)(titulo_charla ?tit_preseleccionado)(entidad ?entidad_preseleccionado)(tema_charla ?tem_preseleccionado)(seleccion ?seleccion & NoSeleccionada))

  (notoriedades (entidad ?entidad_preseleccionado)(notoriedad ?notoriedad &  mucha))
  (intereses (tema ?tem_preseleccionado)(interes ?interes & somewhat alto))
  (ponente (nombre ?nom_preseleccionado)(edad joven))

=>
  (assert(charlaSeleccionada (nombre ?nom_preseleccionado)(titulo_charla ?tit_preseleccionado)(entidad ?entidad_preseleccionado)(tema_charla ?tem_preseleccionado)(seleccion Seleccionada)))

  (printout t "El ponente " ?nom_preseleccionado ", " ?entidad_preseleccionado " nototierdad: " ?notoriedad " intereses " ?interes " seleccion: " ?seleccion crlf)
)
