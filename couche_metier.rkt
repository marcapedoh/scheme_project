#lang scheme


#|(provide operateur operande1 operande2 constructeur constante? indentificateur? surparenthese?)

(define last ;cette fonction retourne le dernier élément de la liste s'il existe sinon on retourne la liste vide
  (lambda (lst)
    (if (null? (cdr lst))
        (car lst)
        (last (cdr lst))
     )
   )
)

(define operateur (lambda(exp) ;cette fonction retournera un symbole arthmétique s'il y a lieu dans l'expression que ce soit en préfixé ou infixé
                    (cond
                      ((symbol? (car exp)) (car exp))
                      ((symbol? (cadr exp)) (cadr exp))
                      (else (last exp))
                     )
                   )
)

(define operande1(lambda(exp) ;cette fonction retourne le premier opérateur de l'expression
                   (cond
                     ((symbol? (car exp)) (cadr exp))
                     ((symbol? (cadr exp)) (car exp))
                     ((symbol? (last exp)) (car exp))
                     
                    )
                 )
)

(define operande2(lambda(exp); cette fonction retour le deuxieme opérateur de l'équation
                   (cond
                     ((symbol? (car exp)) (caddr exp))
                     ((symbol? (cadr exp)) (caddr exp))
                     ((symbol? (last exp)) (cadr exp))
                    )
                  )
 )

(define constante?(lambda (exp) ;cette fonction retourne un etat booléen si l'expression fourni en parametre est une constante ou pas
                    (number? exp)
                   )
)

(define indentificateur? (lambda (exp) ; cette fonction return un booléen si l'expression en parametre est un symbole ou pas
                          (symbol? exp)
                          )
)

(define surparenthese? (lambda (exp); cette fonction retourne une expression qui a été surparentheser
                         (= (length exp) 1)
                        )
 
)
(define constructeur (lambda (exp1 operateur exp2); cette fonction permet de creer une expression
                       (list exp1 operateur exp2)
                      )
)|#


(provide operateur operande1 operande2 operateur_as_symbol operande_test_1 operande_test_2  constructeur constante? identificateur? surparenthese?)



(define last ;cette fonction retourne le dernier élément de la liste s'il existe sinon on retourne la liste vide
  (lambda (lst)
    (if (null? (cdr lst))
        (car lst)
        (last (cdr lst))
     )
   )
)

(define operateur_as_symbol (lambda (exp)
                              (cond
                                ((symbol? (car exp)) (car exp))
                                ((symbol? (cadr exp)) (cadr exp))
                                (else (last exp))
                                )
                             )
)
                                           
(define operateur (lambda (exp)              ;la fonction operateur:expression -----> operateur
                  (car (cdr exp))            ;elle renvoie l'operateur principale d'une expression arithmétique
                     #|(cond
                      ((symbol? (car exp)) (car exp))
                      ((symbol? (cadr exp)) (cadr exp))
                      (else (last exp))
                     )|#
        ))



                                                                        
(define operande_test_1(lambda(exp) ;cette fonction retourne le premier opérateur de l'expression
                   (cond
                     ((symbol? (car exp)) (cadr exp))
                     ((symbol? (cadr exp)) (car exp))
                     ((symbol? (last exp)) (car exp))
                     
                    )
                 )
)                                                                   
(define operande1 (lambda (exp)              ;la fonction operande1 : expression ----> expression
                 (car exp)                   ;elle renvoie la première opérande d'une expression arithmétique.
        ))



                                                                        
(define operande_test_2(lambda(exp); cette fonction retour le deuxieme opérateur de l'équation
                   (cond
                     ((symbol? (car exp)) (caddr exp))
                     ((symbol? (cadr exp)) (caddr exp))
                     ((symbol? (last exp)) (cadr exp))
                    )
                  )
 )                                                                   
(define operande2 (lambda (exp)              ;la fonction opereande2 : expression ----> expression
                 (car (cdr (cdr exp)))       ;elle renvoie la deuxième opérande d'une expression arithmétique.
        ))


                                                                        
                                                                        
(define constante? (lambda (exp)                 ;la fonction const?: expression ----> booléen
                  (number? exp)              ;elle renvoie vrai si l'expression est une constante et faux sinon.
             ))

                                                                        
                                                                       
(define identificateur? (lambda (exp)                    ;la fonction id?: expression -----> booléen
              (symbol? exp)                  ;elle renvoie vrai si l'expression est un identificateur et faux sinon
              ))

                                                                        
                                                                        
(define surparenthese? (lambda (exp)          ;la fonction : expression -----> booléen
                  (= (length exp) 1)
                         ))

(define constructeur (lambda (exp1 operateur exp2)
                       (list exp1 operateur exp2)
                       ))
                   
(operateur_as_symbol '((X) + (1 * y)))
(operateur_as_symbol '(3 / 2))
(operateur_as_symbol '(5 9 *))
;(operateur '(+ 1 6))
;(operateur '(3 / 2))
;(operateur '(5 9 *))
(operande_test_1 '(+ (3 / 2) x))
(operande_test_1 '(+ X 6))
(operande_test_1 '(5 9 *))
;(operande1 '(3 / 2))
;(operande1 '(+ X 6))
;(operande1 '(5 9 *))
(operande_test_2 '(+ 1 Y))
(operande_test_2 '(8 / 2))
(operande_test_2 '(5 8 *))
(operande2 '(+ 1 Y))
(operande2 '(8 / 2))
(operande2 '(5 8 *))