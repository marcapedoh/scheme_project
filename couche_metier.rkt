#lang scheme

(provide   operateur operande1 operande2 constructeur constante? identificateur? surparenthese?)

#|
    une expression arthmétique a trois forme d'écriture
   1- préfixé: (+ x y)
   2- infixé:  (x + y)
   3- post-fixé: (x y +)


|#


(define dernier_liste_element ;cette fonction retourne le dernier élément de la liste s'il existe
  (lambda (lst)
    (if (null? (cdr lst))
        (car lst)
        (dernier_liste_element (cdr lst))
     )
   )
)

(define operateur (lambda (exp);cette fonction prend une fonction en parametre et retourne l'operateur de cette expression
                              (cond
                                ((symbol? (car exp)) (car exp))
                                ((symbol? (cadr exp)) (cadr exp))
                                (else (dernier_liste_element exp))
                                )
                             )
)



                                                                        
(define operande1(lambda(exp) ;cette fonction retourne la premiere operande de l'expression
                         
                   (cond
                     ((symbol? (car exp)) (cadr exp))
                     ((symbol? (cadr exp)) (car exp))
                     ((symbol? (dernier_liste_element exp)) (car exp))
                     (else exp)
                    )
                 )
)



                                                                        
(define operande2(lambda(exp); cette fonction retour la deuxieme operande de l'expression
                   (cond
                     ((symbol? (car exp)) (caddr exp))
                     ((symbol? (cadr exp)) (caddr exp))
                     ((symbol? (dernier_liste_element exp)) (cadr exp))
                     (else exp)
                    )
                  )
 )                                                                   
                                                                        
                                                                        
(define constante? (lambda (exp)                 ;la fonction const?: expression ----> booléen
                  (number? exp)              ;elle renvoie vrai si l'expression est une constante et faux sinon.
             ))

                                                                        
                                                                       
(define identificateur? (lambda (exp)                    ;la fonction id?: expression -----> booléen
              (symbol? exp)                  ;elle renvoie vrai si l'expression est un identificateur et faux sinon
              ))

                                                                        
                                                                        
(define surparenthese? (lambda (exp)          ;la fonction : expression -----> booléen
                         (and (list? exp) (= (length exp) 1))
                         ))


(define constructeur (lambda (exp1 operateur exp2) ;cette fonction prend en parametre deux operandes et un operateur et créer une expression arthmétique
                       (list exp1 operateur exp2)
                       ))
                   
(operateur '((X) + (1 * y)))
(operateur '(3 / 2))
(operateur '(5 9 *))
(constante? '(5))
(constante? 9)
(identificateur? 45)
(identificateur? 'X)
(surparenthese? '(45))
(constructeur '+ 'x 7812)
(constructeur 'x '+ 'y)
(constructeur 'x 'z '*)
(operande1 '(+ (3 / 2) x))
(operande1 '(+ X 6))
(operande1 '(5 9 *))
(operande2 '(+ 1 Y))
(operande2 '(8 / 2))
(operande2 '(5 8 *))