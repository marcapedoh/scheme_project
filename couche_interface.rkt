#lang scheme

(require "couche_application.rkt")
(require "service_simplification.rkt")
(require racket/gui)
(require racket/draw)
(require mzlib/string)

#|(define policeA (make-object font% 11 'script 'normal 'bold #f 'smoothed))
(define policeB (make-object font% 12 'script 'normal 'bold #f))
(define policeC (make-object font% 16 'roman 'normal 'bold #t))
(define policeD (make-object font% 14 'roman 'italic 'bold #f))
(define policeE (make-object font% 24 'script 'normal 'bold #t))

(define font_titre (make-object font% 15 'decorative 'normal 'bold #f 'smoothed))
(define font_acceuil (make-object font% 16 'decorative 'normal 'bold #f 'smoothed))
(define font_bouton (make-object font% 13 'decorative 'normal 'bold #t))
(define font_message (make-object font% 12 'decorative 'normal 'bold #f 'smoothed))


(define OUVERTURE (new frame% [label "  "]
                       [width 450]
                       [height 200]
                       [style '(no-caption no-system-menu no-resize-border)]
                   )
  )
(send OUVERTURE center 'both)
(define Texte_ouverture (new message%
                             [parent OUVERTURE]
                             [label "     "]
                             [font font_acceuil]
                             [vert-margin 40]
                             [horiz-margin 10]
                             [min-width 500]
                         )
  )

(define ACCEUIL (new frame% [label "Simplicateur d'expression"]
                     [width 800]
                     [height 750]
                     [style '(no-caption no-system-menu no-resize-border)]
                  )
  )
(send ACCEUIL center 'both)

(define Texte_acceuil (new message%
                          [parent ACCEUIL]
                          [label "      "]
                          [font font_acceuil]
                          [vert-margin 10]
                          [horiz-margin 40]
                          [min-width 500]
                          )
  )

(define image_ac (make-object bitmap% "https://cdn.pixabay.com/photo/2015/11/15/07/47/geometry-1044090_640.jpg"))

(new canvas% [parent ACCEUIL]
     [paint-callback (lambda (canvas dc)
                      (send dc draw-bitmap image_ac 0 0)
                      )]
     [min-width 450]
     [min-height 250]
     [vert-margin 20]

)

(new message% [parent ACCEUIL]
     [label "Prof: Dr NOUSSI"]
     [font policeD]
)

(new message% [parent ACCEUIL]
     [label "Réalisé par APEDOH KOSSI KEKELI"]
     [font policeC]
)

(define fen_prin_go (lambda(o e)
                      (send ACCEUIL on-exit)
                      (send FRAME show #t)
                    )
 )

(define panel_bouton (new horizontal-panel%
                          [parent ACCEUIL]
                          [min-width 400]
                          [vert-margin 5]
                          [alignment '(center center)]
                      )
 )

(define boutton_go (new button%
                        [label "Continuer"]
                        [parent panel_bouton]
                        [font font_bouton]
                        [callback fen_prin_go]
                    )
 )

(define bouton_ret (new button%
                        [label "QUITTER"]
                        [parent panel_bouton]
                        [font font_bouton]
                        [callback (lambda (o event)
                                    (let
                                        ([rep (message-box/custom
                                               "QUITTER" "Voulez-vous vraiment quitter...?"
                                               "Oui" "Non" "Annuler")]
                                         )
                                         (cond ((= rep 1) (send ACCEUIL on-exit))
                                         )
                                     )
                                    )
                                  ]
                        )

  )

(define FRAME (new frame% [label "TP Simplification arthmétique"]
                   [width 650]
                   [height 400]
                   [border 5]
                   [style '(no-resize-border)]
                )
  )

(send FRAME center 'both)

(define acceuil (make-object bitmap% "https://cdn.pixabay.com/photo/2015/11/15/07/47/geometry-1044090_640.jpg"))

(new canvas% [parent FRAME]
     [paint-callback (lambda (canvas dc)
                       (send dc draw-bitmap acceuil 0 0)
                       )
     ]
     [min-width 450]
     [min-height 85]
)

(define PANEL_TITRE (new vertical-panel%
                         [parent FRAME]
                         [style (list 'border)]
                         [vert-margin 2]
                         [alignment '(center center)]
                     )
 )
(define message_titre(new message% [parent PANEL_TITRE]
                          [label "SIMPLIFIER DES EXPRESSIONS ARTHMETIQUE"]
                          [font policeE]
                      )
)

(define PANEL_1 (new vertical-panel%
                     [parent FRAME]
                 )
 )

(define ECRAN_AFF (new group-box-panel% [parent PANEL_1]
                       [label "Forme de l'expression simplifiée"]
                       [font policeB]
                       [alignment '(center center)]
                    )
  )

(define ECRAN_EXP (new group-box-panel% [parent PANEL_1]
                       [alignment '(right center)]
                       [label "EXPRESSION"]
                       [border 10]
                  )
  )
(define Expression (new text-field% [parent ECRAN_EXP]
                        [label "EXPRESSION A SIMPLIFIER: "]
                        [font policeB]
                    )
  )


(define Textsimple (new text-field% [parent ECRAN_AFF]
                        [label "EXPRESSION A SIMPLIFIEE      "]
                        [font policeB]
                    )
)

(send Textsimple enable #f)

(define dialogue_message (new dialog% [label "INFORMATION"]
                              [alignment '(center center)]

                          )
  )

(define PANEL_DIALOGUE (new vertical-panel% [parent dialogue_message]))

(define message (new message% [parent PANEL_DIALOGUE]
                     [label "test"]
                     [font font_message]
                     [vert-margin 15]
                     [horiz-margin 5]
                     [min-width 350]
                  )
  )

(new button% [parent PANEL_DIALOGUE]
     [label "OK"]
     [callback (lambda (button event)
                 (send dialogue_message show #f)
                )
     ]
)


(define dialogue_confirmation (new dialog% [label "Confirmation"]
                                   [alignment '(center center)]
                               )
  )

(define message_confirmation (new message% [parent dialogue_confirmation]
                                  [label "TEST"]
                                  [font font_message]
                                  [vert-margin 15]
                                  [horiz-margin 5]
                                  [min-width 280]
                              )
  )

(define PANEL_DIALOGUE_CONF (new horizontal-panel% [parent dialogue_confirmation]
                                 [alignment '(center center)]
                             )
  )

(new button% [parent PANEL_DIALOGUE_CONF]
     [label "Oui"]
     [font font_bouton]
     [callback (lambda(button event)
                 (send dialogue_confirmation show #t)
                 (send Expression focus)
                )
     ]
)

(define action_simplifier (lambda (button event)
                            (cond
                              ((string=? (send Expression get-value) "")
                               (send message set-label " Veuillez saisir l'expression à simplifier! ")
                               (send dialogue_message show #t)
                              )

                              (#t
                                  (send Textsimple set-value
                                   (liste_to_chaine (simplification
                                                              (chaine_to_liste (send Expression get-value))
                                                             )
                                    )
                                   )
                               )
                             )
                          )
  )

(define PANEL_2 (new horizontal-panel% [parent FRAME]
                     [alignment '(center center)]
                 )
)

(define Boutton_simplifier (new button% [parent PANEL_2]
                                [label "VALIDER"]
                                [font font_bouton]
                                [horiz-margin 40]
                                [min-height 30]
                                [callback action_simplifier]
                            )
)

(define bouton_quitter (new button% [parent PANEL_2]
                            [label "QUITTER"]
                            [font font_bouton]
                            [horiz-margin 30]
                            [min-height 30]
                            [callback (lambda (o event)
                                        (let
                                            ([rep (message-box/custom
                                                   "Quitter" "Voulez-vous vraiment quitter ce programme?"
                                                   "Oui" "Non" "Annuler"
                                                   )
                                             ]
                                            )
                                          (cond ((= rep 1) (send FRAME on-exit)))
                                         )
                                       )
                            ]
                       )
  )


(define boutton_effacer (new button% [parent PANEL_2]
                             [label "EFFACER"]
                             [horiz-margin 40]
                             [min-height 30]
                             [font font_bouton]
                             [callback (lambda (button event)
                                   (let
                                       ([rep (message-box/custom
                                              "Effacer" "Voulez-vous effacer l'expression ?"
                                              "Oui" "Non" "Annuler")
                                         ]
                                        )
                                        (cond ((= rep 1) (send Expression set-value "")
                                                         (send Textsimple set-value "")
                                                         (send Expression focus))
                                         )
                                     )
                                   )
                              ]
                             )
  )


(define aide_message (new dialog% [label "Conditions d'utilisations"]
                          [alignment '(center center)]
                          [min-width 300]
                          [min-height 200]
                      )
)

(define PANEL_aide_message (new vertical-panel% [parent aide_message]))

(define zone_message (new message% [parent PANEL_aide_message]
                          [label "TEST"]
                          [font font_message]
                          [vert-margin 20]
                          [horiz-margin 20]
                          [min-width 500]
                          [min-height 150]
                      )
  )
(new button% [parent PANEL_aide_message]
     [label "Compris"]
     [horiz-margin 40]
     [vert-margin 20]
     [font font_bouton]
     [callback (lambda (button event)
                 (send aide_message show #t)
               )
     ]
)

(define bouton_aide (new button% [parent PANEL_2]
                         [label " AIDE "]
                         [horiz-margin 40]
                         [min-height 30]
                         [font font_bouton]
                         [callback (lambda (button event)
                                     (send zone_message set-label conditions)
                                     (send aide_message show #t)
                                    )
                         ]
                      )
  )

(define conditions "Les expressions à simplifer doivent contenir que:
1-) Des symboles arithmétiques + ou *
2-) Des parenthèses
3-) Des lettres non accentuées
Exemple: (x+(y*2))*(x+(0*y)) ---> ((x+(y*2)*x")

(send OUVERTURE show #t)
(sleep/yield 0.40)
(send Texte_ouverture set-label "Chargement...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                    Chargement...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                                  Chargement ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                                                  Chargement ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label " Chargement ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                Chargement ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                                 Chargement ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                                                 Chargement ...")
(sleep/yield 1)
(send OUVERTURE show #f)


(send ACCEUIL show #t)                                                                               ;ouverture de la page d'accueil
(sleep/yield 0.60)

(send Texte_acceuil set-label "BIENVENU(E) SUR SIMPLIFICATEUR D'EXPRESSION")
(sleep/yield 4)
|#

                                                                                         ;definition des polices
(define policeA (make-object font% 11 'script 'normal 'bold #f 'smoothed))
(define policeB (make-object font% 12 'script 'normal 'bold #f))
(define policeC (make-object font% 16 'roman  'normal 'bold #t))
(define policeD (make-object font% 14 'roman  'italic 'bold #f))
(define policeE (make-object font% 24 'script 'normal 'bold #t))

                                                                                         ;definition des styles de polices
(define font_titre     (make-object font% 15 'decorative 'normal 'bold #f 'smoothed))
(define font_accueil   (make-object font% 16 'decorative 'normal 'bold #f 'smoothed))
(define font_bouton    (make-object font% 13 'decorative 'normal 'bold #t ))
(define font_message   (make-object font% 12 'decorative 'normal 'bold #f 'smoothed))


;----------------------------------------------------------------------------------------FENETRE D'OUVERTURRE

(define OUVERTURE (new frame% [label "   "]                                              ;definition de la fenetre d'ouverture
                            [width 300]
                            [height 100]
                            [style '(no-caption no-system-menu no-resize-border)]
                       ))

(send OUVERTURE center 'both)                                                            ;centrer la fenetre d'ouverture

   
(define Texte_ouverture (new message%                                                    ;le message a y passer
                            [parent OUVERTURE]
                            [label "        "]
                            [font font_accueil]
                            [vert-margin 40]
                            [horiz-margin 10]
                            [min-width 500]
                           ))


;----------------------------------------------------------------------------------------FENETRE D'ACCUEIL

(define ACCUEIL (new frame% [label "Simplicateur"]                          ;definition de la fenetre d'accueil
                          [width 350]
                          [height 150]
                          [style '(no-caption no-system-menu no-resize-border)]
                     ))


(send ACCUEIL center 'both)                                                              ;centrer la fenetre dans toutes les directions


(define Texte_accueil (new message%                                                      ;le message d'en tete de la fenetre accueil
                         [parent ACCUEIL]
                         [label " "]
                         [font font_accueil]
                         [vert-margin 10]
                         [horiz-margin 40]
                         [min-width 500]
                      ))


;(define image_ac  (make-object bitmap% "TP_photo/fond3.png"))        ;definition des images de la fenetre accueil


#|(new canvas% [parent ACCUEIL]                                       ;zone d'affichage de l'image de décore
            [paint-callback (lambda (canvas dc)
                            (send dc draw-bitmap image_ac 0 0)
                            )]
            [min-width 450]
            [min-height 200]
            [vert-margin 20]
            )|#


#|(new message% [parent ACCUEIL]                                     ;les messages a afficher a la page d'accueil
              [label "Supervisé par: Dr NOUSSI Roger"]
              [font policeD]
              )|#

#|(new message% [parent ACCUEIL]
              [label "Etudiant: HELOU Komlan Mawulé"]
              [font policeC]
              )|#

        

(define fen_prin_go (lambda (o e)                                  ;la fonction à executer apres un clic sur le bouton
               (send ACCUEIL on-exit)
               (send FRAME  show #t)
               ))

(define panel_bouton (new horizontal-panel%
                          [parent ACCUEIL]
                          [min-width 400]
                          [vert-margin 5]
                          [alignment '(center center)]
                          ))
(define bouton_go (new button%                                     ;Bouton permettant d'acceder au menu principale
                  [label "CONTINUER"]
                  [parent panel_bouton]
                  [font font_bouton]
                  [callback fen_prin_go]
                  ))


(define bouton_ret (new button%                                     ;bouton pour retourner (annuler les actions
                  [label "QUITTER"]
                  [parent panel_bouton]
                  [font font_bouton]
                  [callback  (lambda (o event)
                                 (let
                                     ([rep (message-box/custom 
                                            "Quitter" "Voulez-vous vraiment quitter...?"
                                            "oui" "Non" "Annuler" )])
                                     (cond ((= rep 1) (send ACCUEIL on-exit))
                                           ))
                                   )]
                  ))


;----------------------------------------------------------------------------------------FENETRE PRINCIPALE

(define FRAME (new frame% [label "TP Simplification"]       ;definition de la fenetre principale
              [width 500]
              [height 200]
              [border 5]
              [style '(no-resize-border)]
              ))

(send FRAME center 'both)                                                ;centrer la fenetre dans toutes les directions 

#|
(define accueil   (make-object bitmap% "TP_photo/accueil.jpg"))          ;definition des images de la fenetre principale

(new canvas% [parent FRAME]                                              ;Zone d'affichage de l'image
             [paint-callback (lambda (canvas dc)
                            (send dc draw-bitmap accueil 0 0)
                            )]
             [min-width 450]
             [min-height 85]
            )|#


#|(define PANEL_TITRE (new vertical-panel%                                 ;panneau de titre de l'application
                       [parent FRAME]
                       [style (list 'border)]
                       [vert-margin 2]
                       [alignment '(center center)]
                     ))|#

                                                
#|(define message_titre(new message% [parent PANEL_TITRE]                                ;Titre de l'application
                           [label "Simplification des expressions arithmétiques"]
                           [font policeE]
                           ))|#


(define PANEL_1 (new vertical-panel%                                   ;panneau numéro 1: il contient la  forme de l'expression simplifier
                 [parent FRAME]
                 ))


(define ECRAN_AFF (new group-box-panel% [parent PANEL_1]               ;ecran d'affichage du resultat
                        [label "Forme de l'expression simplifiée"]
                        [font policeC]
                        [alignment '(center center)]
                        ))


(define ECRAN_EXP (new group-box-panel% [parent PANEL_1]                ;ecran d'edition de l'expression zone éditable
                       [alignment '(right center)]
                       [label "Expresssion"]
                       [border 10]
                       ))


(define Expression (new text-field% [parent ECRAN_EXP]                  ;traitement des données récupérer de l'ecran exp
                      [label "Expression à simplifier: "]
                      [font policeA]
                      ))


(define Textsimple (new text-field% [parent ECRAN_AFF]                  ;Ecran d'affichage du résultat de la simplification
                       [label "Expression simplifiée      "]
                       [font policeC]
                       ))

(send Textsimple enable #f)                                                             

;----------------------------------------------------------------------------------------Boite de bialogue pour auitter
(define dialogue_message (new dialog% [label "Information"]                ;Définition de la boite de dialogue message pour quitter
                              [alignment '(center center)]
                              ))

(define PANEL_DIALOGUE (new vertical-panel% [parent dialogue_message]))    ;panneau de dialogue créer dans la boite de dialogue

(define message (new message% [parent PANEL_DIALOGUE]
                     [label "test"]
                     [font font_message]
                     [vert-margin 15]
                     [horiz-margin 5]
                     [min-width 350]
                     
                     ))


(new button% [parent PANEL_DIALOGUE]                          ;boite de dialogue au cas ou le domaine valider est vide
             [label "OK"]
             [callback (lambda (button event)
                         (send dialogue_message show #f)
                         )])

;---------------------------------------------------------------------------------------
(define dialogue_confirmation (new dialog% [label "Confirmation"]                ;boite de dialogue confirmation pour rendre vide le champ
                                   [alignment '(center center)]
                                   ))

(define message_confirmation (new message% [parent dialogue_confirmation]
                                  [label "Test"]
                                  [font font_message]
                                  [vert-margin 15]
                                  [horiz-margin 5]
                                  [min-width 280]
                                  ))

(define PANEL_DIALOGUE_CONF (new horizontal-panel% [parent dialogue_confirmation]
                                 [alignment '(center center)]
                                 ))

(new button% [parent PANEL_DIALOGUE_CONF]
             [label "Oui"]
             [font font_bouton]
             [callback (lambda (button event)
                         (send dialogue_confirmation show #t)
                         (send Expression focus))]
             )



(define action_simplifier (lambda (button event)                                   ;fonction pour evaluer le resultat de l'expression saisie
                                  (cond
                                    ((string=? (send Expression get-value) "")
                                     (send message set-label "  Veillez saisir l'expression à simplifier !") 
                                     (send dialogue_message show #t) 
                                     )

                                    (#t
                                           (send Textsimple set-value
                                           (liste_to_chaine (simplification
                                                            (chaine_to_liste (send Expression get-value))))) 
                                        
                                       ))))

;---------------------------------------------------------------------------------------------------------Les boutons de la fenetre principale
(define PANEL_2 (new horizontal-panel% [parent FRAME]                ;Deuxieme panel
                     [alignment '(center center)]
                     ))


(define Bouton_simplifier (new button% [parent PANEL_2]              ; bouton pour simplifier
                               [label "VALIDER"]
                               [font font_bouton]
                               [horiz-margin 40]
                               [min-height 30]
                               [callback action_simplifier]
                                          
                               ))


(define bouton_quitter (new button% [parent PANEL_2]                 ;boutton pour quitter
                     [label "QUITTER"]
                     [font font_bouton]
                     [horiz-margin 30]
                     [min-height 30]
                     [callback  (lambda (o event)
                                 (let
                                     ([rep (message-box/custom
                                            "Quitter" "Voulez-vous vraiment quitter ce programme ?"
                                            "oui" "Non" "Annuler" )])
                                     (cond ((eq? rep 1) (send FRAME on-exit))
                                         )))]
                                   
                     ))


(define bouton_effacer (new button% [parent PANEL_2]                 ;definition du boutton effacer
                            [label "EFFACER"]
                            [horiz-margin 40]
                            [min-height 30]
                            [font font_bouton]
                            [callback (lambda (button event)
                                 (let
                                     ([rep (message-box/custom
                                            "Effacer" "Voulez-vous effacer l'expression ?"
                                            "oui" "Non" "Annuler")])
                                     (cond ((= rep 1) (send Expression set-value "")
                                                       (send Textsimple set-value "")
                                                       (send Expression focus))
                                         )))]
                            ))
;-------------------------------------------------------------------------------Bouton AIDE et ses actions
(define aide_message (new dialog% [label "Conditions d'utilisations"]      ;Définition de la boite de dialogue message pour quitter
                              [alignment '(center center)]
                              [min-width 300]
                              [min-height 200]
                              ))

(define PANEL_aide_message (new vertical-panel% [parent aide_message]))    ;panneau de dialogue créer dans la boite de dialogue


(define zone_message (new message% [parent PANEL_aide_message]
                     [label "Test"]
                     [font font_message]
                     [vert-margin 20]
                     [horiz-margin 20]
                     [min-width 500]
                     [min-height 150]
                     ))


(new button% [parent PANEL_aide_message]                ;boite de dialogue au cas ou le domaine valider est vide
             [label "COMPRIS"]
              [horiz-margin 40]
              [vert-margin 20]
              [font font_bouton]
             [callback (lambda (button event)
                         (send aide_message show #f)
                         )])

(define bouton_aide (new button% [parent PANEL_2]
                         [label " AIDE? "]
                         [horiz-margin 40]
                         [min-height 30]
                         [font font_bouton]
                         [callback (lambda (button event)
                                    (send zone_message set-label conditions)
                                    (send aide_message show #t)

                                     )]))
                                     
(define conditions "Les expressions à simplifier doivent contenir que:

1-) Des symboles arithmétiques + ou *
2-) Des parenthèses
3-) Des lettres non accentuées
Exemple: (x+(y*2))*(x+(0*y)) ---> ((x+(y*2)*x")


;------------------------------------------------------------------------------------------------------OUVERTURE DE L'APPLICATION

#|(send OUVERTURE show #t)
(sleep/yield 0.40)
(send Texte_ouverture set-label "Ouverture...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                    Ouverture...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                                  Ouverture ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                                                  Ouverture ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label " Ouverture ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                Ouverture ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                                 Ouverture ...")
(sleep/yield 0.5)

(send Texte_ouverture set-label "                                                 Ouverture ...")
(sleep/yield 1)
(send OUVERTURE show #f)
|#

(send ACCUEIL show #t)                                                                              ;ouverture de la page d'accueil
(sleep/yield 0.60)

(send Texte_accueil set-label "SIMPLIFICATION ARTHMETIQUE par APEDOH")
(sleep/yield 4)
