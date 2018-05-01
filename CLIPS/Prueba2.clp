(deffacts numero_charlas "Numero de charlas en una determinada techfest"
(charlas_disponibles 6))

(deffacts primera_charla_escogida "Boolean para conocer si la primera charla ya está escogida"
(primera_charla 1))

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
    (titulo_charla "La economia")
    (tema_charla Economia)
    (edicion_techfest 2013)
  )
)

(deffacts charla2
  (charlas_plantilla
    (nombre "Pedro")
    (titulo_charla "La ciencia")
    (tema_charla Economia)
    (edicion_techfest 2015)
  )
)

(deffacts charla3
  (charlas_plantilla
    (nombre "Pedro")
    (titulo_charla "IA mola")
    (tema_charla Economia)
    (edicion_techfest 2015)
  )
)(deffacts charla4
  (charlas_plantilla
    (nombre "Pedro")
    (titulo_charla "IA mola")
    (tema_charla Economia)
    (edicion_techfest 2015)
  )
)

; esta charla es igual en datos que la anterior. para comprobar que no mete repetidas
(deffacts charla8
  (charlas_plantilla
    (nombre "Luis")
    (titulo_charla "Mujercitas")
    (tema_charla Economia)
    (edicion_techfest 2015)
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




(defrule controlador_charlas

  ?hecho <- (charlas_disponibles ?x)
  (test(> ?x 0))

  (charlas_plantilla
    (nombre ?nomB)
    (titulo_charla ?titB)
    (edicion_techfest ?ediB)
    (tema_charla ?temB)
  )

(forall
    (escogida ?nomA ?titA ?temA ?ediA)
    
    (test (or(or(neq ?temA ?temB)(and(eq ?temA ?temB)(neq ?nomA ?nomB)))(neq ?ediA ?ediB)))
)


 ; esto puede ser interesante -> (test (and (neq ?color red) (neq ?color blue)))

=>
  (retract ?hecho)
  (assert (charlas_disponibles (- ?x 1)))
  (assert (escogida ?nomB ?titB ?temB ?ediB))
  (printout t "charla " ?titB ", ponente: " ?nomB " tema: " ?temB ", Edicion: " ?ediB crlf)
)
