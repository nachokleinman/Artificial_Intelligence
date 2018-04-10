;made by @ignacioLavina and @ignaciokleinman

;Entrega 1 Objetivo: familiarizar se con CLIPS, razonamiento clásico sin nada fuzzy)

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

;
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
    (edad 48)
    (titulo_charla "iPhone2")
    (tema_charla Tecnologia)
    (entidad "IEF")
    (edicion_techfest 2014)
  )
)
(deffacts charla10
  (charlas_plantilla
    (nombre "Juan")
    (edad 26)
    (titulo_charla "espacio")
    (tema_charla Ciencias)
    (entidad "URJC")
    (edicion_techfest 2015)
  )
)




;Entrega 2 Objetivo: Definición de plantillas y hechos borrosos
; 1. Definir una plantilla (template) para declarar hechos borrosos sobre el (escaso,
; medio y alto) interés de un tema utilizando las funciones z, pi y s respectivamente.

(deftemplate interes 0.0 10.0
  (
    (escaso (z 3.0 5.0))
    (medio (PI 2.0 5.0))
    (alto (s 5.0 7.0))
  ))

; 2. Definir una plantilla para declarar hechos borrosos sobre la (poca y mucha)
; notoriedad de una entidad usando una definición por puntos.

(deftemplate notoriedad 0.0 10.0 importancia
  (
    (poca (4.0 1.0)(7.5 0.0))
    (mucha (6.8 0.0)(10.0 1.0))
  ))

; 3. Definir una plantilla (template) para declarar hechos borrosos sobre la edad
; del ponente (joven, madurito, adulto, prejubilado) utilizando una definición por puntos.

(deftemplate edad-fuzzy 0.0 100.0
  (
    (joven (15 1)(26 0))
    (madurito (23 0)(25 1)(30 1)(35 0))
    (adulto (30 0)(35 1)(55 1)(60 0))
    (prejubilado (50 0)(55 1))
  ))

; 4. Declarar el interés de cada tema propuesto como hechos borrosos usando la plantilla
; del apartado 2.0. Por ejemplo, debéis declarar hechos como que el interés del
; tema blockchain es escaso y el de los videojuegos alto.

(deftemplate intereses
  (slot tema(type SYMBOL)(allowed-symbols Tecnologia Medicina Ciencias Economia))
  (slot interes (type FUZZY-VALUE interes))
)

; 5.	Declarar la notoriedad de cada entidad a la que pertenece el ponente usando
; la plantilla del aparatado 2-1. Por ejemplo, debéis declarar hechos como que
; la notoriedad de la entidad Electrónica Arts. es mucha.

