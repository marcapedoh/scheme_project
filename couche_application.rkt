#lang scheme
(require "couche_metier.rkt")
(provide simplification)


(define simp* (lambda (exp)   
          (cond
              ((eq? (simplification (operande1 exp)) 1)             (simplification (operande2 exp)))          ;operande1 = 1                                                                             
              ((eq? (simplification (operande2 exp)) 1)             (simplification (operande1 exp)))          ;operande2 = 1

              ((or (eq? (simplification (operande1 exp))  0)                                                   ;l'un des operandes est null
                   (eq? (simplification (operande2 exp)) 0))       0)
        
             ((and (constante? (simplification (operande1 exp)))
                   (constante? (simplification (operande2 exp))))   (* (simplification (operande1 exp))
                                                                             (simplification (operande2 exp))))        ;les deux operandes sont des constants

            (#t                                                           (list (simplification (operande1 exp))    ;au moins un des operandes est une liste
                                                                                (operateur exp)
                                                                                (simplification (operande2 exp))))
            )))




(define simp+ (lambda (exp)     
          (cond
            ((eq? (simplification (operande1 exp)) 0)              (simplification (operande2 exp)))            ;operande1 = 0
            ((eq? (simplification (operande2 exp)) 0)              (simplification (operande1 exp)))            ;operande2 = 0

            ((and (constante? (simplification (operande1 exp)))
                  (constante? (simplification (operande2 exp))))   (+ (simplification (operande1 exp))
                                                                            (simplification (operande2 exp))))         ;les deux operandes sont des constants

            (#t                                                           (list (simplification (operande1 exp))        ;au moins un des operandes est une liste
                                                                                (operateur exp)
                                                                                (simplification (operande2 exp))))
          )))


(define simplification (lambda (exp)    
  (cond                                                                             
    ((or (identificateur? exp)
         (constante? exp))            
     exp)
    ((surparenthese? exp) (simplification (car exp)))
    ((eq? '+ (operateur exp)) (simp+ exp))                                 
    ((eq? '* (operateur exp)) (simp* exp))                                
  )))



(simplification '(((x) + (5 * y)) + (z)))
(simplification '((4) * (x)))
(simplification '((* 8 0) + (+ 8 4)))
(simplification '(4 + (2 * 3)))
(simplification '((12 + (1 * 5)) + (3 + 0)))
(simplification '((((1 * x) + (0 * y)) + (z))))