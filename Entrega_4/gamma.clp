;made by @ignacioLavina and @ignaciokleinman

(deffacts numero_charlas "Numero de charlas" (charlas_disponibles 60))

(deftemplate charlas_plantilla
  (slot nombre(type STRING))
  (slot edad(type INTEGER))
  (slot titulo_charla(type STRING))
  (slot tema_charla(type SYMBOL)(allowed-symbols Tecnologia Medicina Ciencias Economia))
  (slot entidad(type STRING))
  (slot edicion_techfest(type INTEGER))
)


(deffacts charla1
  (charlas_plantilla
    (nombre "Juan")
    (edad 42)
    (titulo_charla "La economia")
    (tema_charla Economia)
    (entidad "Uc3m")
    (edicion_techfest 2013)
  )
)
(deffacts charla2
  (charlas_plantilla
    (nombre "Pedro")
    (edad 67)
    (titulo_charla "La economia")
    (tema_charla Economia)
    (entidad "BBVA")
    (edicion_techfest 2015)
  )
)

(deffacts charla3
  (charlas_plantilla
    (nombre "Pedro")
    (edad 50)
    (titulo_charla "IA mola")
    (tema_charla Economia)
    (entidad "Uc3m")
    (edicion_techfest 2016)
  )
)
(deffacts charla4
  (charlas_plantilla
    (nombre "Pedro")
    (edad 40)
    (titulo_charla "IA mola")
    (tema_charla Economia)
    (entidad "Salesforce")
    (edicion_techfest 2015)
  )
)

(deffacts charla5
  (charlas_plantilla
    (nombre "Rigoberto")
    (edad 26)
    (titulo_charla "Mujercitas")
    (tema_charla Medicina)
    (entidad "IE")
    (edicion_techfest 2016)
  )
)

(deffacts charla6
  (charlas_plantilla
    (nombre "Miguel")
    (edad 34)
    (titulo_charla "Mujercitas")
    (tema_charla Economia)
    (entidad "Politecnica")
    (edicion_techfest 2015)
  )
)

(deffacts charla7
  (charlas_plantilla
    (nombre "Miguel")
    (edad 37)
    (titulo_charla "Mujercitas")
    (tema_charla Economia)
    (entidad "Publica")
    (edicion_techfest 2014)
  )
)
(deffacts charla8
  (charlas_plantilla
    (nombre "Miguel")
    (edad 50)
    (titulo_charla "iPhone")
    (tema_charla Tecnologia)
    (entidad "BusinesSchool")
    (edicion_techfest 2014)
  )
)
(deffacts charla9
  (charlas_plantilla
    (nombre "Miguel")
    (edad 20)
    (titulo_charla "iPhone2")
    (tema_charla Tecnologia)
    (entidad "IEF")
    (edicion_techfest 2014)
  )
)
(deffacts charla10
  (charlas_plantilla
    (nombre "Juan")
    (edad 18)
    (titulo_charla "espacio")
    (tema_charla Ciencias)
    (entidad "URJC")
    (edicion_techfest 2015)
  )
)



(deftemplate interes 0.0 10.0
  (
    (escaso (z 3.0 5.0))
    (medio (PI 2.0 5.0))
    (alto (s 5.0 7.0))
  ))

(deftemplate notoriedad 0.0 10.0 importancia
  (
    (poca (4.0 1.0)(7.5 0.0))
    (mucha (6.8 0.0)(10.0 1.0))
  ))

(deftemplate edad-fuzzy 0.0 100.0
  (
    (joven (15 1)(26 0))
    (madurito (23 0)(25 1)(30 1)(35 0))
    (adulto (30 0)(35 1)(55 1)(60 0))
    (prejubilado (50 0)(55 1))
  ))

(deftemplate intereses
  (slot tema(type SYMBOL)(allowed-symbols Tecnologia Medicina Ciencias Economia))
  (slot interes (type FUZZY-VALUE interes))
)

(deftemplate notoriedades
  (slot entidad(type STRING))
  (slot notoriedad (type FUZZY-VALUE notoriedad))
)

(deftemplate ponente
  (slot nombre(type STRING))
  (slot edad (type FUZZY-VALUE edad-fuzzy))
)

(deffacts fuzzy-datos
  (intereses (tema Tecnologia) (interes alto))
  (intereses (tema Medicina) (interes medio))
  (intereses (tema Ciencias) (interes alto))
  (intereses (tema Economia) (interes escaso))
  (notoriedades (entidad "Uc3m") (notoriedad mucha))
  (notoriedades (entidad "BBVA") (notoriedad mucha))
  (notoriedades (entidad "Salesforce") (notoriedad poca))
  (notoriedades (entidad "IE") (notoriedad poca))
  (notoriedades (entidad "Politecnica") (notoriedad poca))
  (notoriedades (entidad "Publica") (notoriedad poca))
  (notoriedades (entidad "BusinesSchool") (notoriedad poca))
  (notoriedades (entidad "IEF") (notoriedad poca))
  (notoriedades (entidad "URJC") (notoriedad poca))
)

;Entrega 4 Objetivo: Observar y manejar CF de consecuente concreto con antecedente
;borroso equiparado con valor concreto

;4.0 Definir una regla que concluya una preselección (ojo: no selección definitiva)
;en el techfest a las charlas cuyo ponente sea joven, cuya entidad sea de mucha
;notoriedad y de interés más o menos alto. Nota: consiste en modificar la regla del apartado 3.2

(defrule fuzifica_edad
  (ponente
    (nombre ?nombre)
    (edad ?edad)
  )
=>
  (assert
    (ponente
      (nombre ?nombre)
      (edad (?edad 0) (?edad 1) (?edad 0))
    )
  )
)

(defrule preseleccion
  (charlas_plantilla
    (nombre ?nom_candidata)
    (edad ?edad_candidata)
    (titulo_charla ?tit_candidata)
    (edicion_techfest ?edi_candidata)
    (entidad ?entidad_candidata)
    (tema_charla ?tem_candidata)
  )

  (notoriedades
    (entidad ?entidad_candidata)
    (notoriedad mucha)
  )

  (intereses
    (tema ?tem_candidata)
    (interes somewhat alto)
  )

  (ponente
    (nombre ?nom_candidata)
    (edad joven)
  )

=>
  (assert (preseleccionada ?nom_candidata ?edad_candidata ?tit_candidata ?tem_candidata ?entidad_candidata ?edi_candidata))
  (printout t "Se introduce la charla " ?tit_candidata ", con ponente: " ?nom_candidata ", de edad" ?edad_candidata ", tema: " ?tem_candidata)
)
