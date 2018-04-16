(DEFUN ALPHABETA ()
  ( PRINT (MAXVAL '((1 2 3) (4 5 6) (7 8 9)) -9999 9999))
)

(DEFUN VALUE (S)
  (CAR S)
)

(DEFUN MAXVAL (S A B)
  (COND
    ( (NULL (CDR S) )
        (VALUE S)
    )
    ( T
      (SETQ V -9999)
      (BLOCK OUTER
        (LOOP FOR C IN S
          DO (SETQ VP (MINVAL C A B) ) (IF (> VP V) (SETQ V VP)) (IF (>= VP B) (RETURN-FROM OUTER V )) (IF (> VP A) (SETQ A VP))
        ) 
      )
      (T V)
    )
  )
)

(DEFUN MINVAL (S A B)
  (COND
    ( (NULL (CDR S) )
        (VALUE S)
    )
    ( T
      (SETQ V 9999)
      (BLOCK OUTER
        (LOOP FOR C IN S
          DO (SETQ VP (MAXVAL C A B) ) (IF (< VP V) (SETQ V VP)) (IF (<= VP A) (RETURN-FROM OUTER V )) (IF (> VP B) (SETQ B VP))
        ) 
      )
      
      (T V)
    )
  )
)