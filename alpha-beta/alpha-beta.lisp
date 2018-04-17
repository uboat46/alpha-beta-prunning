(DEFUN PUEDEMOVER (S POS COLOR COSTO)
  (COND
    ((= COSTO 5)

    )
    ((NULL COLOR)
    )
    (T
      (BLOCK OUTER
        (SETQ RES '())
        (WHEN (AND (= COLOR 1) (NULL (MEMBER POS '(28 29 30 31))) )
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
        (WHEN (AND (= COLOR 2) (NULL (MEMBER POS '(0 1 2 3))) )
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

(DEFUN PUEDECOMER (S POS COLOR COSTO)
  (COND
    ((= COSTO 5)

    )
    ((NULL COLOR)
    )
    (T
      (BLOCK OUTER
        (SETQ RES '())
        (WHEN (AND (= COLOR 1) (NULL (MEMBER POS '(24 25 26 27 28 29 30 31))) )
          (WHEN (NOT (= (MOD POS 8) 0))
            (IF (<= (MOD POS 8) 3) 
              (WHEN (AND (NULL (NTH 0 (NTH (+ POS 7) S) )) (NOT (NULL (NTH 0 (NTH (+ POS 3) S) ))) (NOT (= (NTH 0 (NTH (+ POS 3) S) ) COLOR))  )
                (SETQ RES (APPEND RES (LIST (LIST POS 7 3)) ) )
              )
              (WHEN (AND (NULL (NTH 0 (NTH (+ POS 7) S) )) (NOT (NULL (NTH 0 (NTH (+ POS 4) S) ))) (NOT (= (NTH 0 (NTH (+ POS 4) S) ) COLOR))  )
                (SETQ RES (APPEND RES (LIST (LIST POS 7 4)) ) )
              )
            )
          )
          (WHEN (NOT (= (MOD (+ POS 1) 8) 0))
            (IF (<= (MOD POS 8) 3) 
              (WHEN (AND (NULL (NTH 0 (NTH (+ POS 9) S) )) (NOT (NULL (NTH 0 (NTH (+ POS 4) S) ))) (NOT (= (NTH 0 (NTH (+ POS 4) S) ) COLOR))  )
                (SETQ RES (APPEND RES (LIST (LIST POS 9 4)) ) )
              )
              (WHEN (AND (NULL (NTH 0 (NTH (+ POS 9) S) )) (NOT (NULL (NTH 0 (NTH (+ POS 5) S) ))) (NOT (= (NTH 0 (NTH (+ POS 5) S) ) COLOR))  )
                (SETQ RES (APPEND RES (LIST (LIST POS 9 5)) ) )
              )
            )
          )
        )
        (WHEN (AND (= COLOR 2) (NULL (MEMBER POS '(0 1 2 3 4 5 6 7))) )
          (WHEN (NOT (= (MOD POS 8) 0))
            (IF (>= (MOD POS 8) 4) 
              (WHEN (AND (NULL (NTH 0 (NTH (- POS 9) S) )) (NOT (NULL (NTH 0 (NTH (- POS 4) S) ))) (NOT (= (NTH 0 (NTH (- POS 4) S) ) COLOR))  )
                (SETQ RES (APPEND RES (LIST (LIST POS -9 -4)) ) )
              )
              (WHEN (AND (NULL (NTH 0 (NTH (- POS 9) S) )) (NOT (NULL (NTH 0 (NTH (- POS 5) S) ))) (NOT (= (NTH 0 (NTH (- POS 5) S) ) COLOR))  )
                (SETQ RES (APPEND RES (LIST (LIST POS -9 -5)) ) )
              )
            )
          )
          (WHEN (NOT (= (MOD (+ POS 1) 8) 0))
            (IF (>= (MOD POS 8) 4) 
              (WHEN (AND (NULL (NTH 0 (NTH (- POS 7) S) )) (NOT (NULL (NTH 0 (NTH (- POS 3) S) ))) (NOT (= (NTH 0 (NTH (- POS 3) S) ) COLOR))  )
                (SETQ RES (APPEND RES (LIST (LIST POS -7 -3)) ) )
              )
              (WHEN (AND (NULL (NTH 0 (NTH (- POS 7) S) )) (NOT (NULL (NTH 0 (NTH (- POS 4) S) ))) (NOT (= (NTH 0 (NTH (- POS 4) S) ) COLOR))  )
                (SETQ RES (APPEND RES (LIST (LIST POS -7 -4)) ) )
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

(DEFUN GETCOMERS (S COLOR)
  (SETQ RES '())
  (LOOP FOR FICHA IN S
    DO (WHEN (NOT (NULL (NTH 0 FICHA))) (WHEN (= COLOR (NTH 0 FICHA)) (SETQ RES (APPEND RES (PUEDECOMER S (NTH 1 FICHA) COLOR (NTH 2 FICHA))))  ) )
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

(DEFUN COME (S MOV)
  (SETQ RES (COPY-TREE S))
  (SETPIEZA RES NIL (+ (NTH 0 MOV) (NTH 2 MOV)) 0)
)



(DEFUN VALUE (S)
  (SETQ N 0)
  (SETQ R 0)
  (LOOP FOR FICHA IN S
    DO (WHEN (AND (NOT (NULL (NTH 0 FICHA))) (= 2 (NTH 0 FICHA)) ) (INCF R (NTH 2 FICHA))) (WHEN (AND (NOT (NULL (NTH 0 FICHA))) (= 1 (NTH 0 FICHA)) ) (INCF N (NTH 2 FICHA)))
  )
  (LIST (- N R) S)
)

(DEFUN MAXVAL (S D A B MOVIMIENTOS)
  (COND
    ( (OR (= D 0) (NUMBERP (CAR S)))
      (VALUE S)
    )
    ( T
      (SETQ V (LIST -9999 S))
      (BLOCK OUTER
        (LOOP FOR MOV IN MOVIMIENTOS
          DO (SETQ MOVS (GETMOVS (MOVE S MOV) 1)) (SETQ MINI (MINVAL (MOVE S MOV) (- D 1) A B MOVS)) (WHEN (> (NTH 0 MINI) (NTH 0 V)) (SETQ V MINI)) (SETQ A (MAX A (NTH 0 V))) (IF (<= B A) (RETURN-FROM OUTER NIL))
        ) 
      )
      V
    )
  )
)

(DEFUN MINVAL (S D A B MOVIMIENTOS)
  (COND
    ( (OR (= D 0) (NUMBERP (CAR S)))
      (VALUE S)
    )
    ( T
      (SETQ V (LIST 9999 S))
      (BLOCK OUTER
        (LOOP FOR MOV IN MOVS
          DO (SETQ MOVS (GETMOVS (MOVE S MOV) 2)) (SETQ MAXI (MAXVAL (MOVE S MOV) (- D 1) A B MOVS)) (WHEN (< (NTH 0 MAXI) (NTH 0 V)) (SETQ V MAXI)) (SETQ B (MIN B (NTH 0 V) ))(IF (<= B A) (RETURN-FROM OUTER NIL))
        ) 
      )
      V
    )
  )
)

(DEFUN JUEGA (S COLOR D)
  (SETQ MOVS (GETMOVS S COLOR))
  (SETQ CMOVS (GETCOMERS S COLOR))
  (PRINT CMOVS)
  (SETQ PIEZAS (GETUNIQUEPOS MOVS))
  (LOOP FOR PIEZA IN PIEZAS
    DO (PRINT (MAXVAL S 3 -9999 9999 (GETUNIQUEMOVS MOVS PIEZA)))
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
;;(DEFUN ALPHABETA ()
;;  ( PRINT (MAXVAL '( ( ( ( (10) (11) ) ( (9) (8) ) ) ( ( (14) (15) ) ( (4) (5)) ) )   ( ( ( (10) (11) ) ( (5) (8) ) ) ( ( (4) (15) ) ( (4) (3)) ) ) ) 5 -9999 9999))
;;)