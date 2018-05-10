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
  ;(charlas_plantilla (nombre "Juan")(edad 42)(titulo_charla "iPhone")(tema_charla Tecnologia)(entidad "Uc3m")(edicion_techfest 2013))
  ;(charlas_plantilla (nombre "Luis")(edad 67)(titulo_charla "Cardio")(tema_charla Medicina)(entidad "BBVA")(edicion_techfest 2015))
  ;(charlas_plantilla (nombre "Pedro")(edad 50)(titulo_charla "La crisis economica")(tema_charla Economia)(entidad "Uc3m")(edicion_techfest 2016))
  ;(charlas_plantilla (nombre "Antonio")(edad 20)(titulo_charla "Pobreza")(tema_charla Ciencias)(entidad "Uc3m")(edicion_techfest 2015))
  ;(charlas_plantilla (nombre "Rigoberto")(edad 19)(titulo_charla "Dioxidos")(tema_charla Ciencias)(entidad "Uc3m")(edicion_techfest 2016))
  ;(charlas_plantilla (nombre "Lucia")(edad 34)(titulo_charla "Coches del siglo xx")(tema_charla Economia)(entidad "Uc3m")(edicion_techfest 2015))
  ;(charlas_plantilla (nombre "Cris")(edad 37)(titulo_charla "Rascacielos del siglo xxi")(tema_charla Economia)(entidad "Salesforce")(edicion_techfest 2014))
  ;(charlas_plantilla (nombre "Marta")(edad 50)(titulo_charla "Android")(tema_charla Tecnologia)(entidad "BBVA")(edicion_techfest 2014))
  ;(charlas_plantilla (nombre "Sara")(edad 20)(titulo_charla "Apple")(tema_charla Tecnologia)(entidad "IE")(edicion_techfest 2014))
  (charlas_plantilla (nombre "Isabel")(edad 18)(titulo_charla "El espacio")(tema_charla Ciencias)(entidad "Uc3m")(edicion_techfest 2015))
)

