#lang scheme
(require "couche_metier.rkt")
(provide simplification)


(define simp* (lambda (exp)                                                                                    ;simp* : expression ----> expression
              
          (cond
              ((eq? (simplification (operande_test_1 exp)) 1)             (simplification (operande_test_2 exp)))          ;operande1 = 1                                                                             
              ((eq? (simplification (operande_test_2 exp)) 1)             (simplification (operande_test_1 exp)))          ;operande2 = 1

              ((or (eq? (simplification (operande_test_1 exp))  0)                                                   ;l'un des operandes est null
                   (eq? (simplification (operande_test_2 exp)) 0))       0)
        
             ((and (constante? (simplification (operande_test_1 exp)))
                   (constante? (simplification (operande_test_2 exp))))   (* (simplification (operande_test_1 exp))
                                                                    (simplification (operande_test_2 exp))))        ;les deux operandes sont des constants

            (#t                                                     (list (simplification (operande_test_1 exp))    ;au moins un des operandes est une liste
                                                                          (operateur_as_symbol exp)
                                                                          (simplification (operande_test_2 exp))))
            )))




(define simp+ (lambda (exp)                                                                                     ;simp+: expression ----> expression
              
          (cond
            ((eq? (simplification (operande_test_1 exp)) 0)              (simplification (operande_test_2 exp)))            ;operande1 = 0
            ((eq? (simplification (operande_test_2 exp)) 0)              (simplification (operande_test_1 exp)))            ;operande2 = 0

            ((and (constante? (simplification (operande_test_1 exp)))
                  (constante? (simplification (operande_test_2 exp))))   (+ (simplification (operande_test_1 exp))
                                                                      (simplification (operande_test_2 exp))))         ;les deux operandes sont des constants

            (#t                                                    (list (simplification (operande1 exp))        ;au moins un des operandes est une liste
                                                                         (operateur_as_symbol exp)
                                                                         (simplification (operande2 exp))))
          )))


(define simplification (lambda (exp)    
  (cond                                                                             
    ((or (identificateur? exp)
         (constante? exp))            
     exp)
    
    ((surparenthese? exp) 
     
     (if (pair? (car exp))  ; Vérifie que (car exp) est bien une liste avant de l'appeler récursivement
         (simplification (car exp))
         (car exp)))  ; Si ce n’est pas une liste, on le retourne tel quel
    
    ((eq? '+ (operateur_as_symbol exp)) (simp+ exp))                                 
    ((eq? '* (operateur_as_symbol exp)) (simp* exp))                                
  )))


(simplification '(((x) + (5 * y)) + (z)))
(simplification '((4) * (x)))
(simplification '((* 8 0) + (+ 8 4)))
(simplification '(4 + (2 * 3)))
(simplification '((12 + (1 * 5)) + (3 + 0)))