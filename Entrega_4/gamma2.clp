;Entrega 4 Objetivo: Observar y manejar CF de consecuente concreto con antecedente borroso equiparado con valor concreto

;4.1 Definir una regla que elija para la selección definitiva, a ejecutar cuando
;ha concluido la preselección (usando hechos para regular esta secuencia y no la
;prioridad de las reglas), entre los preseleccionados aquellos cuyo factor de
;certeza (cf) sea mayor, cuyos temas no hayan sido seleccionados previamente,
;sin superar el número máximo de charlas total de esa edición del techfest.
;Ejecutarla estas dos reglas cómo únicas reglas y observar qué ocurre. Nota: usar get-cf



Ejemplo de método de la burbuja:

(deftemplate pos
(slot index (type INTEGER))
(slot value (type INTEGER))
)
(deffacts vector
(pos (index 1) (value 15))
(pos (index 2) (value 7))
(pos (index 3) (value 4))
(pos (index 4) (value 2))
)
(defrule sort-bubble
?f1 <- (pos (index ?p1) (value ?v1))
?f2 <- (pos (index ?p2&:(= ?p2 (+ ?p1 1)))  (value ?v2&:(< ?v2 ?v1)))
=>
(modify ?f1 (value ?v2))
(modify ?f2 (value ?v1))
)



regla nueva

not (ahora se asigna)
  =>
assert (ahora se asigna)