(deffacts charlas_seleccionadas
  ;(charlapreSeleccionada (index 1)(nombre "Juan")(tema_charla Tecnologia)(titulo_charla "iPhone")(entidad "Uc3m")(seleccion NopreSeleccionada))
  ;(charlapreSeleccionada (index 2)(nombre "Luis")(tema_charla Medicina)(titulo_charla "Cardio")(entidad "BBVA")(seleccion NopreSeleccionada))
  ;(charlapreSeleccionada (index 3)(nombre "Pedro")(tema_charla Economia)(titulo_charla "La crisis economica")(entidad "Uc3m")(seleccion NopreSeleccionada))
  ;(charlapreSeleccionada (index 4)(nombre "Antonio")(tema_charla Economia)(titulo_charla "Pobreza")(entidad "Uc3m")(seleccion NopreSeleccionada))
  ;(charlapreSeleccionada (index 5)(nombre "Rigoberto")(tema_charla Ciencias)(titulo_charla "Dioxidos")(entidad "Uc3m")(seleccion NopreSeleccionada))
  ;(charlapreSeleccionada (index 6)(nombre "Lucia")(tema_charla Economia)(titulo_charla "Coches del siglo xx")(entidad "Uc3m")(seleccion NopreSeleccionada))
  ;(charlapreSeleccionada (index 7)(nombre "Cris")(tema_charla Economia)(titulo_charla "Rascacielos del siglo xxi")(entidad "Salesforce")(seleccion NopreSeleccionada))
  ;(charlapreSeleccionada (index 8)(nombre "Marta")(tema_charla Tecnologia)(titulo_charla "Android")(entidad "BBVA")(seleccion NopreSeleccionada))
  ;(charlapreSeleccionada (index 9)(nombre "Sara")(tema_charla Tecnologia)(titulo_charla "Apple")(entidad "IE")(seleccion NopreSeleccionada))
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

(deffacts contador_preselecionados (contador 1))

(defrule fuzifica_edad
  (charlas_plantilla (nombre ?nom_candidata)(edad ?edad_candidata))
=>
  (assert (ponente (nombre ?nom_candidata)(edad (?edad_candidata 0) (?edad_candidata 1) (?edad_candidata 0))))
)

;--------NOTORIEDADES-----------

(defrule preseleccion1
  ?x<-(charlas_plantilla (nombre ?nom_preseleccionado)(edad ?edad)(titulo_charla ?tit_preseleccionado)(entidad ?entidad_preseleccionado)(tema_charla ?tem_preseleccionado)(edicion_techfest ?edicion))
  (notoriedades (entidad ?entidad_preseleccionado)(notoriedad mucha))

  (forall
    (presel_notoriedad: ?nom_ch ?ano)
    (charlas_plantilla(nombre ?nom)(titulo_charla ?tit)(edad ?year)(entidad ?ent)(tema_charla ?tem)(edicion_techfest ?edicion))
    (or(test(not(eq ?tem_preseleccionado ?tem)))(test(not(eq ?nom_preseleccionado ?nom))))
  )

=>
  (retract ?x)
  (assert (presel ?tit_preseleccionado ?edicion ?entidad_preseleccionado))
  (assert (presel_notoriedad ?tit_preseleccionado ?edicion ?entidad_preseleccionado))
  (printout t "charla1 " ?tit_preseleccionado " preseleccionada de la edicion " ?edicion crlf)
)


;--------INTERESES-----------


(defrule preseleccion2
  ?x<-(charlas_plantilla (nombre ?nom_preseleccionado)(edad ?edad)(titulo_charla ?tit_preseleccionado)(entidad ?entidad_preseleccionado)(tema_charla ?tem_preseleccionado)(edicion_techfest ?edicion))
  (intereses (tema ?tem_preseleccionado)(interes somewhat alto))

  (forall
    (presel_interes: ?nom_ch ?ano)
    (charlas_plantilla (nombre ?nom)(titulo_charla ?tit)(edad ?year)(entidad ?ent)(tema_charla ?tem)(edicion_techfest ?edicion))
    (or(test(not(eq ?tem_preseleccionado ?tem)))(test(not(eq ?nom_preseleccionado ?nom))))
  )

=>
  (retract ?x)
  (assert (presel ?tit_preseleccionado ?edicion ?tem_preseleccionado))
  (assert (presel_interes ?tit_preseleccionado ?edicion ?tem_preseleccionado))
  (printout t "charla2 " ?tit_preseleccionado " preseleccionada de la edicion " ?edicion crlf)
)


;--------EDAD PONENTES-----------

(defrule preseleccion3
  ?x<-(charlas_plantilla (nombre ?nom_preseleccionado)(edad ?edad)(titulo_charla ?tit_preseleccionado)(entidad ?entidad_preseleccionado)(tema_charla ?tem_preseleccionado)(edicion_techfest ?edicion))
  (ponente (nombre ?nom_preseleccionado)(edad joven))

  (forall
    (presel_edad: ?nom_ch ?ano)
    (charlas_plantilla (nombre ?nom)(titulo_charla ?tit)(edad ?year)(entidad ?ent)(tema_charla ?tem)(edicion_techfest ?edicion))
    (or(test(not(eq ?tem_preseleccionado ?tem)))(test(not(eq ?nom_preseleccionado ?nom))))
  )

=>
  (retract ?x)
  (assert (presel ?tit_preseleccionado ?edicion ?nom_preseleccionado))
  (assert (presel_edad ?tit_preseleccionado ?edicion ?nom_preseleccionado))
  (printout t "charla3 " ?tit_preseleccionado " preseleccionada de la edicion " ?edicion crlf)
)


(defrule getCF
  ?f1<-(presel ?tit_preseleccionado ?edicion)
  ?f2<-(presel_notoriedad ?tit_preseleccionado ?edicion)
  ?f3<-(presel_interes ?tit_preseleccionado ?edicion)
  ?f4<-(presel_edad ?tit_preseleccionado ?edicion)
  ?i<-(contador ?x)
=>
  (assert (charlapreSeleccionada (index ?x) (titulo_charla ?tit_preseleccionado) (CF (get-cf ?f))))
  (retract ?i)
  (assert (contador(+ ?x 1)))
  (retract ?f2)
  (retract ?f3)
  (retract ?f4)
)

(defrule ordenarPreSeleccion
  (not (presel ?tit_preseleccionado ?edicion))
  (not (presel_notoriedad ?tit_preseleccionado ?edicion))
  (not (presel_interes ?tit_preseleccionado ?edicion))
  (not (presel_edad ?tit_preseleccionado ?edicion))

  ?f1 <- (charlapreSeleccionada (index ?indice) (CF ?cf) (titulo_charla ?tit_preseleccionado))
  ?f2 <- (charlapreSeleccionada (index ?indice2 &:(= ?indice2 (+ ?indice 1))) (CF ?cf2&:(> ?cf2 ?cf)) (titulo_charla ?tit_preseleccionado2))
=>
  (modify ?f1 (titulo_charla ?tit_preseleccionado2)(CF ?cf2))
  (modify ?f2 (titulo_charla ?tit_preseleccionado)(CF ?cf))
)



;------------ Resultados y comentarios ----------------

;Tras realizar el anterior apartado, donde teníamos multilples antecentes, el problema surge en que el consecuente
;necesita ser considerado. Si la afirmación consecuente no es un hecho fuzzy, no se necesita un tratamiento especial ya que la
;la conclusión será el hecho nítido (no difuso). Sin embargo, si la afirmación consecuente es un hecho borroso, la
;el valor difuso se calcula utilizando el siguiente algoritmo básico:
;Si es lógico y se usa, uno tiene:
;Si A1 y A2 entonces C CFr
;A′1 CFf1
;A′2 CFf2
;-------------------------------------
;C′ CFc
;donde A'1 y A'2 son hechos (nítidos o difusos) que coinciden con los antecedentes A1 y A2, respectivamente.

;En nuestro caso el conjunto difuso que describe el valor de la aseveración difusa en la conclusión se calcula de acuerdo con la
;fórmula F'c = F'c1 ∩ F'c2 dónde ∩ denota la intersección de dos conjuntos difusos
;F'c1 es el resultado de la inferencia difusa del hecho A1 'y la regla simple
;si A1 entonces C
;F'c2 es el resultado de la inferencia difusa del hecho A2 'y la regla simple
;si A2 entonces C

;Por ello podemos ver que de cada una de las preselecciones que hemos hecho:
;-presel_edad
;-presel_notoriedad
;-presel_interes
;cada una tiene un CF distinto, pero debido a lo anterior, podemos observar que el CF total, de presel, es la acumulación del resto
;siendo este cf total el más alto de las tres preselecciones.
