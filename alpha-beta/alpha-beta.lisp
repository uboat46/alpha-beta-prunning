(DEFUN ALPHABETA ()
  ( PRINT (MAXVAL '( ( ( ( (10) (11) ) ( (9) (8) ) ) ( ( (14) (15) ) ( (4) (5)) ) )   ( ( ( (10) (11) ) ( (5) (8) ) ) ( ( (4) (15) ) ( (4) (3)) ) ) ) 5 -9999 9999))
)

(DEFUN VALUE (S)
  (CAR S)
)

(DEFUN MAXVAL (S D A B)
  (COND
    ( (OR (= D 0) (NUMBERP (CAR S)))
      (VALUE S)
    )
    ( T
      (SETQ V -9999)
      (BLOCK OUTER
        (LOOP FOR C IN S
          DO (SETQ V (MAX V (MINVAL C (- D 1) A B) ) ) (SETQ A (MAX A V)) (IF (<= B A) (RETURN-FROM OUTER NIL))
        ) 
      )
      V
    )
  )
)

(DEFUN MINVAL (S D A B)
  (COND
    ( (OR (= D 0) (NUMBERP (CAR S)))
      (VALUE S)
    )
    ( T
      (SETQ V 9999)
      (BLOCK OUTER
        (LOOP FOR C IN S
          DO (SETQ V (MIN V (MAXVAL C (- D 1) A B) ) ) (SETQ B (MIN B V))(IF (<= B A) (RETURN-FROM OUTER NIL))
        ) 
      )
      V
    )
  )
)

(DEFUN OBTENJUGADAS (S)
  
)
;;ficha ( {color o nil} {x-pos} {y-pos} {costo} )