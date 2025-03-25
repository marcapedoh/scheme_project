#lang scheme
(require racket/port)
(require mzlib/string)

(provide liste_to_chaine chaine_to_liste)



                                                                                              ;liste_to_chaine: list ---> string
(define liste_to_chaine (lambda (liste)
                        (with-output-to-string (lambda () (write liste)))
                         ))

                                                                                              ;chaine-to_liste: chaine ---> list
(define chaine_to_liste (lambda (chaine)
                        (read-from-string-all
                        (string-replace
                        (string-replace
                        (string-replace
                        (string-replace chaine "+)" "+0)") "*)" "*1)") "*" " * ") "+" " + ")
                        (lambda (event)    '(Veuillez vérifier vos parenthèses SVP !!!))
                         )))
