(DEFUN PUEDEMOVER (S POS COLOR COSTO)
  (COND
    ((= COSTO 5)

    )
    ((NULL COLOR)
    )
    (T
      (BLOCK OUTER
        (SETQ RES '())
        (WHEN (= COLOR 1)
          (WHEN (NOT (= (MOD POS 8) 0))
            (IF (<= (MOD POS 8) 3) 
              (WHEN (NULL (NTH 0 (NTH (+ POS 3) S) ))
                (SETQ RES (APPEND RES (LIST (LIST POS 3)) ) )
              )
              (WHEN (NULL (NTH 0 (NTH (+ POS 4) S) ))
                (SETQ RES (APPEND RES (LIST (LIST POS 4)) ) )
              )
            )
          )
          (WHEN (NOT (= (MOD (+ POS 1) 8) 0))
            (IF (<= (MOD POS 8) 3) 
              (WHEN (NULL (NTH 0 (NTH (+ POS 4) S) ))
                (SETQ RES (APPEND RES (LIST (LIST POS 4)) ) )
              )
              (WHEN (NULL (NTH 0 (NTH (+ POS 5) S) ))
                (SETQ RES (APPEND RES (LIST (LIST POS 5)) ) )
              )
            )
          )
        )
        (WHEN (= COLOR 2)
          (WHEN (NOT (= (MOD POS 8) 0))
            (IF (>= (MOD POS 8) 4) 
              (WHEN (NULL (NTH 0 (NTH (- POS 4) S) ))
                (SETQ RES (APPEND RES (LIST (LIST POS -4)) ) )
              )
              (WHEN (NULL (NTH 0 (NTH (- POS 5) S) ))
                (SETQ RES (APPEND RES (LIST (LIST POS -5)) ) )
              )
            )
          )
          (WHEN (NOT (= (MOD (+ POS 1) 8) 0))
            (IF (>= (MOD POS 8) 4) 
              (WHEN (NULL (NTH 0 (NTH (- POS 3) S) ))
                (SETQ RES (APPEND RES (LIST (LIST POS -3)) ) )
              )
              (WHEN (NULL (NTH 0 (NTH (- POS 4) S) ))
                (SETQ RES (APPEND RES (LIST (LIST POS -4)) ) )
              )
            )
          )
        ) 
        (RETURN-FROM OUTER RES) 
      )
    )
  )
)

(DEFUN GETMOVS (S COLOR)
  (SETQ RES '())
  (LOOP FOR FICHA IN S
    DO (WHEN (NOT (NULL (NTH 0 FICHA))) (WHEN (= COLOR (NTH 0 FICHA)) (SETQ RES (APPEND RES (PUEDEMOVER S (NTH 1 FICHA) COLOR (NTH 2 FICHA))))  ) )
  )
  RES
)

(DEFUN GETUNIQUEPOS (MOVIMIENTOS)
  (SETQ RES '())
  (LOOP FOR MOVIMIENTO IN MOVIMIENTOS
    DO (WHEN (NULL (MEMBER  (NTH 0 MOVIMIENTO) RES) )  (SETQ RES (APPEND RES (LIST (NTH 0 MOVIMIENTO)))))
  )
  RES
)

(DEFUN ISMOVFROMPOS (MOV POS)
  (= POS (NTH 0 MOV))
)

(DEFUN GETUNIQUEMOVS (MOVIMIENTOS POS)
  (SETQ RES '())
  (LOOP FOR MOV IN MOVIMIENTOS
    DO (WHEN (ISMOVFROMPOS MOV POS) (SETQ RES (PUSH MOV RES) ))
  )
  RES
)

(DEFUN SETPIEZA (S COLOR POS COSTO)
  (SETF (NTH POS S) (LIST COLOR POS COSTO))
)

(DEFUN MOVE (S MOV)
  (SETQ RES (COPY-TREE S))
  (SETQ FIC (NTH (NTH 0 MOV) RES))
  (SETPIEZA RES (NTH 0 FIC) (+ (NTH 0 MOV) (NTH 1 MOV)) (NTH 2 FIC))
  (SETPIEZA RES NIL (NTH 0 MOV) 0)
  RES
)

(DEFUN AGREGANIL (TREE)
  (PUSH NIL TREE)
)

(DEFUN CREATREE (CANTIDAD)
  (SETQ RES '())
  (LOOP FOR X FROM 1 TO CANTIDAD
    DO (SETQ RES (AGREGANIL RES))
  )
  RES
) 

(DEFUN ALPHABETA ()
  ( PRINT (MAXVAL '( ( ( ( (10) (11) ) ( (9) (8) ) ) ( ( (14) (15) ) ( (4) (5)) ) )   ( ( ( (10) (11) ) ( (5) (8) ) ) ( ( (4) (15) ) ( (4) (3)) ) ) ) 5 -9999 9999))
)

(DEFUN VALUE (S)
  (CAR S)
)

(DEFUN MAXVAL (S D A B PIEZA)
  (COND
    ( (OR (= D 0) (NUMBERP (CAR S)))
      (VALUE S)
    )
    ( T
      (SETQ V -9999)
      (BLOCK OUTER
        (SETQ MOVS (GETUNIQUEMOVS MOVS PIEZA))
        (LOOP FOR C IN S
          DO (SETQ V (MAX V (MINVAL C (- D 1) A B PIEZA) ) ) (SETQ A (MAX A V)) (IF (<= B A) (RETURN-FROM OUTER NIL))
        ) 
      )
      V
    )
  )
)

(DEFUN MINVAL (S D A B PIEZA)
  (COND
    ( (OR (= D 0) (NUMBERP (CAR S)))
      (VALUE S)
    )
    ( T
      (SETQ V 9999)
      (BLOCK OUTER
        (SETQ MOVS (GETUNIQUEMOVS MOVS PIEZA))
        (LOOP FOR C IN S
          DO (SETQ V (MIN V (MAXVAL C (- D 1) A B PIEZA) ) ) (SETQ B (MIN B V))(IF (<= B A) (RETURN-FROM OUTER NIL))
        ) 
      )
      V
    )
  )
)

(DEFUN JUEGA (S COLOR D)
  (SETQ MOVS (GETMOVS S COLOR))
  (SETQ PIEZAS (GETUNIQUEPOS MOVS))
  (LOOP FOR PIEZA IN PIEZAS
    DO (MAXVAL S 3 -9999 9999 PIEZA)
  )
)



;;TODO ORDENAR POR PUEDE COMER
;;COMER
;;MOVER PIEZA
;;(REDUCE #'MAX  RES)
;;============================


;;EMPIEZA CON UNA FICHA RANDOM CON POS 0 A 3
;;SE TIENE UNA LISTA PARA LAS FICHAS NEGRAS QUE SON POSIBLES DE MOVER
;;SE CORRE EL ALGORITMOS POR CADA UNA DE LAS FICHAS Y SE OBTIENE EL MAX DE CADA UNA DE ELLAS
;;TIPO DEFINE SI ES REY O NO (REY == 5)
;;ficha ( {color = [1 2] o nil} {pos from 0 to 15} {costo} )
;; ficha.color = 1 = negra
;;ficha.color = 2 = roja