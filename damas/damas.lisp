codigo.txt
Hace mucho tiempo
24 ago. 2016Ordenador

Martin Colín ha subido un elemento
Texto
codigo.txt
﻿(defun inicializa ()
	(setq numerote 73786976303428141056)
	(setq numerito -73786976303428141056)
	;tablero lo recibe de la interfaz, con otro nombre de variable, tableroint
	(setq tablerofinal (AlfabetaInicial	numerito numerote tablerito T 0 '() nil))
	;es para guardar en texto
	(open-output-file 'res.txt)
	(print tablerofinal)
	(close-output-file 'res.txt)
)

(defun puedeMover (columna fila color direccion tablero)
	(setq xx columna)
	(setq yy fila)
 	((and (< -1  xx) (< xx 8) (< -1 yy) (< yy 8))
		(setq piezaActual (nth xx (nth yy tablero)))
		;puede mover
		((eq 0 piezaActual) 
			0
		)
		;puede comer
		((or (eq (* piezaActual -1)  color) (eq (* piezaActual -2) color) (eq piezaActual (* -2 color)))
			(if (or (eq direccion 1)(eq direccion 3))
				(prog1
					(decq xx)
					(if (EQ direccion 1)
						(incq yy)
						(decq yy)
					)
				)
				(prog1
					(incq xx)
					(if (EQ direccion 2)
						(incq yy)
						(decq yy)
					)
				)
			)
			((eq (nth xx (nth yy tablero)) 0)
				1
			)
			-1
		)
		-1
	)
	-1
)

(defun heuristica(tablero)
	;(print tablero)
	;Los maximizadores son los negativos
	(setq res 0)
	(if (eq (evaluarTabler tablero nil) T) ;En este caso gana la computadora
		( setq res 73786976303428141054)
		;Si no pasa esto entonces revisar si ya perdió o puedes seguir ganando
		(prog1
			(if (eq (evaluarTabler tablero T) T)
				(setq res -73786976303428141059)
				;Sino entonces debe revisar los otros casos
				(prog1
					;Contar nuestras fichas menos las del oponente
					(setq fichasNeg (cuentaFichas -1 tablero))
					(setq fichasPos (cuentaFichas 1 tablero))
					(setq totFichas (- fichasNeg fichasPos))
					(setq totFichas (* totFichas 2))
					;(setq totFichas (* 8 totFichas))
					(setq OrNeg (* 2 (cuentaOrillas 1 tablero)))
					(setq OrPos (* -1 (cuentaOrillas -1 tablero)))
					(setq Diag (* 1 (cuentaDiagonales -1 tablero)))
					(setq OpDiag (* -1 (cuentaDiagonales 1 tablero)))
					(setq PosReyes (* 1 (FilasCoronacion -1 tablero)))
					(setq PosReyesPos (* -1 (FilasCoronacion 1 tablero)))
					(setq res (+ totFichas orNeg OrPos Diag OpDiag PosReyes PosReyesPos))
					
				)
			)
		)
	)
	res
)
(defun CuentaDiagonales(jugador tablero)
	;Revisar por cada ficha de las que tengo del jugador cuantas diagonales tiene en ocurrencia
	;con las del jugador oponente
	(setq filas 0)
	(if (eq jugador 1)
		(setq rey 2)
		(setq rey -2)
	)
	(setq diag 0)
	(setq columnas 0)
	(loop
		((eq filas 8))
		(setq columnas 0)
		(loop
			((eq columnas 8))
			(if (or (eq (nth columnas (nth filas tablero)) jugador) (eq (nth columnas (nth filas tablero)) rey))
				;Si es una ficha o un rey entonces checa cuantas se puede comer en las diagonales
				(prog1 ;hace la cuenta de las diagonales
					(setq fila2 (decq filas))
					(setq col2 (decq columnas))
					;revisa la diagonal con direccion 3
					(loop
						((or (eq fila2 -1) (eq col2 -1)) )
						;pregunta si hay una ficha en esa posición
						(if (or (eq (nth col2 (nth fila2 tablero)) (* -1 jugador)) (eq (nth col2 (nth fila2 tablero)) (* -1 rey)))
							(if (and (or (eq (- col2 columnas) (- fila2 filas)) (eq (- col2 columnas) (- filas fila2)))  (or (eq (- fila2 col2) (- filas columnas)) (eq (+ filas columnas) (+ fila2 col2))))
								(if (eq (nth col2 (nth fila2 tablero)) (* -1 jugador))
									;si no es rey
									(incq diag)
									;si es rey, cuentan por 2
									(incq diag 2)
									;(incq diag)
								)
								
							)
							;no hace nada
							()
						)
						(decq col2)
						(decq fila2)
					)
					;revisa la diagonal con direccion 2
					(setq fila2 (incq filas))
					(setq col2 (incq columnas))
					(loop
						((or (eq fila2 8) (eq col2 8)) )
						;pregunta si hay una ficha en esa posición
						(if (or (eq (nth col2 (nth fila2 tablero)) (* -1 jugador)) (eq (nth col2 (nth fila2 tablero)) (* -1 rey)))
							(if (and (or (eq (- col2 columnas) (- fila2 filas)) (eq (- col2 columnas) (- filas fila2)))  (or (eq (- fila2 col2) (- filas columnas)) (eq (+ filas columnas) (+ fila2 col2))))
								(if (eq (nth col2 (nth fila2 tablero)) (* -1 jugador))
									;si no es rey
									(incq diag)
									;si es rey, cuentan por 2
									(incq diag 2)
									;(incq diag)
								)
							)
							;no hace nada
							()
						)
						(incq col2)
						(incq fila2)
					)
					;revisa la diagonal con direccion 1
					(setq fila2 (incq filas))
					(setq col2 (decq columnas))
					(loop
						((or (eq fila2 8) (eq col2 -1)) )
						;pregunta si hay una ficha en esa posición
						(if (or (eq (nth col2 (nth fila2 tablero)) (* -1 jugador)) (eq (nth col2 (nth fila2 tablero)) (* -1 rey)))
							(if (and (or (eq (- col2 columnas) (- fila2 filas)) (eq (- col2 columnas) (- filas fila2)))  (or (eq (- fila2 col2) (- filas columnas)) (eq (+ filas columnas) (+ fila2 col2))))
								(if (eq (nth col2 (nth fila2 tablero)) (* -1 jugador))
									;si no es rey
									(incq diag)
									;si es rey, cuentan por 2
									(incq diag 2)
									;(incq diag)
								)
							)
							;no hace nada
							()
						)
						(decq col2)
						(incq fila2)
					)
					;revisa la diagonal con direccion 4
					(setq fila2 (decq filas))
					(setq col2 (incq columnas))
					(loop
						((or (eq fila2 -1) (eq col2 8)) )
						;pregunta si hay una ficha en esa posición
						(if (or (eq (nth col2 (nth fila2 tablero)) (* -1 jugador)) (eq (nth col2 (nth fila2 tablero)) (* -1 rey)))
							(if (and (or (eq (- col2 columnas) (- fila2 filas)) (eq (- col2 columnas) (- filas fila2)))  (or (eq (- fila2 col2) (- filas columnas)) (eq (+ filas columnas) (+ fila2 col2))))
								(if (eq (nth col2 (nth fila2 tablero)) (* -1 jugador))
									;si no es rey
									(incq diag)
									;si es rey, cuentan por 2
									(incq diag 2)
									;(incq diag)
								)
							)
							;no hace nada
							()
						)
						(incq col2)
						(decq fila2)
					)
				)
				();en el else no hace nada)
			)
			(incq columnas)
		)
		(incq filas)
	)
	diag
)

(defun FilasCoronacion (jugador tablero)
	(setq filas 0)
	(setq columnas 0)
	(setq posiblesRey 0)
	(loop
		((eq filas 8))
		(setq columnas 0)
		(loop
			((eq columnas 8))
			;revisar para cada pieza en la pieza de jugador 
			(if (eq (nth columnas (nth filas tablero)) jugador)
				(prog1
					(if (> 0 jugador)
						;son las negativas
						(if (and (eq filas 6) (eq (puedeMover  (add1 columnas) (add1 filas) -1 2 tablero) 0))
							(prog1
								;(print tablero)
								(incq posiblesRey)
							)
							(if (and (eq filas 6) (eq (puedeMover  (sub1 columnas) (add1 filas)-1 1 tablero) 0))
								(prog1
									;(print tablero)
									(incq posiblesRey)
								)
								()
							)
						)
						;son las positivas
						(prog1
						;	(print (puedeMover  (add1 columnas) (sub1 filas) jugador 4 tablero))
						;	(print (puedeMover  (sub1 columnas) (sub1 filas) jugador 3 tablero))
							(if (and (eq filas 1) (eq (puedeMover (add1 columnas) (sub1 filas) jugador 4 tablero) 0))
								(incq posiblesRey)
								(if (and (eq filas 1) (eq (puedeMover (sub1 columnas) (sub1 filas)  jugador 3 tablero) 0))
									(incq posiblesRey)
									
								)
							)
						)
					)
				)
				();no hace nada
			)
			(incq columnas)
		)
		(incq filas)
	)
	posiblesRey
)

(defun cuentaOrillas(jugador tablero)
	(setq filas 0)
	(setq fichas 0)
	(if (eq jugador 1)
		(setq rey 2)
		(setq rey -2)
	)
	(loop
		((eq filas 8))
		;Por cada ficha seca las columnas 0 y la columna 7
		(if (eq (nth 0 (nth filas tablero)) jugador )
			(incq fichas)
			(if (eq (nth 0 (nth filas tablero)) rey)
				(incq fichas 2)
				();hace nada)
			)
		)
		(if (eq (nth 7 (nth filas tablero)) jugador )
			(incq fichas)
			(if (eq (nth 7 (nth filas tablero)) rey)
				(incq fichas 2)
				();hace nada)
			)
		)
		(incq filas)
	)
	fichas
)

(defun cuentaFichas (jugador tablero)
	(setq filas 0)
	(setq fichas 0)
	(setq columnas 0)
	(if (eq jugador 1)
		(setq rey 2)
		(setq rey -2)
	)
	 (loop
		
		 ((eq filas 8));Llegó al límite de filas
		(setq columnas 0)
		(loop
			((eq columnas 8));Llegó al número de columnas
			(prog1
				
				(if (eq  (nth columnas (nth filas tablero)) jugador)
					(incq fichas)
					(if (eq (nth columnas (nth filas tablero))  rey)
						;Este genera cambios que pueden ser importantes
						(incq fichas 4)
						()
					);sino pregunta si es rey
				)
			);Lo que hace dentro del loop
			(incq columnas)
		)
		 (incq filas)		
	)
	fichas
)

(defun AlfaBeta (alfa beta tablero maximizador nivel movimientos comer)
	;nivelMax es una variable de ambiente
	;(print nivel)
	;(setq variableres 0)
	(if(or (eq nivel niveldificultad) (eq (evaluarTabler  tablero (not maximizador)) T) (eq (evaluarTabler tablero maximizador) T))	
		(prog1
			;(print (heuristica tablero))
		;	(print entraheuristica)
			(setq variableres (heuristica tablero))
		)
		(prog1 ;si no ha llegado a un nodo terminal, entonces calcula el total de los nodos
			(setq movimientos (generaMovimientos tablero '() maximizador))
			;(setq variableres 0)
			;hace un loop hasta que la lista de movimientos sea nula
			;pregunta si se trata del nodo maximizador
			(if  maximizador
				(prog1
					
					(setq variableres alfa)
					(loop
						;(print entra2)
						((or (null movimientos) (< beta alfa)))
						
						;si aún hay movimientos
						(setq tableroaux tablero)
						(setq muevete (pop movimientos))
						(setq tamano (length muevete))
						;(print nivel)
						;muevete tiene una sublista de los movimientos
						(loop ;muevete puede ser comer o no comer, se realizan los movimientos que tenga
							((null muevete))
						;	(print muevete)
							(setq auxiliar (pop muevete))
							(setq tableroaux (cambiaTablero tableroaux (car auxiliar) (cadr auxiliar) (caddr auxiliar)));revisar, puede que no sea car y que sea directo
						)
						;(print nivel)
						(if (> tamano 2)
							(prog1 ; preguntar si es la primera vez que come
								(if (null comer)
									;si es la primera vez que come, entonces actualizar alfa con el valor de que coma
									(prog1
										(setq alfa (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil))
										(setq comer T)
									);si ya ha comido antes, y en esta ocasión también come, elige la mejor heurística para eso
									(setq alfa (max alfa (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil)))
								)
							)
							(if (null comer);tiene 2 elementos y nunca ha comido, entonces puede actualizar el valor de alfabeta
								(setq alfa (max alfa (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil)))
								()
							)
						)
					)
					(setq variablesres alfa)
				);en caso de que no sea el jugador maximizador
				(prog1
					(setq variableres beta)
					(loop
						;(print entra)
						((or (null movimientos) (< beta alfa)))
						;si aún hay movimientos
						(setq tableroaux tablero)
						(setq muevete (pop movimientos))
						(setq tamano (length muevete))
						;muevete tiene una sublista de los movimientos
						(loop ;muevete puede ser comer o no comer, se realizan los movimientos que tenga
							((null muevete))
							(setq auxiliar (pop muevete))
							(setq tableroaux (cambiaTablero tableroaux (car auxiliar) (cadr auxiliar) (caddr auxiliar)));revisar, puede que no sea car y que sea directo
						)
						;una vez que cambio el tablero como se debe, se invoca alfa beta de nuevo con el tablero
						(if (> tamano 2)
							(prog1 ; preguntar si es la primera vez que come
								(if (null comer)
									;si es la primera vez que come, entonces actualizar alfa con el valor de que coma
									(prog1
										(setq beta (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil))
										(setq comer T)
									);si ya ha comido antes, y en esta ocasión también come, elige la mejor heurística para eso
									(setq beta (min beta (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil)))
								)
							)
							(if (null comer);tiene 2 elementos y nunca ha comido, entonces puede actualizar el valor de alfabeta
								(setq beta (min beta (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil)))
								();sino pues no hace nada
							)
						)
					)
					;(print beta)
					(setq variableres beta)
				)
			)
			
		)
	)
	variableres
)
;En esta parte del AlfaBeta se almacena el nodo que tenga el mejor movimiento

(defun AlfaBetaInicial (alfa beta tablero maximizador nivel movimientos comer)
	;nivelMax es una variable de ambiente
	(( OR (EQ nivel niveldificultad) (eq (evaluarTabler  tablero(not maximizador)) T) (eq (evaluarTabler tablero maximizador) T))	
		;(print entre)
		(heuristica tablero)
		
	)
	(;si no ha llegado a un nodo terminal, entonces calcula el total de los nodos
		(setq movimientos (generaMovimientos tablero '() maximizador))
		(setq variable 0)
		;(print movimientos)
		;(print holamov)
		;hace un loop hasta que la lista de movimientos sea nula
		;siempre movemos con el jugador maximizador la primera vez
		(loop
			((or (null movimientos) (< beta alfa)))
			;si aún hay movimientos
			(setq tableroaux tablero)
			(setq muevete (pop movimientos))
			(setq tamano (length muevete))
			;(print tableroaux)
			;(print )
			;muevete tiene una sublista de los movimientos
			(loop ;muevete puede ser comer o no comer, se realizan los movimientos que tenga
				;(print loops)
				((or (null muevete)))
				(setq auxiliar (pop muevete))
				(setq tableroaux (cambiaTablero tableroaux (car auxiliar) (cadr auxiliar) (caddr auxiliar)));revisar, puede que no sea car y que sea directo
			)
			;una vez que cambio el tablero como se debe, se invoca alfa beta de nuevo con el tablero
			(if ( > tamano 2)
					;	(print blabla)
						(prog1 ; preguntar si es la primera vez que come
							(if (null comer)
								;si es la primera vez que come, entonces actualizar alfa con el valor de que coma
								(prog1
									;(setq alfa2 (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil))
									(setq mejor tableroaux)
									(setq alfa (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil))
									
									;(print mejor)
									(setq comer T)
									;(if (< alfa alfa2)
								    ;		(prog1
									;		(setq alfa alfa2)
											;guarda el mejor movimiento
									;		(setq mejor tableroaux)
									;	)
										;el else
									;	()
									;)
								);si ya ha comido antes, y en esta ocasión también come, elige la mejor heurística para eso
								(prog1
									(setq tableroprueba tableroaux)
									(setq alfa2 (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil))
									(if (< alfa alfa2)
										(prog1
											(setq alfa alfa2)
											;guarda el mejor movimiento
											(setq mejor tableroprueba)
										;	(print mejor)
										)
										;el else, no hace nada si esto no pasa
										()
									)
								);si ya ha comido antes, y en esta ocasión también come, elige la mejor heurística para eso
							)
						)
						(if (null comer);tiene 2 elementos y nunca ha comido, entonces puede actualizar el valor de alfabeta
							(prog1
								(setq tableroprueba tableroaux)
								(setq alfa2 (AlfaBeta alfa beta tableroaux (not maximizador) (add1 nivel) '() nil))
								(if (< alfa alfa2)
									(prog1
										(setq alfa alfa2)
										;guarda el mejor movimiento
										(setq mejor tableroprueba)
										;(print mejor)
									)
									;el else
									()
								)
							)
							()
						)
			)
		)
		;Regresa el tablero con los mejores movimientos
		mejor
	)
)

(defun generaMovimientos (tablero lista maximizador)
	(setq fila 0)
	(setq columna 0)
	(loop
		((eq fila 8) lista)
		(setq columna 0)
		(loop
			((eq columna 8))
			;preguntamos si es NEGATIVAS
			
		;	(not (null maximizador))
			(if (and (> 0 (nth columna (nth fila tablero))) (not(null maximizador)));si esto pasa es que la ficha es negativa
				;debe realizaar los movimientos
				(if (eq (nth columna (nth fila tablero)) -1)
					(prog1
						;(print (puedeMover (list (sub1 fila) (sub1 columna)) -1 ))
						(if ( eq (puedeMover  (add1 columna) (add1 fila) -1 2 tablero) 0)
							;si puede mover entonces guarda los respectivos movimientos en la lista
							(prog1
								(setq listaux '())
								(push (list fila columna 0) listaux)
								(if (eq (add1 fila) 7);veo si es rey
											(push (list (add1 fila) (add1 columna) -2) listaux)
											(push (list(add1 fila) (add1 columna) -1) listaux)
								)
								(push listaux lista)
							)
							;preguntar si puede comer
							(prog1
								(if ( eq (puedeMover  (add1 columna) (add1 fila) -1 2 tablero) 1)
									(prog1
										(setq listaux '())
									;	(print listaux)
										(push (list fila columna 0) listaux)
									;	(print (list fila columna 0))
									;	(print listaux)
										(push (list(add1 fila) (add1 columna) 0) listaux)
										(if (eq (add1(add1 fila)) 7);veo si es rey
											(push (list(add1 (add1 fila)) (add1 (add1 columna)) -2) listaux)
											(push (list(add1 (add1 fila)) (add1 (add1 columna)) -1) listaux)
										)
										(push (append listaux (car (siguePieza (add1 (add1 fila)) (add1 (add1 columna)) (actualizaTablero tablero listaux) '() '() '() '()))) lista)
										)
									;no hace nada
									()
								)
							)
						)
						(if ( eq (puedeMover  (sub1 columna) (add1 fila) -1 1 tablero) 0)
							;si puede mover entonces guarda los respectivos movimientos en la lista
							(prog1
								(setq listaux '())
								(push (list fila columna 0) listaux)
							;	(print (list fila columna 0))
								(if (eq (add1 fila) 7);veo si es rey
											(push (list (add1 fila) (sub1 columna) -2) listaux)
											(push (list (add1 fila) (sub1 columna) -1) listaux)
								)
								(push listaux lista)
							)
							;preguntar si puede comer
							(prog1
								(if ( eq (puedeMover (sub1 columna) (add1 fila) -1 1 tablero) 1)
									(prog1
										(setq listaux '())
									;	(print listaux)
										(push (list fila columna 0) listaux)
									;	(print (list fila columna 0))
									;	(print listaux)
										;Falta agregar que pasa cuando se vuelve rey
										(push (list(add1 fila) (sub1 columna) 0) listaux)
										(if (eq (add1(add1 fila)) 7);veo si es rey
											(push (list(add1 (add1 fila)) (sub1 (sub1 columna)) -2) listaux)
											(push (list(add1 (add1 fila)) (sub1 (sub1 columna)) -1) listaux)
										)
										(push (append listaux (car (siguePieza (add1 (add1 fila)) (sub1 (sub1 columna)) (actualizaTablero tablero listaux) '() '() '() '()))) lista)									)
									;no hace nada
									()
								)
							)
						)
					)
					;EES UN REY, FALTA HACERLE LOS DOS MOVIMIENTOS QUE VIENEN ABAJO
					;(
						(push (car(generaMovimientosRey fila columna tablero '() -2)) lista);
					;)
				)
				;es positiva
				(if (and (< 0 (nth columna (nth fila tablero))) (null maximizador));si esto pasa es que la ficha es roja
					(if (eq (nth columna (nth fila tablero)) 1)
						(prog1
							(if ( eq (puedeMover (sub1 columna) (sub1 fila) 1 3 tablero) 0)
								;si puede mover entonces guarda los respectivos movimientos en la lista
								(prog1
									(setq listaux '())
									(push (list fila columna 0) listaux)
								;	(print (list fila columna 0))
									(if (eq (sub1 fila) 0);veo si es rey
											(push (list (sub1 fila) (sub1 columna) 2) listaux)
											(push (list (sub1 fila) (sub1 columna) 1) listaux)
									)
									(push listaux lista)
								)
								;preguntar si puede comer
								(prog1
									(if ( eq (puedeMover(sub1 columna) (sub1 fila)  1 3 tablero) 1) 
										(prog1
											(setq listaux '())
										;	(print listaux)
											(push (list fila columna 0) listaux)
										;	(print (list fila columna 0))
										;	(print listaux)
											(push (list(sub1 fila) (sub1 columna) 0) listaux)
											(if (eq (sub1(sub1 fila)) 0);veo si es rey
												(push (list(sub1 (sub1 fila)) (sub1 (sub1 columna)) 2) listaux)
												(push (list(sub1 (sub1 fila)) (sub1 (sub1 columna)) 1) listaux)
											)
											
											(push (append listaux (car (siguePieza (sub1 (sub1 fila)) (sub1 (sub1 columna)) (actualizaTablero tablero listaux) '() '() '() '()))) lista)
										);no hace nada, no puede moverse ni comer
										()
									)
								)
							)
							(if ( eq (puedeMover(add1 columna) (sub1 fila)  1 4 tablero) 0)
								;si puede mover entonces guarda los respectivos movimientos en la lista
								(prog1
									(setq listaux '())
									(push (list fila columna 0) listaux)
								;	(print (list fila columna 0))
									(if (eq (sub1 fila) 0);veo si es rey
											(push (list (sub1 fila) (add1 columna) 2) listaux)
											(push (list (sub1 fila) (add1 columna) 1) listaux)
									)
									(push listaux lista)
								)
								;sino puede mover, revisa si puede mover y comer
								(prog1
									(if ( eq (puedeMover(add1 columna) (sub1 fila)  1 4 tablero) 1) 
										(prog1
											(setq listaux '())
										;	(print listaux)
											(push (list fila columna 0) listaux)
										;	(print (list fila columna 0))
										;	(print listaux)
											(push (list(sub1 fila) (add1 columna) 0) listaux)
											(if (eq (sub1(sub1 fila)) 0);veo si es rey
												(push (list(sub1 (sub1 fila)) (add1 (add1 columna)) 2) listaux)
												(push (list(sub1 (sub1 fila)) (add1 (add1 columna)) 1) listaux)
											)
											(push (append listaux (car (siguePieza (sub1 (sub1 fila)) (add1 (add1 columna)) (actualizaTablero tablero listaux) '() '() '() '()))) lista)
										)
										()
									)
								;no hace nada, no se puede mover
								)
							)
						)
						;Genera movimientos del Rey
							;(print reyyyy)
						(prog1
							(push (car(generaMovimientosRey fila columna tablero '() 2)) lista)
						)
					)
				)
				;en caso de que no se deba hacer nada, porque no es negra y no debe mover
				()
			)
			
			(incq columna)
		)
		(incq fila)
	)
)


(defun generaMovimientosRey( fila columna tablero lista rey)
	;(print generaRey)
	(if ( eq (puedeMover (add1 columna) (add1 fila) rey 2 tablero) 0)
		;si puede mover entonces guarda los respectivos movimientos en la lista
		(prog1
			(setq listaux '())
			(push (list fila columna 0) listaux)
			(push (list (add1 fila) (add1 columna) rey) listaux)
			(push listaux lista)
		)
		;preguntar si puede comer
		(prog1
			(if (eq (puedeMover (add1 columna) (add1 fila) rey 2 tablero) 1)
				(prog1
					(setq listaux '())
				;	(print listaux)
					(push (list fila columna 0) listaux)
				;	(print (list fila columna 0))
				;	(print listaux)
					(push (list(add1 fila) (add1 columna) 0) listaux)
					(push (list(add1 (add1 fila)) (add1 (add1 columna)) rey) listaux)
					(push (append listaux (car (siguePieza (add1 (add1 fila)) (add1 (add1 columna)) (actualizaTablero tablero listaux) '() '() '() '()))) lista)
				)
				;no hace nada
				()
			)
		)
	)
	(if ( eq (puedeMover (sub1 columna) (add1 fila) rey 1 tablero) 0)
		;si puede mover entonces guarda los respectivos movimientos en la lista
		(prog1
			(setq listaux '())
			(push (list fila columna 0) listaux)
		;	(print (list fila columna 0))
			(push (list (add1 fila) (sub1 columna) rey) listaux)
			(push listaux lista)
		)
		;preguntar si puede comer
		(prog1
			(if ( eq (puedeMover (sub1 columna) (add1 fila)  rey 1 tablero) 1)
				(prog1
					(setq listaux '())
				;	(print listaux)
					(push (list fila columna 0) listaux)
				;	(print (list fila columna 0))
				;	(print listaux)
					;Falta agregar que pasa cuando se vuelve rey
					(push (list(add1 fila) (sub1 columna) 0) listaux)
					(push (list(add1 (add1 fila)) (sub1 (sub1 columna)) rey) listaux)
					(push (append listaux (car (siguePieza (add1 (add1 fila)) (sub1 (sub1 columna)) (actualizaTablero tablero listaux) '() '() '() '()))) lista)
				)
				;no hace nada
				()
			)
		)
	)
	(if ( eq (puedeMover  (sub1 columna) (sub1 fila) rey 3 tablero) 0)
		;si puede mover entonces guarda los respectivos movimientos en la lista
		(prog1
			(setq listaux '())
			(push (list fila columna 0) listaux)
		    (push (list (sub1 fila) (sub1 columna) rey) listaux)

			(push listaux lista)
		)
		;preguntar si puede comer
		(prog1
			(if ( eq (puedeMover (sub1 columna) (sub1 fila)  rey 3 tablero) 1) 
				(prog1
					(setq listaux '())
				;	(print listaux)
					(push (list fila columna 0) listaux)
				;	(print (list fila columna 0))
				;	(print listaux)
					(push (list(sub1 fila) (sub1 columna) 0) listaux)
					(push (list(sub1 (sub1 fila)) (sub1 (sub1 columna)) rey) listaux)
					(push (append listaux (car (siguePieza (sub1 (sub1 fila)) (sub1 (sub1 columna)) (actualizaTablero tablero listaux) '() '() '() '()))) lista)
				);no hace nada, no puede moverse ni comer
				()
			)
		)
	)
	(if ( eq (puedeMover  (add1 columna) (sub1 fila) rey 4 tablero) 0)
		;si puede mover entonces guarda los respectivos movimientos en la lista
		(prog1
			(setq listaux '())
			(push (list fila columna 0) listaux)
		;	(print (list fila columna 0))
			(push (list (sub1 fila) (add1 columna) rey) listaux)

			(push listaux lista)
		)
		;sino puede mover, revisa si puede mover y comer
		(prog1
			(if ( eq (puedeMover (add1 columna) (sub1 fila)  rey 4 tablero) 1) 
				(prog1
					(setq listaux '())
				;	(print listaux)
					(push (list fila columna 0) listaux)
				;	(print (list fila columna 0))
				;	(print listaux)
					(push (list(sub1 fila) (add1 columna) 0) listaux)
					(push (list(sub1 (sub1 fila)) (add1 (add1 columna)) rey) listaux)
					(push (append listaux (car (siguePieza (sub1 (sub1 fila)) (add1 (add1 columna)) (actualizaTablero tablero listaux) '() '() '() '()))) lista)
					(push listaux lista)
				)
				()
			)
		;no hace nada, no se puede mover
		)
	)
	lista
)

(defun cambiaTablero (tablero y x valor)
	(setq camX (add1 x))
	(setq camY (add1 y))
	(setq aux ())
	(push (cambia (nth (sub1 camY) tablero) camX valor) aux)
	(append (firstn (sub1 camY) tablero) aux (nthcdr camY tablero))	
)

;cambia
(defun cambia(lst pos val)
	(setq temp ())
	(push val temp)
	(append (firstn (sub1 pos) lst) temp (nthcdr pos lst))
)

(defun actualizaTablero (tablero moves)
	(setq tabAct tablero)
	(loop
		((null moves) tabAct)
		(setq mov (pop moves))
		(setq tabAct (cambiaTablero tabAct (car mov) (second mov) (third mov)))
	)	
)

(defun evaluarTabler(tablero maximizador) ;regresa T si jugador no tiene fichas en el tablero
	;si el oponente ya no tiene fichas entonces gana
	(if (eq maximizador T)
		(setq jugador -1)
		(setq jugador 1)
	)
	(setq fila '())
	(setq lista tablero)
	(((< 0 jugador)
		(setq rey (add1 jugador))
	)
	(setq rey (sub1 jugador)))
	(loop
		((null lista)
			T
		)
		(setq fila (pop lista))
		( (OR (NOT (EQL (member jugador fila) NIL))(NOT (EQL (member rey fila) NIL))) 
			NIL
		)
	)
)

(defun siguePieza (y x tablero res1 res2 res3 res4)
	(setq valorAct (nth x (nth y tablero)))
	;(print valorAct)
	(if (not (null valorAct))
		(prog1
			(if (eq (abs valorAct) 1)
				;es pieza normal
				(prog1
					(if (< 0 valorAct)
						(prog1
							(if (eq (puedeMover (sub1 x) (sub1 y) 1 3 tablero) 1)
								(prog1
									(setq resAux '())
									(push (list y x 0) resAux)
									(push (list (sub1 y) (sub1 x) 0) resAux)
									(if (eq (sub1 (sub1 y)) 0);veo si es rey
										(push (list (sub1 (sub1 y)) (sub1 (sub1 x))  2) resAux)
										(push (list (sub1 (sub1 y)) (sub1 (sub1 x))  1) resAux)
									)
									(push (append resAux (car (siguePieza (sub1 (sub1 y)) (sub1 (sub1 x)) (actualizaTablero tablero resAux) '() '() '() '()))) res3)
								)
								()
							)
							
							(if ( eq (puedeMover (add1 x) (sub1 y) 1 4 tablero) 1)
								(prog1
									(setq resAux '())
									(push (list y x 0) resAux)
									(push (list (sub1 y) (add1 x) 0) resAux)
									(if (eq (sub1 (sub1 y)) 0);veo si es rey
										(push (list (sub1 (sub1 y)) (add1 (add1 x)) 2) resAux)
										(push (list (sub1 (sub1 y)) (add1 (add1 x)) 1) resAux)
									)
									(push (append resAux (car (siguePieza (sub1 (sub1 y)) (add1 (add1 x)) (actualizaTablero tablero resAux) '() '() '() '()))) res4)
								)
								();no puede mover
							)	
						)
						
						(prog1
							(if ( eq (puedeMover (sub1 x) (add1 y) -1 1 tablero) 1)
								(prog1
									(setq resAux '())
									(push (list y x 0) resAux)
									(push (list (add1 y) (sub1 x) 0) resAux)
									(if (eq (add1 (add1 y)) 7);veo si es rey
										(push (list (add1 (add1 y)) (sub1 (sub1 x)) -2) resAux)
										(push (list (add1 (add1 y)) (sub1 (sub1 x)) -1) resAux)
									)
									(push (append resAux (car (siguePieza (add1 (add1 y)) (sub1 (sub1 x)) (actualizaTablero tablero resAux) '() '() '() '()))) res1)
								)
								()
							)
							(if ( eq (puedeMover (add1 x) (add1 y) -1 2 tablero) 1)
								(prog1
									(setq resAux '())
									(push (list y x 0) resAux)
									(push (list (add1 y) (add1 x) 0) resAux)
									(if (eq (add1 (add1 y)) 7);veo si es rey
										(push (list (add1 (add1 y)) (add1 (add1 x)) -2) resAux)
										(push (list (add1 (add1 y)) (add1 (add1 x))  -1) resAux)
									)
									(push (append resAux (car (siguePieza (add1 (add1 y)) (sub1 (sub1 x)) (actualizaTablero tablero resAux) '() '() '() '()))) res2)
								)
								();no puede mover
							)
						)
					)
				)
				;es rey
				(prog1
					(if (eq (abs valorAct) 2)
						(prog1
							;direccion 1
							(if ( eq (puedeMover (sub1 x) (add1 y) valorAct 1 tablero) 1)
								(prog1
									(setq resAux '())
									(push (list y x 0) resAux)
									(push (list (add1 y) (sub1 x) 0) resAux)
									(push (list (add1 (add1 y)) (sub1 (sub1 x)) valorAct) resAux)
									(push (append resAux (car (siguePieza (add1 (add1 y)) (sub1 (sub1 x)) (actualizaTablero tablero resAux) '() '() '() '()))) res1)
								)
								()
							)
							
							;direccion 2
							(if ( eq (puedeMover (add1 x) (add1 y) valorAct 2 tablero) 1)
								(prog1
									(setq resAux '())
									(push (list y x 0) resAux)
									(push (list (add1 y) (add1 x) 0) resAux)
									(push (list (add1 (add1 y)) (add1 (add1 x)) valorAct) resAux)
									(push (append resAux (car (siguePieza (add1 (add1 y)) (sub1 (sub1 x)) (actualizaTablero tablero resAux) '() '() '() '()))) res2)
								)
								()
							)
							
							;direccion 3
							(if ( eq (puedeMover (sub1 x) (sub1 y) valorAct 3 tablero) 1)
								(prog1
									(setq resAux '())
									(push (list y x 0) resAux)
									(push (list (sub1 y) (sub1 x) 0) resAux)
									(push (list (sub1 (sub1 y)) (sub1 (sub1 x)) valorAct) resAux)	
									(push (append resAux (car (siguePieza (sub1 (sub1 y)) (sub1 (sub1 x)) (actualizaTablero tablero resAux) '() '() '() '()))) res3)
								)
								()
							)
							
							;direccion 4
							(if ( eq (puedeMover (add1 x) (sub1 y) valorAct 4 tablero) 1)
								(prog1
									(setq resAux '())
									(push (list y x 0) resAux)
									(push (list (sub1 y) (add1 x) 0) resAux)
									(push (list (sub1 (sub1 y)) (add1 (add1 x)) valorAct) resAux)
									(push (append resAux (car (siguePieza (sub1 (sub1 y)) (add1 (add1 x)) (actualizaTablero tablero resAux) '() '() '() '()))) res4)
								)
								()
							)
						)
					)
					()
				)
			)
		)
		()
	)
	
	(setq listaRegresa '())
	(setq tam (max (length (car res1)) (length (car res2)) (length (car res3)) (length (car res4))))
	(if (eq tam (length (car res1)))
		(prog1
			(setq listaRegresa res1)
		)
		(prog1
			(if (eq tam (length (car res2)))
				(prog1
					(setq listaRegresa res2)
				)
				(prog1
					(if (eq tam (length (car res3)))
						(prog1
							(setq listaRegresa res3)
						)
						(prog1
							(setq listaRegresa res4)
						)
					)
				)
			)
		)
	)

	(return listaRegresa)
)

(inicializa)