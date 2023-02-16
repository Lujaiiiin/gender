         CLIPS (6.30 3/17/15)
CLIPS> (clear)
CLIPS> (deffunction ProposeQuestion (?question $?allowed-values)
	(printout t ?question)
	(bind ?answer (read))
	(if (lexemep ?answer)
		then (bind ?answer (lowcase ?answer)))
	(while (not (member ?answer ?allowed-values)) do
		(printout t ?question)
		(bind ?answer (read))
		(if (lexemep ?answer)
			then (bind ?answer (lowcase ?answer))))
	?answer)
CLIPS> 
(deffunction yesOrNo (?question)
	(bind ?response (ProposeQuestion ?question yes no y n))
	(if (or (eq ?response yes) (eq ?response y))
		then yes
		else no))
CLIPS> (defglobal
?*girl* = 0
?*boy* = 0)
CLIPS> (defrule HealthierHairNails
	(not(Healthy ?))
	=> 
	(bind ?*boy* (+ ?*boy* 10))
	(assert(Healthy (yesOrNo "Do you notice getting healthy hair and nails ? (yes|no): "))))
CLIPS> (defrule cravingSaltyFood
	(Healthy yes)
	(not(Salty ?))
	=>
	(bind ?*boy* (+ ?*boy* 10))
	(assert(Salty(yesOrNo "Are you craving salty food? (yes|no): "))))
CLIPS> 
(defrule cravingSaweetFood
	(Healthy no)
	(not(Salty ?))
	=>
	(bind ?*girl* (+ ?*girl* 10))
	(assert(Salty (yesOrNo "Are you craving salty food? (yes|no): "))))
CLIPS> 
(defrule UpfrontBelly
	(Salty yes)
	(not(Upfront ?))
	=>
	(bind ?*boy* (+ ?*boy* 10))
	(assert(Upfront (yesOrNo "Is your belly upfront? (yes|no): "))))
CLIPS> (defrule WideBelly
	(Salty no)
	(not(Upfront?))
	=>
	(bind ?*girl* (+ ?*girl* 10))
	(assert(Upfront (yesOrNo "Is your belly Wide? (yes|no): "))))
CLIPS> (defrule lowMoodSwings
	(Upfront yes)
	(not (MoodSwings ?))
	=>
	(bind ?*boy* (+ ?*boy* 20))
	(assert(MoodSwings (yesOrNo "Do you have low mood swings? (yes|no): "))))
CLIPS> (defrule highMoodSwings
	(Upfront no)
	(not(MoodSwings?))
	=>
	(bind ?*girl* (+ ?*girl* 20))
	(assert(MoodSwings (yesOrNo "Do you have low mood swings? (yes|no): "))))
	CLIPS> 

(defrule coldFeet
	(MoodSwings yes)
	(not(cold ?))
	=>
	(bind ?*girl* (+ ?*girl* 10))
	(assert(cold (yesOrNo "Are having cold feet? (yes|no): "))))
CLIPS> 	
(defrule WormFeet
	(MoodSwings no)
	(not(cold ?))
	=>
	(bind ?*boy* (+ ?*boy* 10))
	(assert(cold (yesOrNo "Are having cold feet? (yes|no): "))))
CLIPS> 
(defrule gestationalDiabetes 
	(cold yes)
	(not(Diabetes ?))
	=>
	(bind ?*boy* (+ ?*boy* 10))
	(assert(Diabetes (yesOrNo "Developed gestational diabetes? (yes|no): "))))
CLIPS> (defrule gestationalDiabetesNo 
	(cold no)
	(not(Diabetes ?))
	=>
	(bind ?*girl* (+ ?*girl* 10))
	(assert(Diabetes (yesOrNo "Developed gestational diabetes? (yes|no): "))))
CLIPS> 
(defrule morningSickness
	(Diabetes no)
	(not(Sickness ?))
	=>
	(bind ?*boy* (+ ?*boy* 10))
	(assert(Sickness(yesOrNo "Do you have extreme morning sickness? (yes|no): "))))
CLIPS> (defrule NoMorningSickness
	(Diabetes yes)
	(not(Sickness ?))
	=>
	(bind ?*girl* (+ ?*girl* 10))
	(assert(Sickness (yesOrNo "Do you have extreme morning sickness? (yes|no): "))))
CLIPS> (defrule SkinBreakout
	(Sickness no)
	(not(Breakout ?))
	=>
	(bind ?*boy* (+ ?*boy* 10))
	(assert(Breakout (yesOrNo "Is your skin breaking out? (yes|no): "))))
CLIPS> (defrule NoSkinBreakout
	(Sickness yes)
	(not(Breakout ?))
	=>
	(bind ?*girl* (+ ?*girl* 10))
	(assert(Breakout (yesOrNo "Is your skin breaking out? (yes|no): "))))

CLIPS> 
(defrule CarryingHigh
	(Breakout no)
	(not(Carryin ?))
	=>
	(bind ?*boy* (+ ?*boy* 10))
	(assert(Carryin (yesOrNo "Are you Carrying High (yes|no): "))))
CLIPS> (defrule CarryingLow
	(Breakout yes)
	(not(Carryin ?))
	=>
	(bind ?*girl* (+ ?*girl* 10))
	(assert(Carryin (yesOrNo "Are you Carrying low (yes|no): "))))
CLIPS> (run)
CLIPS> 
(defrule printresolt
(declare (salience -10))
=>
(printout t "_____________________________" crlf)
(printout t "                             " crlf)
(printout t "The chance of having Boy: " ?*boy* "%" crlf)
(printout t "The chance of having Girl: " ?*girl* "%" crlf))
CLIPS> (run)