(deftemplate notoriedades
  (slot entidad(type STRING))
  (slot notoriedad (type FUZZY-VALUE notoriedad))
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



;Entrega 3 Objetivo: Definir reglas con antecedente borroso, uso de modificadores




;Regla con la logica
(defrule controlador_charlas
  ;Solo introduce charlas mientras haya huecos disponibles
  ?hecho <- (charlas_disponibles ?x)
  (test(> ?x 0))

  ;usamos una plantilla para manejar las reglas
  (charlas_plantilla
    (nombre ?nom_candidata)
    (edad ?edad_candidata)
    (titulo_charla ?tit_candidata)
    (edicion_techfest ?edi_candidata)
    (entidad ?entidad_candidata)
    (tema_charla ?tem_candidata)
  )



(forall
    ;recogemos los datos de las charlas que ya están seleccionadas
    (escogida ?nom_seleccionada ?edad_seleccionada ?tit_seleccionada ?tem_seleccionada ?entidad_seleccionada ?edi_seleccionada)
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
  ;escoge temas de notoriedad no poca
  (notoriedades (entidad ?entidad_candidata) (notoriedad not poca))
  ;escoge temas de interés alto o medio
  (intereses(tema ?tem_candidata)(interes medio or alto))
=>
  ;reducimos charlas disponibles
  (retract ?hecho)
  (assert (charlas_disponibles (- ?x 1)))
  ;creamos un nuevo hecho con una charla ya seleccionada
  (assert (escogida ?nom_candidata ?edad_candidata ?tit_candidata ?tem_candidata ?entidad_candidata ?edi_candidata))
  ;imprimimos por pantalla la charla que ha sido seleccionada y el numero restante de charlas disponibles
  (printout t "Se introduce la charla " ?tit_candidata ", con ponente: " ?nom_candidata ", de edad" ?edad_candidata ", tema: " ?tem_candidata ", entidad: " ?entidad_candidata ", de la dicion: " ?edi_candidata ". Quedan " (- ?x 1) " charlas disponibles."  crlf)
)

; funcion

  (fuzzy-intersection
    (create-fuzzy-value interes alto)
    (create-fuzzy-value interes medio)
  )
  alta and medio

  (plot-fuzzy-value t "-+." nil nil
  (create-fuzzy-value interes alto)
  (create-fuzzy-value interes medio)
  (fuzzy-intersection
    (create-fuzzy-value interes alto)
    (create-fuzzy-value interes medio)
    )
  )

  (fuzzy-intersection
    (create-fuzzy-value interes medio)
    (create-fuzzy-value interes escaso)
  )
  medio and escaso

  (plot-fuzzy-value t "$&*" nil nil
  (create-fuzzy-value interes medio)
  (create-fuzzy-value interes escaso)
  (fuzzy-intersection
    (create-fuzzy-value interes medio)
    (create-fuzzy-value interes escaso)
    )
  )

  (fuzzy-intersection
    (create-fuzzy-value notoriedad not poca)
    (create-fuzzy-value notoriedad mucha)
  )
  not poca and mucha

  (plot-fuzzy-value t ".+*" nil nil
  (create-fuzzy-value notoriedad not poca)
  (create-fuzzy-value notoriedad mucha)
  (fuzzy-intersection
    (create-fuzzy-value notoriedad not poca)
    (create-fuzzy-value notoriedad mucha)
    )
  )



(reset)
(run)
(facts)


;3.2 Definir una regla que incluya en el techfest a las charlas cuya entidad sea
;de no poca notoriedad (modificador not), de interés medio o alto (or), cuyos temas
;no hayan sido seleccionados previamente sin superar el máximo número de charlas del
;techfest. Nota: consiste en modificar la regla del apartado 1.2 incluyendo dos nuevos antecedente.
;Ejecutarla cómo única regla y observar qué ocurre.

;Fuzzy Value: interes
;Linguistic Value: alto (-),  medio (+),  [ alto ] AND [ medio ] (.)

; 1.00                         +        -----------------
; 0.95                        + +      -
; 0.90                       +   +    -
; 0.85                               -
; 0.80                      +     +
; 0.75                              -
; 0.70                             -
; 0.65                     +       .
; 0.60
; 0.55                            .
; 0.50                    +         .
; 0.45                           .
; 0.40
; 0.35                   +      .    .
; 0.30
; 0.25                         .
; 0.20                  +             .
; 0.15                        .
; 0.10                 +     .         .
; 0.05                +     .           .
; 0.00......................             ................
;     |----|----|----|----|----|----|----|----|----|----|
;    0.00      2.00      4.00      6.00      8.00     10.00

;Universe of Discourse:  From   0.00  to   10.00

;Fuzzy Value: interes
;Linguistic Value: medio ($),  escaso (&),  [ medio ] AND [ escaso ] (*)

; 1.00&&&&&&&&&&&&&&&&         $
; 0.95                &       $ $
; 0.90                 &     $   $
; 0.85
; 0.80                  &   $     $
; 0.75
; 0.70
; 0.65                   & $       $
; 0.60
; 0.55
; 0.50                    *         $
; 0.45
; 0.40
; 0.35                   *           $
; 0.30                     *
; 0.25
; 0.20                  *   *         $
; 0.15
; 0.10                 *     *         $
; 0.05                *                 $
; 0.00****************        ***************************
;     |----|----|----|----|----|----|----|----|----|----|
;    0.00      2.00      4.00      6.00      8.00     10.00

;Universe of Discourse:  From   0.00  to   10.00

;Fuzzy Value: notoriedad
;Linguistic Value: not poca (.),  mucha (+),  [ not poca ] AND [ mucha ] (*)

; 1.00                     ........................******
; 0.95                    .                       *
; 0.90                   .                       *
; 0.85                                          *
; 0.80                  .
; 0.75                 .                       *
; 0.70                .                       *
; 0.65               .                       *
; 0.60                                      *
; 0.55              .                      *
; 0.50             .                      *
; 0.45            .                      *
; 0.40
; 0.35           .                      *
; 0.30          .                      *
; 0.25         .                      *
; 0.20        .                      *
; 0.15                              *
; 0.10       .                     *
; 0.05      .                     *
; 0.00****************************
;     |----|----|----|----|----|----|----|----|----|----|
;    0.00      2.00      4.00      6.00      8.00     10.00
;
;Universe of Discourse:  From   0.00  to   10.00

;f-35    (noto Economia) CF 0.25
;f-36    (noto Ciencias) CF 0.25
;f-37    (noto Medicina) CF 1.00
;f-38    (noto Tecnologia) CF 1.00
;f-39    (interes1 Economia) CF 0.25
;f-40    (interes1 Ciencias) CF 1.00
;f-41    (interes1 Medicina) CF 1.00
;f-42    (interes1 Tecnologia) CF 1.00


;(escogida "Juan" "La economia" Economia 2013) CF 0.25
;f-22    (escogida "Juan" "espacio" Ciencias 2015) CF 0.25
;f-24    (escogida "Miguel" "iPhone2" Tecnologia 2014) CF 0.25
;f-26    (escogida "Miguel" "Mujercitas" Economia 2014) CF 0.25
;f-28    (escogida "Miguel" "Mujercitas" Economia 2015) CF 0.25
;f-30    (escogida "Rigoberto" "Mujercitas" Medicina 2016) CF 0.25
;f-32    (escogida "Pedro" "IA mola" Economia 2016) CF 0.25
;f-33    (charlas_disponibles 52) CF 0.25
;f-34    (escogida "Pedro" "La economia" Economia 2015) CF 0.25
