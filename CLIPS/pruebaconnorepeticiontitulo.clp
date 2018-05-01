;Insertamos el numero total de charlas
(deffacts numero_charlas "Numero de charlas" (charlas_disponibles 60))

;Plantilla para toda charla
(deftemplate charlas_plantilla
  (slot nombre(type STRING))
  (slot edad(type INTEGER))
  (slot titulo_charla(type STRING))
  (slot tema_charla(type SYMBOL)(allowed-symbols Tecnologia Medicina Ciencias Economia))
  (slot entidad(type STRING))
  (slot edicion_techfest(type INTEGER))
)

;No hemos considerado necesario introducir entidad y edad ya que no son
;necesarias para resolver la primera entrega

;Listado de ejemplos con todos los casos mas extremos
;La charla 2 y 3 son del mismo ponente hablando del mismo tema, por tanto, solo mostrará una de ellas.
;La charla 3 y 4 son dadas por la misma persona, con el mismo nombre y tema, pero al ser de ediciones distintas, las deja pasar.
;La charla 7 y 8 son del mismo hombre en la misma edicion pero con tema y titulo distintos, por tanto, es correcto.


(deffacts charla1
  (charlas_plantilla
    (nombre "Juan")
    (titulo_charla "La economia")
    (tema_charla Economia)
    (edicion_techfest 2013)
  )
)
(deffacts charla2
  (charlas_plantilla
    (nombre "Pedro")
    (titulo_charla "La economia")
    (tema_charla Economia)
    (edicion_techfest 2015)
  )
)

(deffacts charla3
  (charlas_plantilla
    (nombre "Pedro")
    (titulo_charla "IA mola")
    (tema_charla Economia)
    (edicion_techfest 2016)
  )
)(deffacts charla4
  (charlas_plantilla
    (nombre "Pedro")
    (titulo_charla "IA mola")
    (tema_charla Economia)
    (edicion_techfest 2015)
  )
)

(deffacts charla5
  (charlas_plantilla
    (nombre "Rigoberto")
    (titulo_charla "Mujercitas")
    (tema_charla Medicina)
    (edicion_techfest 2016)
  )
)

(deffacts charla6
  (charlas_plantilla
    (nombre "Miguel")
    (titulo_charla "Mujercitas")
    (tema_charla Economia)
    (edicion_techfest 2015)
  )
)

(deffacts charla7
  (charlas_plantilla
    (nombre "Miguel")
    (titulo_charla "Mujercitas")
    (tema_charla Economia)
    (edicion_techfest 2014)
  )
)
(deffacts charla8
  (charlas_plantilla
    (nombre "Miguel")
    (titulo_charla "iPhone")
    (tema_charla Tecnologia)
    (edicion_techfest 2014)
  )
)
(deffacts charla8
  (charlas_plantilla
    (nombre "Miguel")
    (titulo_charla "iPhone2")
    (tema_charla Tecnologia)
    (edicion_techfest 2014)
  )
)


;Regla con la logica
(defrule controlador_charlas

  ;Solo introduce charlas mientras haya huecos disponibles
  ?hecho <- (charlas_disponibles ?x)
  (test(> ?x 0))

  ;usamos una plantilla para manejar las reglas
  (charlas_plantilla
    (nombre ?nom_candidata)
    (titulo_charla ?tit_candidata)
    (edicion_techfest ?edi_candidata)
    (tema_charla ?tem_candidata)
  )

(forall
    ;recogemos los datos de las charlas que ya están seleccionadas
    (escogida ?nom_seleccionada ?tit_seleccionada ?tem_seleccionada ?edi_seleccionada)
    (test
      (or
        ;si las ediciones son diferentes no hace falta controlar nada (puede haber misma charla en diferentes ediciones)
        (neq ?edi_seleccionada ?edi_candidata)

        ;si es la misma edición, controlamos...
        (and
          ;controlamos que no haya charlas con el mismo titulo de charla
          (neq ?tit_seleccionada ?tit_candidata)
          ;o que en caso contrario...
          (or
            ;que sean de diferente tema
            (neq ?tem_seleccionada ?tem_candidata)
            ;o que sean del mismo tema, pero diferente ponente
            (and(eq ?tem_seleccionada ?tem_candidata)(neq ?nom_seleccionada ?nom_candidata))
          )
        )
      )
    )
  )
=>
  ;reducimos charlas disponibles
  (retract ?hecho)
  (assert (charlas_disponibles (- ?x 1)))
  ;creamos un nuevo hecho con una charla ya seleccionada
  (assert (escogida ?nom_candidata ?tit_candidata ?tem_candidata ?edi_candidata))
  ;imprimimos por pantalla la charla que ha sido seleccionada y el numero restante de charlas disponibles
  (printout t "Se introduce la charla " ?tit_candidata ", con ponente: " ?nom_candidata ", tema: " ?tem_candidata ", de la dicion: " ?edi_candidata ". Quedan " (- ?x 1) " charlas disponibles."  crlf)
)
