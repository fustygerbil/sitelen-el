;; Define a quail input method for entering sitelen pona glyphs (toki pona) in emacs

;; Based on a discouraged method described here:
;; https://www.kreativekorp.com/ucsur/charts/sitelen.html
;; and after failing to have opentype features work automatically
;; possibly related: https://emacs.stackexchange.com/a/61981
;; - as long as relevant unicode blocks are mapped to e.g. Fairfax Pona HD,
;;   a different principal font can be set
;; - (use-package unicode-fonts)
;; - (set-fontset-font t '(#xe000 . #xf8ff) "Fairfax Pona HD")
;; - (set-fontset-font t '(#xf0000 . #x10ffff) "Fairfax Pona HD")

;; Latin to glyph mappings assume Fairfax Pona HD font, with some additions:
;; - single space ends current glyph entry
;;   - e.g. /e suno/ vs /esun o/
;; - double space maps to a single space
;; - underscore "_" places preceding glyph between top/bottom cartouche lines
;; - "Pi" starts extended pi
;;   - comma "," places preceding glyph above Pi extension line




;; eval in open-relay/features/asuki.fea to get commented quail rule pairs 
(defun my/quailify ()
  "Convert a .fea transliteration buffer into quail rule pairs."
  (while (re-search-forward "#" nil t)
    (replace-match ";"))
  (while (re-search-forward "^u[[:word:]]+[[:space:]]+[^[:space:]]+" nil t)
    (let* ((start (match-beginning 0))
           (end (match-end 0))
           (match (match-string 0 nil))
           (split (string-split match "[[:space:]]+" t))
           (char (string (read (concat "#x" (downcase (substring (car split) 1))))))
           (latin (cadr split)))
      (delete-region start end)
      (insert (format "(%S ?%s)" latin char)))))

;; see https://lipu-sona.pona.la/sitelen_ucsur.gif
(require 'quail)
(quail-define-package
 "toki-pona" "Toki Pona" "󱥕" nil
 "A transliteration scheme for Toki Pona characters."
 nil t t t t nil nil nil nil nil t)
(quail-define-rules
                                        ; single words - nimi pu
 ("a" ?󱤀)	; a, default
 ("a1" ?󿬐)	; a, straight exclamation radical
 ("a2" ?󿬑)	; a, diagonal exclamation radical
 ("a3" ?󿵠)	; a, double exclamation
 ("a4" ?󿵡)	; a, triple exclamation
 ("a5" ?󿵢)	; a, interrobang
 ("akesi" ?󱤁)	; akesi, default, upright
 ("akesi1" ?󱤁)	; akesi, six-legged, upright
 ("akesi2" ?󿵣)	; akesi, four-legged, upright
 ("akesiv" ?󿫿)	; akesi, default, turned
 ("akesiv1" ?󿫿)	; akesi, six-legged, turned
 ("akesiv2" ?󿵤)	; akesi, four-legged, turned
 ("ala" ?󱤂)	; ala
 ("alasa" ?󱤃)	; alasa
 ("ale" ?󱤄)	; ale, synonym of ali
 ("ali" ?󱤄)	; ali, synonym of ale
 ("anpa" ?󱤅)	; anpa
 ("ante" ?󱤆)	; ante
 ("anu" ?󱤇)	; anu
 ("awen" ?󱤈)	; awen
 ("e" ?󱤉)	; e
 ("en" ?󱤊)	; en
 ("esun" ?󱤋)	; esun
 ("ijo" ?󱤌)	; ijo
 ("ike" ?󱤍)	; ike
 ("ilo" ?󱤎)	; ilo
 ("insa" ?󱤏)	; insa
 ("jaki" ?󱤐)	; jaki
 ("jan" ?󱤑)	; jan
 ("jelo" ?󱤒)	; jelo
 ("jo" ?󱤓)	; jo
 ("kala" ?󱤔)	; kala, default
 ("kala1" ?󱤔)	; kala, without eyes
 ("kala2" ?󿪠)	; kala, with eyes
 ("kalama" ?󱤕)	; kalama
 ("kama" ?󱤖)	; kama
 ("kasi" ?󱤗)	; kasi
 ("ken" ?󱤘)	; ken
 ("kepeken" ?󱤙)	; kepeken, synonym of kepen
 ("kepen" ?󱤙)	; kepen, synonym of kepeken
 ("kili" ?󱤚)	; lili
 ("kiwen" ?󱤛)	; kiwen
 ("ko" ?󱤜)	; ko
 ("kon" ?󱤝)	; kon
 ("kule" ?󱤞)	; kule
 ("kulupu" ?󱤟)	; kulupu
 ("kute" ?󱤠)	; kute
 ("la" ?󱤡)	; la
 ("lape" ?󱤢)	; lape
 ("laso" ?󱤣)	; laso
 ("lawa" ?󱤤)	; lawa
 ("len" ?󱤥)	; len
 ("lete" ?󱤦)	; lete
 ("li" ?󱤧)	; li
 ("lili" ?󱤨)	; lili
 ("linja" ?󱤩)	; linja
 ("lipu" ?󱤪)	; lipu
 ("loje" ?󱤫)	; loje
 ("lon" ?󱤬)	; lon
 ("luka" ?󱤭)	; luka
 ("lukin" ?󱤮)	; lukin
 ("lupa" ?󱤯)	; lupa
 ("ma" ?󱤰)	; ma
 ("mama" ?󱤱)	; mama
 ("mani" ?󱤲)	; mani
 ("meli" ?󱤳)	; meli, default
 ("meli1" ?󱤳)	; meli, head with hair
 ("meli2" ?󿪡)	; meli, female sign
 ("meli3" ?󿴙)	; meli, circle with letter L
 ("mi" ?󱤴)	; mi, default
 ("mi1" ?󿬄)	; mi, straight
 ("mi2" ?󿬅)	; mi, curved
 ("mije" ?󱤵)	; mije, default
 ("mije1" ?󱤵)	; mije, head and shoulders
 ("mije2" ?󿪢)	; mije, male sign
 ("mije3" ?󿴘)	; mije, circle with letter J
 ("moku" ?󱤶)	; moku
 ("moli" ?󱤷)	; moli, default
 ("moli1" ?󱤷)	; moli, head with X eyes
 ("moli2" ?󿵨)	; moli, X eyes and mouth
 ("monsi" ?󱤸)	; monsi
 ("mu" ?󱤹)	; mu, default
 ("mu1" ?󱤹)	; mu, mouse face
 ("mu2" ?󿪸)	; mu, emitters
 ("mun" ?󱤺)	; mun
 ("musi" ?󱤻)	; musi, default
 ("musi1" ?󱤻)	; musi, curved ends
 ("musi2" ?󿴮)	; musi, straight ends
 ("mute" ?󱤼)	; mute, default
 ("mute1" ?󱤼)	; mute, three lines
 ("mute2" ?󿵩)	; mute, four hands
 ("nanpa" ?󱤽)	; nanpa
 ("nasa" ?󱤾)	; nasa
 ("nasin" ?󱤿)	; nasin
 ("nena" ?󱥀)	; nena
 ("ni" ?󱥁)	; ni, default
 ("ni1" ?󿬃)	; ni, downwards
 ("ni2" ?󿬂)	; ni, rightwards
 ("ni3" ?󿬁)	; ni, upwards
 ("ni4" ?󿬀)	; ni, leftwards
 ("ni5" ?󿵲)	; ni, southeast
 ("ni6" ?󿵱)	; ni, northeast
 ("ni7" ?󿵰)	; ni, northwest
 ("ni8" ?󿵳)	; ni, southwest
 ("nimi" ?󱥂)	; nimi
 ("noka" ?󱥃)	; noka
 ("o" ?󱥄)	; o, default
 ("o1" ?󿬒)	; o, straight exclamation radical
 ("o2" ?󿬓)	; o, diagonal exclamation radical
 ("olin" ?󱥅)	; olin, default
 ("olin0" ?󿵴)	; olin, disconnected double pilin
 ("olin1" ?󿵵)	; olin, overlapping double pilin
 ("olin2" ?󿪣)	; olin, pilin with emitters
 ("ona" ?󱥆)	; ona, default
 ("ona1" ?󿬈)	; ona, straight
 ("ona2" ?󿬉)	; ona, curved
 ("open" ?󱥇)	; open
 ("pakala" ?󱥈)	; pakala
 ("pali" ?󱥉)	; pali
 ("palisa" ?󱥊)	; palisa
 ("pan" ?󱥋)	; pan
 ("pana" ?󱥌)	; pana
 ("pi" ?󱥍)	; pi
 ("pilin" ?󱥎)	; pilin
 ("pimeja" ?󱥏)	; pimeja
 ("pini" ?󱥐)	; pini
 ("pipi" ?󱥑)	; pipi
 ("poka" ?󱥒)	; poka
 ("poki" ?󱥓)	; poki
 ("pona" ?󱥔)	; pona
 ("pu" ?󱥕)	; pu
 ("sama" ?󱥖)	; sama
 ("seli" ?󱥗)	; seli
 ("selo" ?󱥘)	; selo
 ("seme" ?󱥙)	; seme
 ("sewi" ?󱥚)	; sewi, default
 ("sewi1" ?󱥚)	; sewi, Arabic
 ("sewi2" ?󿪤)	; sewi, secularized
 ("sijelo" ?󱥛)	; sijelo
 ("sike" ?󱥜)	; sike
 ("suke" ?󱥜)	; suke, typo of sike
 ("sin" ?󱥝)	; sin
 ("sina" ?󱥞)	; sina, default
 ("sina1" ?󿬆)	; sina, straight
 ("sina2" ?󿬇)	; sina, curved
 ("sinpin" ?󱥟)	; sinpin
 ("sitelen" ?󱥠)	; sitelen
 ("sona" ?󱥡)	; sona
 ("soweli" ?󱥢)	; soweli
 ("suli" ?󱥣)	; suli
 ("suno" ?󱥤)	; suno
 ("supa" ?󱥥)	; supa
 ("suwi" ?󱥦)	; suwi
 ("tan" ?󱥧)	; tan
 ("taso" ?󱥨)	; taso
 ("tawa" ?󱥩)	; tawa
 ("telo" ?󱥪)	; telo
 ("tenpo" ?󱥫)	; tenpo, default
 ("tenpo1" ?󱥫)	; tenpo, clock
 ("tenpo2" ?󿮭)	; tenpo, hourglass
 ("toki" ?󱥬)	; toki
 ("tomo" ?󱥭)	; tomo
 ("toma" ?󱥭)	; toma, typo of tomo
 ("tu" ?󱥮)	; tu
 ("unpa" ?󱥯)	; unpa
 ("uta" ?󱥰)	; uta, default
 ("uta1" ?󱥰)	; uta, dotted
 ("uta2" ?󿪥)	; uta, dotless
 ("utala" ?󱥱)	; utala
 ("walo" ?󱥲)	; walo
 ("wan" ?󱥳)	; wan
 ("waso" ?󱥴)	; waso
 ("wawa" ?󱥵)	; wawa
 ("weka" ?󱥶)	; weka
 ("wile" ?󱥷)	; wile, default
 ("wile1" ?󱥷)	; wile, curved w
 ("wile2" ?󿪦)	; wile, turned pilin

                                        ; single words - nimi ku suli
 ("epiku" ?󱦃)	; epiku, default
 ("epiku1" ?󿪫)	; epiku, upwards arrow
 ("epiku2" ?󿪬)	; epiku, pona with emitters
 ("jasima" ?󱥿)	; jasima
 ("kijetesantakalu" ?󱦀)	; kijetesantakalu, default
 ("kijetesantakalu1" ?󱦀)	; kijetesantakalu, raccoon
 ("kijetesantakalu2" ?󿷈)	; kijetesantakalu, armadillo
 ("kin" ?󱥹)	; kin, default
 ("kin1" ?󿬔)	; kin, straight exclamation radical
 ("kin2" ?󿬕)	; kin, diagonal exclamation radical
 ("kipisi" ?󱥻)	; kipisi
 ("kokosila" ?󱦄)	; kokosila, default
 ("kokosila1" ?󿪭)	; kokosila, toki with stroke
 ("kokosila2" ?󿪮)	; kokosila, star
 ("ku" ?󱦈)	; ku, default
 ("ku1" ?󱦈)	; ku, dot
 ("ku2" ?󿵶)	; ku, dot with emitters
 ("ku3" ?󿵷)	; ku, toki
 ("ku4" ?󿵸)	; ku, toki pona
 ("ku5" ?󿵹)	; ku, ijo pona
 ("ku6" ?󿵺)	; ku, fermata
 ("ku7" ?󿵻)	; ku, ijo
 ("lanpan" ?󱦅)	; lanpan, default
 ("lanpan1" ?󿪯)	; lanpan, with head
 ("lanpan2" ?󿪰)	; lanpan, with hook
 ("lanpan3" ?󿪱)	; lanpan, turned pana
 ("leko" ?󱥼)	; leko
 ("meso" ?󱦂)	; meso, default
 ("meso1" ?󿪩)	; meso, vertical lines with dot
 ("meso2" ?󿪪)	; meso, ante with dot
 ("misikeke" ?󱦇)	; misikeke, default
 ("misikeke1" ?󱦇)	; misikeke, pill
 ("misikeke2" ?󿵪)	; misikeke, mortar and pestle
 ("monsuta" ?󱥽)	; monsuta
 ("n" ?󱦆)	; n, default
 ("n1" ?󿬖)	; n, straight exclamation radical
 ("n2" ?󿬚)	; n, diagonal exclamation radical
 ("namako" ?󱥸)	; namako, default
 ("namako1" ?󿪧)	; namako, four rays
 ("namako2" ?󿪨)	; namako, pepper with emitters
 ("oko" ?󱥺)	; oko
 ("soko" ?󱦁)	; soko, default
 ("soko1" ?󿵥)	; soko, thick stem
 ("soko2" ?󿵦)	; soko, thin stem
 ("soko3" ?󿵧)	; soko, thin stem with annulus
 ("tonsi" ?󱥾)	; tonsi, default
 ("tonsi1" ?󱥾)	; tonsi, circle with three spokes
 ("tonsi2" ?󿴈)	; tonsi, male and female sign
 ("tonsi3" ?󿴚)	; tonsi, circle with letter T
 ("tonsi4" ?󿴛)	; tonsi, antimony symbol

                                        ; single words - nimi ku lili
 ("apeja" ?󱦡)	; apeja
 ("isipin" ?󿫀)	; isipin
 ("kapesi" ?󿫁)	; kapesi, default
 ("kapesi1" ?󿫁)	; kapesi, triangle with ma above
 ("kapesi2" ?󿫂)	; kapesi, triangle with horizontal and vertical
 ("kiki" ?󿫃)	; kiki, default
 ("kiki1" ?󿫃)	; kiki, kiki-bouba experiment
 ("kiki2" ?󿵭)	; kiki, hyperbolic squarrel
 ("kiki3" ?󿵮)	; kiki, deltoid
 ("kiki4" ?󿵯)	; kiki, hazard sign
 ("linluwi" ?󿫄)	; linluwi, default
 ("linluwi1" ?󿫄)	; linluwi, synonym of linuwi, sitelen-len-linja
 ("linluwi2" ?󿮥)	; linluwi, synonym of linuwi, len-linja-en with emitters
 ("linluwi3" ?󿵫)	; linluwi, synonym of linuwi, len-linja with emitters
 ("linluwi4" ?󿵬)	; linluwi, synonym of linuwi, connected kulupu
 ("linuwi" ?󿫄)	; linuwi, synonym of linluwi, default
 ("linuwi1" ?󿫄)	; linuwi, synonym of linluwi, sitelen-len-linja
 ("linuwi2" ?󿮥)	; linuwi, synonym of linluwi, len-linja-en with emitters
 ("linuwi3" ?󿵫)	; linuwi, synonym of linluwi, len-linja with emitters
 ("linuwi4" ?󿵬)	; linuwi, synonym of linluwi, connected kulupu
 ("majuna" ?󱦢)	; majuna, default
 ("majuna1" ?󿪲)	; majuna, three rays
 ("majuna2" ?󿪳)	; majuna, five rays
 ("mulapisu" ?󿫈)	; mulapisu
 ("pake" ?󱦠)	; pake
 ("powe" ?󱦣)	; powe
 ("samu" ?󿫉)	; samu
 ("unu" ?󿫊)	; unu
 ("wa" ?󿫋)	; wa, default
 ("wa1" ?󿬞)	; wa, straight exclamation radical
 ("wa2" ?󿬟)	; wa, diagonal exclamation radical
 ("ete" ?󿫌)	; ete, default
 ("ete1" ?󿫌)	; ete, rectangle with dot above
 ("ete2" ?󿫍)	; ete, sewi with arrow to dot above
 ("kan" ?󿫏)	; kan
 ("kuntu" ?󿫐)	; kuntu
 ("loka" ?󿫑)	; loka, synonym of jalan
 ("misa" ?󿫒)	; misa, default
 ("misa1" ?󿫒)	; misa, no foot and no ear
 ("misa2" ?󿫓)	; misa, no foot and short ear
 ("misa3" ?󿫔)	; misa, no foot and long ear
 ("misa4" ?󿫕)	; misa, foot and no ear
 ("misa5" ?󿫖)	; misa, foot and short ear
 ("misa6" ?󿫗)	; misa, foot and long ear
 ("waleja" ?󿫘)	; waleja
 ("ewe" ?󿫙)	; ewe
 ("kamalawala" ?󿫚)	; kamalawala
 ("ke" ?󿫛)	; ke, default
 ("ke1" ?󿬠)	; ke, straight exclamation radical
 ("ke2" ?󿬤)	; ke, diagonal exclamation radical
 ("kese" ?󿫟)	; kese
 ("kulijo" ?󿫡)	; kulijo, default
 ("kulijo1" ?󿫡)	; kulijo, lete with emitters
 ("kulijo2" ?󿶿)	; kulijo, thumbs up
 ("likujo" ?󿫢)	; likujo
 ("neja" ?󿫣)	; neja
 ("oke" ?󿫤)	; oke
 ("pata" ?󿫥)	; pata
 ("peto" ?󿫦)	; peto
 ("po" ?󿫧)	; po
 ("polinpin" ?󿫨)	; polinpin
 ("pomotolo" ?󿫩)	; pomotolo
 ("san" ?󿫫)	; san
 ("soto" ?󿫬)	; soto
 ("taki" ?󿫭)	; taki, default
 ("taki1" ?󿫭)	; taki, magnet
 ("taki2" ?󿫮)	; taki, yinyang
 ("te" ?󿫰)	; te
 ("teje" ?󿫯)	; teje
 ("tuli" ?󿫫)	; tuli
 ("to" ?󿫱)	; to, default
 ("to1" ?󿫱)	; to, right corner bracket
 ("umesu" ?󿫲)	; umesu, default
 ("umesu1" ?󿫲)	; umesu, podium
 ("umesu2" ?󿶸)	; umesu, trophy (Here, The Cheat, have a trophy!)
 ("usawi" ?󿫶)	; usawi
 ("wasoweli" ?󿫷)	; wasoweli
 ("sutopatikuna" ?󿫻)	; sutopatikuna
 ("yupekosi" ?󿫼)	; yupekosi
 ("Pingo" ?󿫽)	; Pingo
 ("kalamARR" ?󿫾)	; kalamARR

                                        ; single words - nimi ku awen
 ("ju" ?󿬬)	; ju
 ("lu" ?󿬭)	; lu, default
 ("lu1" ?󿬭)	; lu, reserved word
 ("lu2" ?󿭺)	; lu, synonym of lo
 ("nu" ?󿬮)	; nu, default
 ("nu1" ?󿬮)	; nu, reserved word
 ("nu2" ?󿭾)	; nu, synonym of sin
 ("su" ?󿬯)	; su, default
 ("su1" ?󿬯)	; su, reserved word
 ("su2" ?󿬽)	; su, question marker
 ("u" ?󿬰)	; u

                                        ; single words - nimi ale pona, main
 ("jami" ?󿬱)	; jami
 ("melome" ?󿬲)	; melome
 ("mijomi" ?󿬶)	; mijomi
 ("natu" ?󿬺)	; natu, synonym of aka and eki
 ("aka" ?󿬺)	; aka, synonym of natu and eki
 ("eki" ?󿬺)	; eki, synonym of natu and aka
 ("omekapo" ?󿬻)	; omekapo
 ("puwa" ?󿬼)	; puwa
 ("wekama" ?󿬾)	; wekama

                                        ; single words - nimi ale pona, namako
 ("alu" ?󿭀)	; alu
 ("awase" ?󿭁)	; awase
 ("enko" ?󿭃)	; enko, default
 ("enko1" ?󿭃)	; enko, space alien looking thing
 ("enko2" ?󿭄)	; enko, arrows
 ("enko3" ?󿭅)	; enko, grid
 ("i" ?󿭆)	; i
 ("iki" ?󿭇)	; iki, default
 ("iki1" ?󿬊)	; iki, straight
 ("iki2" ?󿬋)	; iki, curved
 ("ipi" ?󿭈)	; ipi, default
 ("ipi1" ?󿬌)	; ipi, straight
 ("ipi2" ?󿬍)	; ipi, curved
 ("itomi" ?󿭉)	; itomi
 ("jaku" ?󿭍)	; jaku
 ("jalan" ?󿫑)	; jalan, synonym of loka
 ("je" ?󿭎)	; je, default
 ("je1" ?󿬨)	; je, straight exclamation radical
 ("je2" ?󿬩)	; je, diagonal exclamation radical
 ("jonke" ?󿭏)	; jonke
 ("kapa" ?󿭑)	; kapa
 ("ki" ?󿭕)	; ki
 ("kisa" ?󿭗)	; kisa
 ("konwe" ?󿭘)	; konwe
 ("kosan" ?󿭙)	; kosan
 ("kulu" ?󿭝)	; kulu
 ("lokon" ?󿭞)	; lokon
 ("molusa" ?󿭟)	; molusa
 ("nja" ?󿭠)	; nja
 ("okepuma" ?󿭡)	; okepuma
 ("omen" ?󿭢)	; omen
 ("oni" ?󿭣)	; oni, default
 ("oni1" ?󿭣)	; oni, closed eyelid
 ("oni2" ?󿭤)	; oni, mun with emitters
 ("owe" ?󿭥)	; owe
 ("pa" ?󿭦)	; pa
 ("pasila" ?󿭧)	; pasila
 ("peta" ?󿭩)	; peta
 ("pika" ?󿭪)	; pika, default
 ("pika1" ?󿭪)	; pika, lightning bolt
 ("pika2" ?󿶝)	; pika, electric plug
 ("pipo" ?󿭫)	; pipo
 ("sikomo" ?󿭬)	; sikomo
 ("ten" ?󱥫)	; ten, default
 ("ten1" ?󱥫)	; ten, synonym of tenpo
 ("ten2" ?󿮭)	; ten, the number
 ("tokana" ?󿭰)	; tokana, default
 ("tokana1" ?󿭰)	; tokana, magnifying glass
 ("tokana2" ?󿶩)	; tokana, rotated ante with dot
 ("tokana3" ?󿶪)	; tokana, four rays with dot
 ("wawajete" ?󿭱)	; wawajete
 ("we1" ?󿭲)	; we, particle
 ("we2" ?󿶷)	; we, content word
 ("we" ?󿶷)	; we, content word
 ("yutu" ?󿮌)	; yutu

                                        ; single words - nimi Linku
 ("ako" ?󿭳)	; ako, default
 ("ako1" ?󿬪)	; ako, straight exclamation radical
 ("ako2" ?󿬫)	; ako, diagonal exclamation radical
 ("jume" ?󿭴)	; jume
 ("konsi" ?󿭵)	; konsi
 ("kutopoma" ?󿭷)	; kutopoma
 ("lijokuku" ?󿭸)	; lijokuku, default
 ("lijokuku1" ?󿭸)	; lijokuku, Hangul
 ("lijokuku2" ?󿭹)	; lijokuku, pilin sama with musi
 ("lo" ?󿭺)	; lo, synonym of lu
 ("me" ?󿭼)	; me
 ("nele" ?󿭽)	; nele
 ("nuwa" ?󿭿)	; nuwa
 ("poni" ?󿷂)	; poni, default
 ("poni1" ?󿮀)	; poni, profile
 ("poni2" ?󿶅)	; poni, horseshoe
 ("poni3" ?󿷂)	; poni, purple smart
 ("poni4" ?󿷃)	; poni, blue fast
 ("poni5" ?󿷄)	; poni, pink happy
 ("poni6" ?󿷅)	; poni, white pretty
 ("poni7" ?󿷆)	; poni, yellow quiet (best pony)
 ("poni8" ?󿷇)	; poni, orange strong
 ("sipi" ?󿮁)	; sipi
 ("wi" ?󿮂)	; wi, default
 ("wi1" ?󿬎)	; wi, straight
 ("wi2" ?󿬏)	; wi, curved
 ("slape" ?󿮍)	; slape
 ("jans" ?󿮎)	; jans

                                        ; single words - nimi Linku 2022
 ("alente" ?󿶀)	; alente
 ("jule" ?󿶁)	; jule
 ("nalanja1" ?󿶂)	; nalanja, orange slice
 ("nalanja2" ?󿶶)	; nalanja, kili
 ("nalanja" ?󿶶)	; nalanja, default
 ("ojuta" ?󿶃)	; ojuta
 ("omekalike" ?󿶄)	; omekalike
 ("wowujiti" ?󿶆)	; wowujiti/wuwojiti
 ("wuwojiti" ?󿶆)	; wuwojiti/wowujiti

                                        ; single words - linja sike
 ("oki" ?󿮄)	; oki
 ("sowoli" ?󿮆)	; sowoli
 ("kulepiku" ?󿮊)	; kulepiku
 ("epikule" ?󿮋)	; epikule
 ("jew" ?󿮏)	; jew

                                        ; single words - linja suwi
 ("kalijopilale" ?󿮠)	; kalijopilale
 ("kijosin" ?󿮡)	; kijosin
 ("mamasi" ?󿮩)	; mamasi, synonym of mamasina
 ("mamasina" ?󿮩)	; mamasina, synonym of mamasi
 ("waken" ?󿮪)	; waken

                                        ; single words - other sources
 ("lansan" ?󿮫)	; lansan
 ("wiki" ?󿮬)	; wiki
 ("tona" ?󿮮)	; tona
 ("aku" ?󿶇)	; aku
 ("ani" ?󿶈)	; ani
 ("anta" ?󿶉)	; anta
 ("apelo" ?󿶊)	; apelo
 ("elen" ?󿶋)	; elen
 ("iseki" ?󿶌)	; iseki
 ("kalapisituwi" ?󿶍)	; kalapisituwi
 ("kana" ?󿶎)	; kana
 ("kikolo" ?󿶏)	; kikolo
 ("kikulo" ?󿶐)	; kikulo
 ("kokoliko" ?󿶑)	; kokoliko
 ("koni" ?󿶒)	; koni
 ("kosikosa" ?󿶓)	; kosikosa
 ("masalo" ?󿶔)	; masalo
 ("matula" ?󿶕)	; matula
 ("nimisin" ?󿶖)	; nimisin
 ("nowi" ?󿶗)	; nowi
 ("olala" ?󿶘)	; olala
 ("opasan" ?󿶙)	; opasan
 ("pakola" ?󿶚)	; pakola, default
 ("pakola1" ?󿶚)	; pakola, pakala-like with emitters
 ("pakola2" ?󿶛)	; pakola, H
 ("panke" ?󿶜)	; panke
 ("pipolo" ?󿶞)	; pipolo
 ("sapelipope" ?󿶟)	; sapelipope
 ("sikako" ?󿶠)	; sikako
 ("silapa" ?󿶡)	; silapa
 ("sipije" ?󿶢)	; sipije
 ("sisi" ?󿶣)	; sisi
 ("siwala" ?󿶤)	; siwala
 ("snoweli" ?󿶥)	; snoweli
 ("soni" ?󿶦)	; soni
 ("ta" ?󿶧)	; ta (particle)
 ("ta1" ?󿶧)	; ta (particle)
 ("tasun" ?󿶨)	; tasun
 ("wiwi" ?󿶫)	; wiwi

                                        ; single words - 2023
 ("eliki" ?󿶬)	; eliki
 ("enepi" ?󿶭)	; enepi
 ("nasin+mani" ?󿶮)	; nasin mani (capitalism)
 ("wiju" ?󿶯)	; wiju
 ("saja" ?󿶰)	; saja
 ("ana" ?󿶱)	; ana
 ("eni" ?󿶲)	; eni, synonym of ene
 ("ene" ?󿶲)	; ene, synonym of eni
 ("masu" ?󿶳)	; masu
 ("lato" ?󿶴)	; lato
 ("topo" ?󿶵)	; topo

                                        ; single words - 2024
 ("teken" ?󿶹)	; teken (same as sitelen; full writeup coming soon)
 ("api" ?󿶻)	; api, default
 ("api1" ?󿶻)	; api, pi noka ala, read as wings
 ("api2" ?󿶼)	; api, pi noka ala, read as antennae
 ("api3" ?󿶽)	; api, Menasewian
 ("api4" ?󿶺)	; api, tawa sinpin
 ("kolo" ?󿶾)	; kolo
 ("lisana" ?󿷀)	; lisana, default
 ("lisana1" ?󿷀)	; lisana, tongue
 ("lisana2" ?󿷁)	; lisana, uvula
 ("penpo" ?󿷉)	; penpo
 ("kulaso" ?󿷊)	; kulaso (green laso, glaso)
 ("sulaso" ?󿷋)	; sulaso (cyan laso, slaso)
 ("pulaso" ?󿷌)	; pulaso (blue laso, blaso)
 ("masenta" ?󿷍)	; masenta (magenta)
 ("antikontitutonelema" ?󿷎)	; antikontitutonelema, default
 ("antikontitutonelema2" ?󿷎)	; antikontitutonelema, classical building
 ("antikontitutonelema1" ?󿷏)	; antikontitutonelema, extra-wide jaki
 ("kankuli" ?󿷡)	; kankuli (scrunkly)
 ("ja" ?󿴯)	; ja
 ("kepa" ?󿹐)	; kepa
 ("miko" ?󿹑)	; miko, default
 ("miko1" ?󿹑)	; miko, egg
 ("miko2" ?󿹒)	; miko, tardigrade
 ("ta2" ?󿹓)	; ta (content word)
 ("tuwa" ?󿹔)	; tuwa

                                        ; long silapa and tasun
 ("silapa1" ?󿷰)	; silapa, top part
 ("silapa2" ?󿷱)	; silapa, middle part
 ("silapa3" ?󿷲)	; silapa, bottom part
 ("silapa4" ?󿷳)	; silapa, two lines tall
 ("silapa5" ?󿷴)	; silapa, three lines tall
 ("si\\" ?󿷰)	; silapa, top part
 ("i\\" ?󿷱)	; silapa, middle part
 ("ilapa" ?󿷲)	; silapa, bottom part
 ("siilapa" ?󿷳)	; silapa, two lines tall
 ("siiilapa" ?󿷴)	; silapa, three lines tall
 ("tasun1" ?󿷵)	; tasun, left part
 ("tasun2" ?󿷶)	; tasun, center part
 ("tasun3" ?󿷷)	; tasun, right part
 ("tasun4" ?󿷸)	; tasun, two ideographs wide
 ("tasun5" ?󿷹)	; tasun, three ideographs wide
 ("tasun6" ?󿷺)	; tasun, left part, two ideographs wide
 ("tasun7" ?󿷻)	; tasun, right part, two ideographs wide
 ("taasun" ?󿷸)	; tasun, two ideographs wide
 ("taaasun" ?󿷹)	; tasun, three ideographs wide
 ("taa" ?󿷺)	; tasun, left part, two ideographs wide
 ("aasun" ?󿷻)	; tasun, right part, two ideographs wide

                                        ; names of people
 ("a+suli" ?󿮐)	; jan Asuli
 ("Asuto" ?󿮑)	; jan waso Asuto
 ("Eko" ?󿮒)	; ilo Eko
 ("ijo+tan+anpa+nanpa" ?󿷠)	; jan Itan
 ("Jan" ?󿮓)	; jan Jan
 ("Kapilu" ?󿮔)	; jan Kapilu
 ("Keli" ?󿷢)	; waso Keli
 ("KeTami" ?󿷣)	; jan Ke Tami
 ("kili+ma" ?󿮕)	; kulupu Kilima
 ("Kita" ?󿷤)	; jan Kita
 ("kulupu+en" ?󿮖)	; The & System
 ("lipamanka" ?󿪾)	; lipamanka
 ("Lipamanka" ?󿪾)	; lipamanka
 ("Lepeka" ?󿪿)	; jan Lepeka
 ("melinjakulekule" ?󿪿)	; jan Lepeka
 ("nata" ?󿪽)	; soweli nata
 ("Nili" ?󿮘)	; jan Nili Koloto
 ("To" ?󿮅)	; mute To
 ("to2" ?󿮅)	; mute To
 ("unikijetesantakalu" ?󿮙)	; jan Wija / Wyub
 ("waso+pimeja" ?󿮚)	; waso Atemi / waso pimeja
 ("Weko" ?󿮛)	; jan Kita / jan Weko
 ("Aja" ?󿴰)	; jan Aja
 ("AkesiKon" ?󿴱)	; akesi kon Nalasuni
 ("Amelin" ?󿴲)	; jan Amelin
 ("Ansu" ?󿴳)	; jan Ansu
 ("Antepan" ?󿴴)	; jan Antepan
 ("Asiku" ?󿴵)	; jan Asiku
 ("Atu" ?󿴶)	; waso Atu
 ("Esile" ?󿴷)	; jan Esile
 ("Eweke" ?󿴸)	; soweli Eweke
 ("Eweke1" ?󿴸)	; soweli Eweke
 ("Eweke2" ?󿷚)	; soweli Eweke
 ("Ipawi" ?󿴹)	; jan Ipawi
 ("Iseja" ?󿴺)	; jan Iseja
 ("Jalepu" ?󿴻)	; jan Alepu
 ("Jasun" ?󿴼)	; jan Jasun
 ("Jonatan" ?󿴽)	; jan Jonatan
 ("Jules" ?󿴾)	; Jules
 ("Kemu" ?󿴿)	; jan Kemu
 ("Kepi" ?󿵀)	; jan Kepi (Kirby)
 ("Kijan" ?󿵁)	; Kijan
 ("Koko" ?󿵂)	; jan Koko
 ("Luke" ?󿵄)	; jan Luke
 ("Luna" ?󿵅)	; jan Luna
 ("Maki" ?󿵆)	; jan Maki
 ("Mako" ?󿵇)	; jan Mako
 ("Mekuwi" ?󿵈)	; jan Mekuwi
 ("Mila" ?󿵉)	; jan Mila
 ("Mimuki" ?󿵊)	; ilo Mimuki
 ("motan" ?󿵋)	; motan
 ("Nalasuni" ?󿵌)	; akesi kon Nalasuni
 ("nano" ?󿵍)	; nano
 ("Niko" ?󿵎)	; jan Niko
 ("Nlsn" ?󿵏)	; akesi kon Nalasuni
 ("Opa" ?󿵐)	; jan Opa
 ("Palensi" ?󿵑)	; jan Palensi
 ("Pami" ?󿵒)	; jan Pami
 ("Poman" ?󿵓)	; jan Poman
 ("Sijala" ?󿵔)	; jan Sijala
 ("Silani" ?󿵕)	; jan Silani
 ("Siwan" ?󿵖)	; jan Siwan
 ("Temi" ?󿵗)	; jan Temi
 ("Tensi" ?󿵘)	; jan Tensi
 ("Tonyu" ?󿵙)	; kala pona Tonyu
 ("Usawi" ?󿵚)	; jan Usawi
 ("Vriska" ?󿵛)	; Vriska
 ("Waje" ?󿵜)	; jan Waje
 ("Wen" ?󿵝)	; waso Wen
 ("tenpi" ?󿵞)	; tonsi tenpi
 ("kekantesantakalu" ?󿵟)	; jan Kekan San
 ("Jesi" ?󿷐)	; akesi Jesi
 ("lokoso" ?󿷑)	; leko lokoso
 ("Nito" ?󿷒)	; ijo Nito, default
 ("Nito1" ?󿷒)	; ijo Nito, ko with tail
 ("Nito2" ?󿷓)	; ijo Nito, ko-headed jan
 ("Samin" ?󿷔)	; kala Samin
 ("Satun" ?󿷕)	; mun Satun
 ("Kalu" ?󿷖)	; jan Kalu
 ("lenlen" ?󿷗)	; len len
 ("Pensa" ?󿷘)	; jan Pensa
 ("Tonpite" ?󿷙)	; nanpa Tonpite
 ("Enki" ?󿷮)	; kije Enki
 ("KekanSan" ?󿷯)	; jan Kekan San
 ("Ilaje" ?󿺠)	; soweli kijetesantakalu Ilaje
 ("Kolisin" ?󿺡)	; namako Kolisin

                                        ; names of communities
 ("kama+sona" ?󿷭)	; kama sona
 ("Linku" ?󿯲)	; kulupu Linku
 ("lipu+Wesi+pi+toki+pona" ?󿯳)	; lipu Wesi pi toki pona
 ("ma+pi+nasin+sitelen" ?󿯱)	; ma pi nasin sitelen
 ("ma+pona+pi+toki+pona" ?󿯰)	; ma pona pi toki pona
 ("ma+toki+pona+wile+jan" ?󿷥)	; Ma Toki Pona VR
 ("ma+toki+pona+VR" ?󿷥)	; Ma Toki Pona VR
 ("pali+pali+ale+pona+epiku" ?󿷦)	; pali Pape (Project Babel)
 ("pali+Pape" ?󿷦)	; pali Pape (Project Babel)
 ("Seka" ?󿷧)	; ma Seka
 ("Seki" ?󿷟)	; toki pona chess community

                                        ; names of other things
 ("Losupan" ?󿷨)	; Losupan (Lojban)
 ("Towan" ?󿷩)	; Towan (Toaq)
 ("Votgil" ?󿇠)	; Votgil (I'm a bit excited)
 ("mun+pi+ante+toki" ?󿷞)	; mun pi ante toki
 ("suno+pi+toki+pona" ?󿷪)	; suno pi toki pona
 ("Token" ?󿷝)	; Token
 ("Wakalito" ?󿷫)	; Wakalito
 ("asuki" ?󿷬)	; asuki (ASCII) (simplified form of ASCII chart from MIL-STD-188-100)
 ("Asuki" ?󿷬)	; Asuki (ASCII) (simplified form of ASCII chart from MIL-STD-188-100)
 ("mono" ?󿮗)	; mono
 ("juniko" ?󿮝)	; juniko (Unicode)
 ("Juniko" ?󿮝)	; Juniko (Unicode)
 ("jusijesuwa" ?󿮟)	; jusijesuwa (UCSUR)
 ("Jusijesuwa" ?󿮟)	; Jusijesuwa (UCSUR)
 ("jusisa" ?󿮟)	; jusisa (UCSUR)
 ("Jusisa" ?󿮟)	; Jusisa (UCSUR)
 ("sijesuwa" ?󿮞)	; sijesuwa (CSUR)
 ("Sijesuwa" ?󿮞)	; Sijesuwa (CSUR)
 ("sisa" ?󿮞)	; sisa (CSUR)
 ("Sisa" ?󿮞)	; Sisa (CSUR)
 ("nasulin" ?󿮜)	; nasulin (Touhou hijack)
 ("Nasulin" ?󿮜)	; Nasulin (Touhou hijack)
 ("Amanka" ?󿯼)	; Amanka (Among Us)
 ("Amonka" ?󿯼)	; Amonka (Among Us)
 ("Manka" ?󿯽)	; Manka (Minecraft)
 ("Nutan" ?󿯾)	; Nutan (Newton)
 ("Fairfax" ?󿷛)	; Fairfax
 ("Pona" ?󿨙)	; Pona
 ("Pula" ?󱱱)	; Pula
 ("HD" ?󿷜)	; HD
 ("Medium" ?󱦂)	; Medium
 ("sitelen+seli+kiwen" ?󿯹)	; sitelen seli kiwen
 ("aAANUSEMEmailMahjong" ?󿷿)	; aAANUSEMEmailMahjong

                                        ; punctuation and format controls
 ("[" ?󱦐)	; start of cartouche
  ("]" ?󱦑)	; end of cartouche
 ("(" ?󱦗)	; start of extended glyph
 (")" ?󱦘)	; end of extended glyph
 ("{" ?󱦚)	; start of reverse extended glyph
 ("}" ?󱦛)	; end of reverse extended glyph
 (".." ?󱦜)	; interpunct
 ("::" ?󱦝)	; colon

                                        ; compounds of two words
                                        ; stacking and scaling joiners should be included
                                        ; unless the only orientation is horizontal
 ("anpa-lawa" ?󿤀)	; anpa lawa, stacked
 ("anpa+lawa" ?󿤀)	; anpa lawa, stacked
 ("anpa^lawa" ?󿤀)	; anpa lawa, stacked
 ("ijo-akesi" ?󿤁)	; ijo akesi, scaled
 ("ijo+akesi" ?󿤁)	; ijo akesi, scaled
 ("ijo*akesi" ?󿤁)	; ijo akesi, scaled
 ("ijo-akesi1" ?󿤁)	; ijo akesi, scaled
 ("ijo+akesi1" ?󿤁)	; ijo akesi, scaled
 ("ijo*akesi1" ?󿤁)	; ijo akesi, scaled
 ("ijo-akesi2" ?󿤁)	; ijo akesi, scaled
 ("ijo+akesi2" ?󿤁)	; ijo akesi, scaled
 ("ijo*akesi2" ?󿤁)	; ijo akesi, scaled
 ("ijo-ala" ?󿤂)	; ijo ala, scaled
 ("ijo+ala" ?󿤂)	; ijo ala, scaled
 ("ijo*ala" ?󿤂)	; ijo ala, scaled
 ("ijo-alasa" ?󿤃)	; ijo alasa, scaled
 ("ijo+alasa" ?󿤃)	; ijo alasa, scaled
 ("ijo*alasa" ?󿤃)	; ijo alasa, scaled
 ("ijo-ale" ?󿤄)	; ijo ale, synonym of ijo ali, scaled
 ("ijo+ale" ?󿤄)	; ijo ale, synonym of ijo ali, scaled
 ("ijo*ale" ?󿤄)	; ijo ale, synonym of ijo ali, scaled
 ("ijo-ali" ?󿤄)	; ijo ali, synonym of ijo ale, scaled
 ("ijo+ali" ?󿤄)	; ijo ali, synonym of ijo ale, scaled
 ("ijo*ali" ?󿤄)	; ijo ali, synonym of ijo ale, scaled
 ("ijo-anpa" ?󿤅)	; ijo anpa, scaled
 ("ijo+anpa" ?󿤅)	; ijo anpa, scaled
 ("ijo*anpa" ?󿤅)	; ijo anpa, scaled
 ("ijo-ante" ?󿤆)	; ijo ante, scaled
 ("ijo+ante" ?󿤆)	; ijo ante, scaled
 ("ijo*ante" ?󿤆)	; ijo ante, scaled
 ("ijo-anu" ?󿤇)	; ijo anu, scaled
 ("ijo+anu" ?󿤇)	; ijo anu, scaled
 ("ijo*anu" ?󿤇)	; ijo anu, scaled
 ("ijo-apeja" ?󿤈)	; ijo apeja, scaled
 ("ijo+apeja" ?󿤈)	; ijo apeja, scaled
 ("ijo*apeja" ?󿤈)	; ijo apeja, scaled
 ("ijo-awen" ?󿤉)	; ijo awen, scaled
 ("ijo+awen" ?󿤉)	; ijo awen, scaled
 ("ijo*awen" ?󿤉)	; ijo awen, scaled
 ("ijo-en" ?󿤊)	; ijo en, scaled
 ("ijo+en" ?󿤊)	; ijo en, scaled
 ("ijo*en" ?󿤊)	; ijo en, scaled
 ("ijo-esun" ?󿤋)	; ijo esun, scaled
 ("ijo+esun" ?󿤋)	; ijo esun, scaled
 ("ijo*esun" ?󿤋)	; ijo esun, scaled
 ("ijo-ike" ?󿤌)	; ijo ike, scaled
 ("ijo+ike" ?󿤌)	; ijo ike, scaled
 ("ijo*ike" ?󿤌)	; ijo ike, scaled
 ("ijo-ilo" ?󿤍)	; ijo ilo, scaled
 ("ijo+ilo" ?󿤍)	; ijo ilo, scaled
 ("ijo*ilo" ?󿤍)	; ijo ilo, scaled
 ("ijo-insa" ?󿤎)	; ijo insa, scaled
 ("ijo+insa" ?󿤎)	; ijo insa, scaled
 ("ijo*insa" ?󿤎)	; ijo insa, scaled
 ("ijo-jaki" ?󿤏)	; ijo jaki, scaled
 ("ijo+jaki" ?󿤏)	; ijo jaki, scaled
 ("ijo*jaki" ?󿤏)	; ijo jaki, scaled
 ("ijo-jan" ?󿤐)	; ijo jan, scaled
 ("ijo+jan" ?󿤐)	; ijo jan, scaled
 ("ijo*jan" ?󿤐)	; ijo jan, scaled
 ("ijo-jelo" ?󿤑)	; ijo jelo, scaled
 ("ijo+jelo" ?󿤑)	; ijo jelo, scaled
 ("ijo*jelo" ?󿤑)	; ijo jelo, scaled
 ("ijo-jo" ?󿤒)	; ijo jo, scaled
 ("ijo+jo" ?󿤒)	; ijo jo, scaled
 ("ijo*jo" ?󿤒)	; ijo jo, scaled
 ("ijo-kala" ?󿤓)	; ijo kala, default, scaled
 ("ijo+kala" ?󿤓)	; ijo kala, default, scaled
 ("ijo*kala" ?󿤓)	; ijo kala, default, scaled
 ("ijo-kala1" ?󿤓)	; ijo kala, without eyes, scaled
 ("ijo+kala1" ?󿤓)	; ijo kala, without eyes, scaled
 ("ijo*kala1" ?󿤓)	; ijo kala, without eyes, scaled
 ("ijo-kala2" ?󿤓)	; ijo kala, with eyes, scaled
 ("ijo+kala2" ?󿤓)	; ijo kala, with eyes, scaled
 ("ijo*kala2" ?󿤓)	; ijo kala, with eyes, scaled
 ("ijo-kalama" ?󿤔)	; ijo kalama, scaled
 ("ijo+kalama" ?󿤔)	; ijo kalama, scaled
 ("ijo*kalama" ?󿤔)	; ijo kalama, scaled
 ("ijo-kama" ?󿤕)	; ijo kama, scaled
 ("ijo+kama" ?󿤕)	; ijo kama, scaled
 ("ijo*kama" ?󿤕)	; ijo kama, scaled
 ("ijo-kasi" ?󿤖)	; ijo kasi, scaled
 ("ijo+kasi" ?󿤖)	; ijo kasi, scaled
 ("ijo*kasi" ?󿤖)	; ijo kasi, scaled
 ("ijo-ken" ?󿤗)	; ijo ken, scaled
 ("ijo+ken" ?󿤗)	; ijo ken, scaled
 ("ijo*ken" ?󿤗)	; ijo ken, scaled
 ("ijo-kepeken" ?󿤘)	; ijo kepeken, synonym of ijo kepen, scaled
 ("ijo+kepeken" ?󿤘)	; ijo kepeken, synonym of ijo kepen, scaled
 ("ijo*kepeken" ?󿤘)	; ijo kepeken, synonym of ijo kepen, scaled
 ("ijo-kepen" ?󿤘)	; ijo kepen, synonym of ijo kepeken, scaled
 ("ijo+kepen" ?󿤘)	; ijo kepen, synonym of ijo kepeken, scaled
 ("ijo*kepen" ?󿤘)	; ijo kepen, synonym of ijo kepeken, scaled
 ("ijo-kijetesantakalu" ?󿤙)	; ijo kijetesantakalu, scaled
 ("ijo+kijetesantakalu" ?󿤙)	; ijo kijetesantakalu, scaled
 ("ijo*kijetesantakalu" ?󿤙)	; ijo kijetesantakalu, scaled
 ("ijo-kili" ?󿤚)	; ijo kili, scaled
 ("ijo+kili" ?󿤚)	; ijo kili, scaled
 ("ijo*kili" ?󿤚)	; ijo kili, scaled
 ("ijo-kin" ?󿤛)	; ijo kin, scaled
 ("ijo+kin" ?󿤛)	; ijo kin, scaled
 ("ijo*kin" ?󿤛)	; ijo kin, scaled
 ("ijo-kipisi" ?󿤜)	; ijo kipisi, scaled
 ("ijo+kipisi" ?󿤜)	; ijo kipisi, scaled
 ("ijo*kipisi" ?󿤜)	; ijo kipisi, scaled
 ("ijo-kiwen" ?󿤝)	; ijo kiwen, scaled
 ("ijo+kiwen" ?󿤝)	; ijo kiwen, scaled
 ("ijo*kiwen" ?󿤝)	; ijo kiwen, scaled
 ("ijo-ko" ?󿤞)	;ijo ko, scaled
 ("ijo+ko" ?󿤞)	;ijo ko, scaled
 ("ijo*ko" ?󿤞)	;ijo ko, scaled
 ("ijo-kon" ?󿤟)	; ijo kon, scaled
 ("ijo+kon" ?󿤟)	; ijo kon, scaled
 ("ijo*kon" ?󿤟)	; ijo kon, scaled
 ("ijo-kule" ?󿤠)	; ijo kule, scaled
 ("ijo+kule" ?󿤠)	; ijo kule, scaled
 ("ijo*kule" ?󿤠)	; ijo kule, scaled
 ("ijo-kulupu" ?󿤡)	; ijo kulupu, scaled
 ("ijo+kulupu" ?󿤡)	; ijo kulupu, scaled
 ("ijo*kulupu" ?󿤡)	; ijo kulupu, scaled
 ("ijo-kute" ?󿤢)	; ijo kute, scaled
 ("ijo+kute" ?󿤢)	; ijo kute, scaled
 ("ijo*kute" ?󿤢)	; ijo kute, scaled
 ("ijo-lape" ?󿤣)	; ijo lape, scaled
 ("ijo+lape" ?󿤣)	; ijo lape, scaled
 ("ijo*lape" ?󿤣)	; ijo lape, scaled
 ("ijo-laso" ?󿤤)	; ijo laso, scaled
 ("ijo+laso" ?󿤤)	; ijo laso, scaled
 ("ijo*laso" ?󿤤)	; ijo laso, scaled
 ("ijo-lawa" ?󿤥)	; ijo lawa, scaled
 ("ijo+lawa" ?󿤥)	; ijo lawa, scaled
 ("ijo*lawa" ?󿤥)	; ijo lawa, scaled
 ("ijo-leko" ?󿤦)	; ijo leko, scaled
 ("ijo+leko" ?󿤦)	; ijo leko, scaled
 ("ijo*leko" ?󿤦)	; ijo leko, scaled
 ("ijo-len" ?󿤧)	; ijo len, scaled
 ("ijo+len" ?󿤧)	; ijo len, scaled
 ("ijo*len" ?󿤧)	; ijo len, scaled
 ("ijo-lete" ?󿤨)	; ijo lete, scaled
 ("ijo+lete" ?󿤨)	; ijo lete, scaled
 ("ijo*lete" ?󿤨)	; ijo lete, scaled
 ("ijo-lili" ?󿤩)	; ijo lili, scaled
 ("ijo+lili" ?󿤩)	; ijo lili, scaled
 ("ijo*lili" ?󿤩)	; ijo lili, scaled
 ("ijo-linja" ?󿤪)	; ijo linja, scaled
 ("ijo+linja" ?󿤪)	; ijo linja, scaled
 ("ijo*linja" ?󿤪)	; ijo linja, scaled
 ("ijo-lipu" ?󿤫)	; ijo lipu, scaled
 ("ijo+lipu" ?󿤫)	; ijo lipu, scaled
 ("ijo*lipu" ?󿤫)	; ijo lipu, scaled
 ("ijo-loje" ?󿤬)	; ijo loje, scaled
 ("ijo+loje" ?󿤬)	; ijo loje, scaled
 ("ijo*loje" ?󿤬)	; ijo loje, scaled
 ("ijo-lon" ?󿤭)	; ijo lon, scaled
 ("ijo+lon" ?󿤭)	; ijo lon, scaled
 ("ijo*lon" ?󿤭)	; ijo lon, scaled
 ("ijo-luka" ?󿤮)	; ijo luka, scaled
 ("ijo+luka" ?󿤮)	; ijo luka, scaled
 ("ijo*luka" ?󿤮)	; ijo luka, scaled
 ("ijo-lukin" ?󿤯)	; ijo lukin, scaled
 ("ijo+lukin" ?󿤯)	; ijo lukin, scaled
 ("ijo*lukin" ?󿤯)	; ijo lukin, scaled
 ("ijo-lupa" ?󿤰)	; ijo lupa, scaled
 ("ijo+lupa" ?󿤰)	; ijo lupa, scaled
 ("ijo*lupa" ?󿤰)	; ijo lupa, scaled
 ("ijo-ma" ?󿤱)	; ijo ma, scaled
 ("ijo+ma" ?󿤱)	; ijo ma, scaled
 ("ijo*ma" ?󿤱)	; ijo ma, scaled
 ("ijo-mama" ?󿤲)	; ijo mama, scaled
 ("ijo+mama" ?󿤲)	; ijo mama, scaled
 ("ijo*mama" ?󿤲)	; ijo mama, scaled
 ("ijo-mani" ?󿤳)	; ijo mani, scaled
 ("ijo+mani" ?󿤳)	; ijo mani, scaled
 ("ijo*mani" ?󿤳)	; ijo mani, scaled
 ("ijo-meli" ?󿤴)	; ijo meli, default, scaled
 ("ijo+meli" ?󿤴)	; ijo meli, default, scaled
 ("ijo*meli" ?󿤴)	; ijo meli, default, scaled
 ("ijo-meli1" ?󿤴)	; ijo meli, head with hair, scaled
 ("ijo+meli1" ?󿤴)	; ijo meli, head with hair, scaled
 ("ijo*meli1" ?󿤴)	; ijo meli, head with hair, scaled
 ("ijo-meli2" ?󿮰)	; ijo meli, female sign, scaled
 ("ijo+meli2" ?󿮰)	; ijo meli, female sign, scaled
 ("ijo*meli2" ?󿮰)	; ijo meli, female sign, scaled
 ("ijo-mi" ?󿤵)	; ijo mi, default, scaled
 ("ijo+mi" ?󿤵)	; ijo mi, default, scaled
 ("ijo*mi" ?󿤵)	; ijo mi, default, scaled
 ("ijo-mi1" ?󿤵)	; ijo mi, straight, scaled
 ("ijo+mi1" ?󿤵)	; ijo mi, straight, scaled
 ("ijo*mi1" ?󿤵)	; ijo mi, straight, scaled
 ("ijo-mi2" ?󿤵)	; ijo mi, curved, scaled
 ("ijo+mi2" ?󿤵)	; ijo mi, curved, scaled
 ("ijo*mi2" ?󿤵)	; ijo mi, curved, scaled
 ("ijo-mije" ?󿤶)	; ijo mije, default, scaled
 ("ijo+mije" ?󿤶)	; ijo mije, default, scaled
 ("ijo*mije" ?󿤶)	; ijo mije, default, scaled
 ("ijo-mije1" ?󿤶)	; ijo mije, head and shoulders, scaled
 ("ijo+mije1" ?󿤶)	; ijo mije, head and shoulders, scaled
 ("ijo*mije1" ?󿤶)	; ijo mije, head and shoulders, scaled
 ("ijo-mije2" ?󿮱)	; ijo mije, male sign, scaled
 ("ijo+mije2" ?󿮱)	; ijo mije, male sign, scaled
 ("ijo*mije2" ?󿮱)	; ijo mije, male sign, scaled
 ("ijo-moku" ?󿤷)	; ijo moku, scaled
 ("ijo+moku" ?󿤷)	; ijo moku, scaled
 ("ijo*moku" ?󿤷)	; ijo moku, scaled
 ("ijo-moli" ?󿤸)	; ijo moli, scaled
 ("ijo+moli" ?󿤸)	; ijo moli, scaled
 ("ijo*moli" ?󿤸)	; ijo moli, scaled
 ("ijo-moli1" ?󿤸)	; ijo moli, scaled
 ("ijo+moli1" ?󿤸)	; ijo moli, scaled
 ("ijo*moli1" ?󿤸)	; ijo moli, scaled
 ("ijo-moli2" ?󿤸)	; ijo moli, scaled
 ("ijo+moli2" ?󿤸)	; ijo moli, scaled
 ("ijo*moli2" ?󿤸)	; ijo moli, scaled
 ("ijo-monsi" ?󿤹)	; ijo monsi, scaled
 ("ijo+monsi" ?󿤹)	; ijo monsi, scaled
 ("ijo*monsi" ?󿤹)	; ijo monsi, scaled
 ("ijo-monsuta" ?󿤺)	; ijo monsuta, scaled
 ("ijo+monsuta" ?󿤺)	; ijo monsuta, scaled
 ("ijo*monsuta" ?󿤺)	; ijo monsuta, scaled
 ("ijo-mu" ?󿤻)	; ijo mu, scaled
 ("ijo+mu" ?󿤻)	; ijo mu, scaled
 ("ijo*mu" ?󿤻)	; ijo mu, scaled
 ("ijo-mun" ?󿤼)	; ijo mun, scaled
 ("ijo+mun" ?󿤼)	; ijo mun, scaled
 ("ijo*mun" ?󿤼)	; ijo mun, scaled
 ("ijo-musi" ?󿤽)	; ijo musi, scaled
 ("ijo+musi" ?󿤽)	; ijo musi, scaled
 ("ijo*musi" ?󿤽)	; ijo musi, scaled
 ("ijo-mute" ?󿤾)	; ijo mute, scaled
 ("ijo+mute" ?󿤾)	; ijo mute, scaled
 ("ijo*mute" ?󿤾)	; ijo mute, scaled
 ("ijo-namako" ?󿤿)	; ijo namako, default, scaled
 ("ijo+namako" ?󿤿)	; ijo namako, default, scaled
 ("ijo*namako" ?󿤿)	; ijo namako, default, scaled
 ("ijo-namako1" ?󿤿)	; ijo namako, four rays, scaled
 ("ijo+namako1" ?󿤿)	; ijo namako, four rays, scaled
 ("ijo*namako1" ?󿤿)	; ijo namako, four rays, scaled
 ("ijo-namako2" ?󿮲)	; ijo namako, pepper with emitters, scaled
 ("ijo+namako2" ?󿮲)	; ijo namako, pepper with emitters, scaled
 ("ijo*namako2" ?󿮲)	; ijo namako, pepper with emitters, scaled
 ("ijo-nanpa" ?󿥀)	; ijo nanpa, scaled
 ("ijo+nanpa" ?󿥀)	; ijo nanpa, scaled
 ("ijo*nanpa" ?󿥀)	; ijo nanpa, scaled
 ("ijo-nasa" ?󿥁)	; ijo nasa, scaled
 ("ijo+nasa" ?󿥁)	; ijo nasa, scaled
 ("ijo*nasa" ?󿥁)	; ijo nasa, scaled
 ("ijo-nasin" ?󿥂)	; ijo nasin, scaled
 ("ijo+nasin" ?󿥂)	; ijo nasin, scaled
 ("ijo*nasin" ?󿥂)	; ijo nasin, scaled
 ("ijo-nena" ?󿥃)	; ijo nena, scaled
 ("ijo+nena" ?󿥃)	; ijo nena, scaled
 ("ijo*nena" ?󿥃)	; ijo nena, scaled
 ("ijo-ni" ?󿥄)	; ijo ni, scaled
 ("ijo+ni" ?󿥄)	; ijo ni, scaled
 ("ijo*ni" ?󿥄)	; ijo ni, scaled
 ("ijo^ni" ?󿴀)	; ijo ni, stacked
 ("ijo-nimi" ?󿥅)	; ijo nimi, scaled
 ("ijo+nimi" ?󿥅)	; ijo nimi, scaled
 ("ijo*nimi" ?󿥅)	; ijo nimi, scaled
 ("ijo-noka" ?󿥆)	; ijo noka, scaled
 ("ijo+noka" ?󿥆)	; ijo noka, scaled
 ("ijo*noka" ?󿥆)	; ijo noka, scaled
 ("ijo-oko" ?󿥇)	; ijo oko, scaled
 ("ijo+oko" ?󿥇)	; ijo oko, scaled
 ("ijo*oko" ?󿥇)	; ijo oko, scaled
 ("ijo-olin" ?󿥈)	; ijo olin, default, scaled
 ("ijo+olin" ?󿥈)	; ijo olin, default, scaled
 ("ijo*olin" ?󿥈)	; ijo olin, default, scaled
 ("ijo-olin1" ?󿥈)	; ijo olin, doubled pilin, scaled
 ("ijo+olin1" ?󿥈)	; ijo olin, doubled pilin, scaled
 ("ijo*olin1" ?󿥈)	; ijo olin, doubled pilin, scaled
 ("ijo-olin2" ?󿮳)	; ijo olin, pilin with emitters, scaled
 ("ijo+olin2" ?󿮳)	; ijo olin, pilin with emitters, scaled
 ("ijo*olin2" ?󿮳)	; ijo olin, pilin with emitters, scaled
 ("ijo-ona" ?󿥉)	; ijo ona, default, scaled
 ("ijo+ona" ?󿥉)	; ijo ona, default, scaled
 ("ijo*ona" ?󿥉)	; ijo ona, default, scaled
 ("ijo-ona1" ?󿥉)	; ijo ona, straight, scaled
 ("ijo+ona1" ?󿥉)	; ijo ona, straight, scaled
 ("ijo*ona1" ?󿥉)	; ijo ona, straight, scaled
 ("ijo-ona2" ?󿥉)	; ijo ona, curved, scaled
 ("ijo+ona2" ?󿥉)	; ijo ona, curved, scaled
 ("ijo*ona2" ?󿥉)	; ijo ona, curved, scaled
 ("ijo-open" ?󿥊)	; ijo open, scaled
 ("ijo+open" ?󿥊)	; ijo open, scaled
 ("ijo*open" ?󿥊)	; ijo open, scaled
 ("ijo-pakala" ?󿥋)	; ijo pakala, scaled
 ("ijo+pakala" ?󿥋)	; ijo pakala, scaled
 ("ijo*pakala" ?󿥋)	; ijo pakala, scaled
 ("ijo-pake" ?󿥌)	; ijo pake, scaled
 ("ijo+pake" ?󿥌)	; ijo pake, scaled
 ("ijo*pake" ?󿥌)	; ijo pake, scaled
 ("ijo-pali" ?󿥍)	; ijo pali, scaled
 ("ijo+pali" ?󿥍)	; ijo pali, scaled
 ("ijo*pali" ?󿥍)	; ijo pali, scaled
 ("ijo-palisa" ?󿥎)	; ijo palisa, scaled
 ("ijo+palisa" ?󿥎)	; ijo palisa, scaled
 ("ijo*palisa" ?󿥎)	; ijo palisa, scaled
 ("ijo-pan" ?󿥏)	; ijo pan, scaled
 ("ijo+pan" ?󿥏)	; ijo pan, scaled
 ("ijo*pan" ?󿥏)	; ijo pan, scaled
 ("ijo-pana" ?󿥐)	; ijo pana, scaled
 ("ijo+pana" ?󿥐)	; ijo pana, scaled
 ("ijo*pana" ?󿥐)	; ijo pana, scaled
 ("ijo-pilin" ?󿥑)	; ijo pilin, scaled
 ("ijo+pilin" ?󿥑)	; ijo pilin, scaled
 ("ijo*pilin" ?󿥑)	; ijo pilin, scaled
 ("ijo-pimeja" ?󿥒)	; ijo pimeja, scaled
 ("ijo+pimeja" ?󿥒)	; ijo pimeja, scaled
 ("ijo*pimeja" ?󿥒)	; ijo pimeja, scaled
 ("ijo-pini" ?󿥓)	; ijo pini, scaled
 ("ijo+pini" ?󿥓)	; ijo pini, scaled
 ("ijo*pini" ?󿥓)	; ijo pini, scaled
 ("ijo-pipi" ?󿥔)	; ijo pipi, scaled
 ("ijo+pipi" ?󿥔)	; ijo pipi, scaled
 ("ijo*pipi" ?󿥔)	; ijo pipi, scaled
 ("ijo-poka" ?󿥕)	; ijo poka, scaled
 ("ijo+poka" ?󿥕)	; ijo poka, scaled
 ("ijo*poka" ?󿥕)	; ijo poka, scaled
 ("ijo-poki" ?󿥖)	; ijo poki, scaled
 ("ijo+poki" ?󿥖)	; ijo poki, scaled
 ("ijo*poki" ?󿥖)	; ijo poki, scaled
 ("ijo-pona" ?󿥗)	; ijo pona, scaled
 ("ijo+pona" ?󿥗)	; ijo pona, scaled
 ("ijo*pona" ?󿥗)	; ijo pona, scaled
 ("ijo-pu" ?󿥘)	; ijo pu, scaled
 ("ijo+pu" ?󿥘)	; ijo pu, scaled
 ("ijo*pu" ?󿥘)	; ijo pu, scaled
 ("ijo-sama" ?󿥙)	; ijo sama, scaled
 ("ijo+sama" ?󿥙)	; ijo sama, scaled
 ("ijo*sama" ?󿥙)	; ijo sama, scaled
 ("ijo-seli" ?󿥚)	; ijo seli, scaled
 ("ijo+seli" ?󿥚)	; ijo seli, scaled
 ("ijo*seli" ?󿥚)	; ijo seli, scaled
 ("ijo-selo" ?󿥛)	; ijo selo, scaled
 ("ijo+selo" ?󿥛)	; ijo selo, scaled
 ("ijo*selo" ?󿥛)	; ijo selo, scaled
 ("ijo-seme" ?󿥜)	; ijo seme, scaled
 ("ijo+seme" ?󿥜)	; ijo seme, scaled
 ("ijo*seme" ?󿥜)	; ijo seme, scaled
 ("ijo-sewi" ?󿥝)	; ijo sewi, default, scaled
 ("ijo+sewi" ?󿥝)	; ijo sewi, default, scaled
 ("ijo*sewi" ?󿥝)	; ijo sewi, default, scaled
 ("ijo-sewi1" ?󿥝)	; ijo sewi, Arabic, scaled
 ("ijo+sewi1" ?󿥝)	; ijo sewi, Arabic, scaled
 ("ijo*sewi1" ?󿥝)	; ijo sewi, Arabic, scaled
 ("ijo-sewi2" ?󿮴)	; ijo sewi, secularized, scaled
 ("ijo+sewi2" ?󿮴)	; ijo sewi, secularized, scaled
 ("ijo*sewi2" ?󿮴)	; ijo sewi, secularized, scaled
 ("ijo-sijelo" ?󿥞)	; ijo sijelo, scaled
 ("ijo+sijelo" ?󿥞)	; ijo sijelo, scaled
 ("ijo*sijelo" ?󿥞)	; ijo sijelo, scaled
 ("ijo-sike" ?󿥟)	; ijo sike, scaled
 ("ijo+sike" ?󿥟)	; ijo sike, scaled
 ("ijo*sike" ?󿥟)	; ijo sike, scaled
 ("ijo-sin" ?󿥠)	; ijo sin, scaled
 ("ijo+sin" ?󿥠)	; ijo sin, scaled
 ("ijo*sin" ?󿥠)	; ijo sin, scaled
 ("ijo-sina" ?󿥡)	; ijo sina, default, scaled
 ("ijo+sina" ?󿥡)	; ijo sina, default, scaled
 ("ijo*sina" ?󿥡)	; ijo sina, default, scaled
 ("ijo-sina1" ?󿥡)	; ijo sina, straight, scaled
 ("ijo+sina1" ?󿥡)	; ijo sina, straight, scaled
 ("ijo*sina1" ?󿥡)	; ijo sina, straight, scaled
 ("ijo-sina2" ?󿥡)	; ijo sina, curved, scaled
 ("ijo+sina2" ?󿥡)	; ijo sina, curved, scaled
 ("ijo*sina2" ?󿥡)	; ijo sina, curved, scaled
 ("ijo-sinpin" ?󿥢)	; ijo sinpin, scaled
 ("ijo+sinpin" ?󿥢)	; ijo sinpin, scaled
 ("ijo*sinpin" ?󿥢)	; ijo sinpin, scaled
 ("ijo-sitelen" ?󿥣)	; ijo sitelen, scaled
 ("ijo+sitelen" ?󿥣)	; ijo sitelen, scaled
 ("ijo*sitelen" ?󿥣)	; ijo sitelen, scaled
 ("ijo-sona" ?󿥤)	; ijo sona, scaled
 ("ijo+sona" ?󿥤)	; ijo sona, scaled
 ("ijo*sona" ?󿥤)	; ijo sona, scaled
 ("ijo-soweli" ?󿥥)	; ijo soweli, scaled
 ("ijo+soweli" ?󿥥)	; ijo soweli, scaled
 ("ijo*soweli" ?󿥥)	; ijo soweli, scaled
 ("ijo-suli" ?󿥦)	; ijo suli, scaled
 ("ijo+suli" ?󿥦)	; ijo suli, scaled
 ("ijo*suli" ?󿥦)	; ijo suli, scaled
 ("ijo-suno" ?󿥧)	; ijo suno, scaled
 ("ijo+suno" ?󿥧)	; ijo suno, scaled
 ("ijo*suno" ?󿥧)	; ijo suno, scaled
 ("ijo-supa" ?󿥨)	; ijo supa, scaled
 ("ijo+supa" ?󿥨)	; ijo supa, scaled
 ("ijo*supa" ?󿥨)	; ijo supa, scaled
 ("ijo-suwi" ?󿥩)	; ijo suwi, scaled
 ("ijo+suwi" ?󿥩)	; ijo suwi, scaled
 ("ijo*suwi" ?󿥩)	; ijo suwi, scaled
 ("ijo-tan" ?󿥪)	; ijo tan, scaled
 ("ijo+tan" ?󿥪)	; ijo tan, scaled
 ("ijo*tan" ?󿥪)	; ijo tan, scaled
 ("ijo-taso" ?󿥫)	; ijo taso, scaled
 ("ijo+taso" ?󿥫)	; ijo taso, scaled
 ("ijo*taso" ?󿥫)	; ijo taso, scaled
 ("ijo-tawa" ?󿥬)	; ijo tawa, scaled
 ("ijo+tawa" ?󿥬)	; ijo tawa, scaled
 ("ijo*tawa" ?󿥬)	; ijo tawa, scaled
 ("ijo-telo" ?󿥭)	; ijo telo, scaled
 ("ijo+telo" ?󿥭)	; ijo telo, scaled
 ("ijo*telo" ?󿥭)	; ijo telo, scaled
 ("ijo-tenpo" ?󿥮)	; ijo tenpo, scaled
 ("ijo+tenpo" ?󿥮)	; ijo tenpo, scaled
 ("ijo*tenpo" ?󿥮)	; ijo tenpo, scaled
 ("ijo-toki" ?󿥯)	; ijo toki, scaled
 ("ijo+toki" ?󿥯)	; ijo toki, scaled
 ("ijo*toki" ?󿥯)	; ijo toki, scaled
 ("ijo-tomo" ?󿥰)	; ijo tomo, scaled
 ("ijo+tomo" ?󿥰)	; ijo tomo, scaled
 ("ijo*tomo" ?󿥰)	; ijo tomo, scaled
 ("ijo-tonsi" ?󿥱)	; ijo tonsi, scaled
 ("ijo+tonsi" ?󿥱)	; ijo tonsi, scaled
 ("ijo*tonsi" ?󿥱)	; ijo tonsi, scaled
 ("ijo-tu" ?󿥲)	; ijo tu, scaled
 ("ijo+tu" ?󿥲)	; ijo tu, scaled
 ("ijo*tu" ?󿥲)	; ijo tu, scaled
 ("ijo-unpa" ?󿥳)	; ijo unpa, scaled
 ("ijo+unpa" ?󿥳)	; ijo unpa, scaled
 ("ijo*unpa" ?󿥳)	; ijo unpa, scaled
 ("ijo-uta" ?󿥴)	; ijo uta, default, scaled
 ("ijo+uta" ?󿥴)	; ijo uta, default, scaled
 ("ijo*uta" ?󿥴)	; ijo uta, default, scaled
 ("ijo-uta1" ?󿥴)	; ijo uta, dotted, scaled
 ("ijo+uta1" ?󿥴)	; ijo uta, dotted, scaled
 ("ijo*uta1" ?󿥴)	; ijo uta, dotted, scaled
 ("ijo-uta2" ?󿮵)	; ijo uta, dotless, scaled
 ("ijo+uta2" ?󿮵)	; ijo uta, dotless, scaled
 ("ijo*uta2" ?󿮵)	; ijo uta, dotless, scaled
 ("ijo-utala" ?󿥵)	; ijo utala, scaled
 ("ijo+utala" ?󿥵)	; ijo utala, scaled
 ("ijo*utala" ?󿥵)	; ijo utala, scaled
 ("ijo-walo" ?󿥶)	; ijo walo, scaled
 ("ijo+walo" ?󿥶)	; ijo walo, scaled
 ("ijo*walo" ?󿥶)	; ijo walo, scaled
 ("ijo-wan" ?󿥷)	; ijo wan, scaled
 ("ijo+wan" ?󿥷)	; ijo wan, scaled
 ("ijo*wan" ?󿥷)	; ijo wan, scaled
 ("ijo-waso" ?󿥸)	; ijo waso, scaled
 ("ijo+waso" ?󿥸)	; ijo waso, scaled
 ("ijo*waso" ?󿥸)	; ijo waso, scaled
 ("ijo-wawa" ?󿥹)	; ijo wawa, scaled
 ("ijo+wawa" ?󿥹)	; ijo wawa, scaled
 ("ijo*wawa" ?󿥹)	; ijo wawa, scaled
 ("ijo-weka" ?󿥺)	; ijo weka, scaled
 ("ijo+weka" ?󿥺)	; ijo weka, scaled
 ("ijo*weka" ?󿥺)	; ijo weka, scaled
 ("ijo-wile" ?󿥻)	; ijo wile, default, scaled
 ("ijo+wile" ?󿥻)	; ijo wile, default, scaled
 ("ijo*wile" ?󿥻)	; ijo wile, default, scaled
 ("ijo-wile1" ?󿥻)	; ijo wile, curved w, scaled
 ("ijo+wile1" ?󿥻)	; ijo wile, curved w, scaled
 ("ijo*wile1" ?󿥻)	; ijo wile, curved w, scaled
 ("ijo-wile2" ?󿮶)	; ijo wile, turned pilin, scaled
 ("ijo+wile2" ?󿮶)	; ijo wile, turned pilin, scaled
 ("ijo*wile2" ?󿮶)	; ijo wile, turned pilin, scaled
 ("ike-ala" ?󿥼)	; ike ala, stacked
 ("ike+ala" ?󿥼)	; ike ala, stacked
 ("ike^ala" ?󿥼)	; ike ala, stacked
 ("ike-lili" ?󿥽)	; ike lili, stacked
 ("ike+lili" ?󿥽)	; ike lili, stacked
 ("ike^lili" ?󿥽)	; ike lili, stacked
 ("ike-lukin" ?󿥾)	; ike lukin, stacked
 ("ike+lukin" ?󿥾)	; ike lukin, stacked
 ("ike^lukin" ?󿥾)	; ike lukin, stacked
 ("ike-mute" ?󿴜)	; ike mute, stacked
 ("ike+mute" ?󿴜)	; ike mute, stacked
 ("ike^mute" ?󿴜)	; ike mute, stacked
 ("ilo-kipisi" ?󿥿)	; ilo kipisi, stacked
 ("ilo+kipisi" ?󿥿)	; ilo kipisi, stacked
 ("ilo^kipisi" ?󿥿)	; ilo kipisi, stacked
 ("ilo-lape" ?󿦀)	; ilo lape, stacked
 ("ilo+lape" ?󿦀)	; ilo lape, stacked
 ("ilo^lape" ?󿦀)	; ilo lape, stacked
 ("ilo-lukin" ?󿦁)	; ilo lukin, stacked
 ("ilo+lukin" ?󿦁)	; ilo lukin, stacked
 ("ilo^lukin" ?󿦁)	; ilo lukin, stacked
 ("ilo-moli" ?󿦂)	; ilo moli, stacked
 ("ilo+moli" ?󿦂)	; ilo moli, stacked
 ("ilo^moli" ?󿦂)	; ilo moli, stacked
 ("ilo-moli1" ?󿦂)	; ilo moli, stacked
 ("ilo+moli1" ?󿦂)	; ilo moli, stacked
 ("ilo^moli1" ?󿦂)	; ilo moli, stacked
 ("ilo-moli2" ?󿦂)	; ilo moli, stacked
 ("ilo+moli2" ?󿦂)	; ilo moli, stacked
 ("ilo^moli2" ?󿦂)	; ilo moli, stacked
 ("ilo-musi" ?󿦃)	; ilo musi, stacked
 ("ilo+musi" ?󿦃)	; ilo musi, stacked
 ("ilo^musi" ?󿦃)	; ilo musi, stacked
 ("ilo-nanpa" ?󿦄)	; ilo nanpa, stacked
 ("ilo+nanpa" ?󿦄)	; ilo nanpa, stacked
 ("ilo^nanpa" ?󿦄)	; ilo nanpa, stacked
 ("ilo-oko" ?󿦅)	; ilo oko, stacked
 ("ilo+oko" ?󿦅)	; ilo oko, stacked
 ("ilo^oko" ?󿦅)	; ilo oko, stacked
 ("ilo-open" ?󿦆)	; ilo open, stacked
 ("ilo+open" ?󿦆)	; ilo open, stacked
 ("ilo^open" ?󿦆)	; ilo open, stacked
 ("ilo-suno" ?󿦇)	; ilo suno, stacked
 ("ilo+suno" ?󿦇)	; ilo suno, stacked
 ("ilo^suno" ?󿦇)	; ilo suno, stacked
 ("ilo-toki" ?󿦈)	; ilo toki, stacked
 ("ilo+toki" ?󿦈)	; ilo toki, stacked
 ("ilo^toki" ?󿦈)	; ilo toki, stacked
 ("jan-ala" ?󿦉)	; jan ala, scaled
 ("jan+ala" ?󿦉)	; jan ala, scaled
 ("jan*ala" ?󿦉)	; jan ala, scaled
 ("jan-alasa" ?󿦊)	; jan alasa, scaled
 ("jan+alasa" ?󿦊)	; jan alasa, scaled
 ("jan*alasa" ?󿦊)	; jan alasa, scaled
 ("jan-ale" ?󿦋)	; jan ale, synonym of jan ali, scaled
 ("jan+ale" ?󿦋)	; jan ale, synonym of jan ali, scaled
 ("jan*ale" ?󿦋)	; jan ale, synonym of jan ali, scaled
 ("jan-ali" ?󿦋)	; jan ali, synonym of jan ale, scaled
 ("jan+ali" ?󿦋)	; jan ali, synonym of jan ale, scaled
 ("jan*ali" ?󿦋)	; jan ali, synonym of jan ale, scaled
 ("jan-ante" ?󿦌)	; jan ante, scaled
 ("jan+ante" ?󿦌)	; jan ante, scaled
 ("jan*ante" ?󿦌)	; jan ante, scaled
 ("jan-ike" ?󿦍)	; jan ike, scaled
 ("jan+ike" ?󿦍)	; jan ike, scaled
 ("jan*ike" ?󿦍)	; jan ike, scaled
 ("jan-kala" ?󿦎)	; jan kala, default, scaled
 ("jan+kala" ?󿦎)	; jan kala, default, scaled
 ("jan*kala" ?󿦎)	; jan kala, default, scaled
 ("jan-kala1" ?󿦎)	; jan kala, without eyes, scaled
 ("jan+kala1" ?󿦎)	; jan kala, without eyes, scaled
 ("jan*kala1" ?󿦎)	; jan kala, without eyes, scaled
 ("jan-kala2" ?󿦎)	; jan kala, with eyes, scaled
 ("jan+kala2" ?󿦎)	; jan kala, with eyes, scaled
 ("jan*kala2" ?󿦎)	; jan kala, with eyes, scaled
 ("jan-kalama" ?󿦏)	; jan kalama, scaled
 ("jan+kalama" ?󿦏)	; jan kalama, scaled
 ("jan*kalama" ?󿦏)	; jan kalama, scaled
 ("jan-kasi" ?󿦐)	; jan kasi, scaled
 ("jan+kasi" ?󿦐)	; jan kasi, scaled
 ("jan*kasi" ?󿦐)	; jan kasi, scaled
 ("jan-kulupu" ?󿦑)	; jan kulupu, scaled
 ("jan+kulupu" ?󿦑)	; jan kulupu, scaled
 ("jan*kulupu" ?󿦑)	; jan kulupu, scaled
 ("jan-lawa" ?󿦒)	; jan lawa, scaled
 ("jan+lawa" ?󿦒)	; jan lawa, scaled
 ("jan*lawa" ?󿦒)	; jan lawa, scaled
 ("jan-lili" ?󿦓)	; jan lili, scaled
 ("jan+lili" ?󿦓)	; jan lili, scaled
 ("jan*lili" ?󿦓)	; jan lili, scaled
 ("jan-monsuta" ?󿦔)	; jan monsuta, scaled
 ("jan+monsuta" ?󿦔)	; jan monsuta, scaled
 ("jan*monsuta" ?󿦔)	; jan monsuta, scaled
 ("jan-mute" ?󿦕)	; jan mute, scaled
 ("jan+mute" ?󿦕)	; jan mute, scaled
 ("jan*mute" ?󿦕)	; jan mute, scaled
 ("jan-nasa" ?󿦖)	; jan nasa, scaled
 ("jan+nasa" ?󿦖)	; jan nasa, scaled
 ("jan*nasa" ?󿦖)	; jan nasa, scaled
 ("jan-ni" ?󿴁)	; jan ni, stacked
 ("jan+ni" ?󿴁)	; jan ni, stacked
 ("jan^ni" ?󿴁)	; jan ni, stacked
 ("jan-olin" ?󿦗)	; jan olin, default, scaled
 ("jan+olin" ?󿦗)	; jan olin, default, scaled
 ("jan*olin" ?󿦗)	; jan olin, default, scaled
 ("jan-olin1" ?󿦗)	; jan olin, doubled pilin, scaled
 ("jan+olin1" ?󿦗)	; jan olin, doubled pilin, scaled
 ("jan*olin1" ?󿦗)	; jan olin, doubled pilin, scaled
 ("jan-olin2" ?󿮷)	; jan olin, pilin with emitters, scaled
 ("jan+olin2" ?󿮷)	; jan olin, pilin with emitters, scaled
 ("jan*olin2" ?󿮷)	; jan olin, pilin with emitters, scaled
 ("jan-pakala" ?󿦘)	; jan pakala, scaled
 ("jan+pakala" ?󿦘)	; jan pakala, scaled
 ("jan*pakala" ?󿦘)	; jan pakala, scaled
 ("jan-pali" ?󿦙)	; jan pali, scaled
 ("jan+pali" ?󿦙)	; jan pali, scaled
 ("jan*pali" ?󿦙)	; jan pali, scaled
 ("jan-poka" ?󿦚)	; jan poka, scaled
 ("jan+poka" ?󿦚)	; jan poka, scaled
 ("jan*poka" ?󿦚)	; jan poka, scaled
 ("jan-pona" ?󿦛)	; jan pona, scaled
 ("jan+pona" ?󿦛)	; jan pona, scaled
 ("jan*pona" ?󿦛)	; jan pona, scaled
 ("jan-sama" ?󿦜)	; jan sama, scaled
 ("jan+sama" ?󿦜)	; jan sama, scaled
 ("jan*sama" ?󿦜)	; jan sama, scaled
 ("jan-seme" ?󿦝)	; jan seme, scaled
 ("jan+seme" ?󿦝)	; jan seme, scaled
 ("jan*seme" ?󿦝)	; jan seme, scaled
 ("jan-sewi" ?󿦞)	; jan sewi, default, scaled
 ("jan+sewi" ?󿦞)	; jan sewi, default, scaled
 ("jan*sewi" ?󿦞)	; jan sewi, default, scaled
 ("jan-sewi1" ?󿦞)	; jan sewi, Arabic, scaled
 ("jan+sewi1" ?󿦞)	; jan sewi, Arabic, scaled
 ("jan*sewi1" ?󿦞)	; jan sewi, Arabic, scaled
 ("jan-sewi2" ?󿮸)	; jan sewi, secularized, scaled
 ("jan+sewi2" ?󿮸)	; jan sewi, secularized, scaled
 ("jan*sewi2" ?󿮸)	; jan sewi, secularized, scaled
 ("jan-sin" ?󿦟)	; jan sin, scaled
 ("jan+sin" ?󿦟)	; jan sin, scaled
 ("jan*sin" ?󿦟)	; jan sin, scaled
 ("jan-sona" ?󿦠)	; jan sona, scaled
 ("jan+sona" ?󿦠)	; jan sona, scaled
 ("jan*sona" ?󿦠)	; jan sona, scaled
 ("jan-suli" ?󿦡)	; jan suli, scaled
 ("jan+suli" ?󿦡)	; jan suli, scaled
 ("jan*suli" ?󿦡)	; jan suli, scaled
 ("jan-suwi" ?󿦢)	; jan suwi, scaled
 ("jan+suwi" ?󿦢)	; jan suwi, scaled
 ("jan*suwi" ?󿦢)	; jan suwi, scaled
 ("jan-toki" ?󿦣)	; jan toki, scaled
 ("jan+toki" ?󿦣)	; jan toki, scaled
 ("jan*toki" ?󿦣)	; jan toki, scaled
 ("jan-unpa" ?󿦤)	; jan unpa, scaled
 ("jan+unpa" ?󿦤)	; jan unpa, scaled
 ("jan*unpa" ?󿦤)	; jan unpa, scaled
 ("jan-utala" ?󿦥)	; jan utala, scaled
 ("jan+utala" ?󿦥)	; jan utala, scaled
 ("jan*utala" ?󿦥)	; jan utala, scaled
 ("jan-wawa" ?󿦦)	; jan wawa, scaled
 ("jan+wawa" ?󿦦)	; jan wawa, scaled
 ("jan*wawa" ?󿦦)	; jan wawa, scaled
 ("kala-ike" ?󿸀)	; kala ike, scaled
 ("kala+ike" ?󿸀)	; kala ike, scaled
 ("kala*ike" ?󿸀)	; kala ike, scaled
 ("kala-lete" ?󿦧)	; kala lete, default, default
 ("kala+lete" ?󿦧)	; kala lete, default, default
 ("kala*lete" ?󿦧)	; kala lete, default, scaled
 ("kala^lete" ?󿮹)	; kala lete, default, stacked
 ("kala1-lete" ?󿦧)	; kala lete, without eyes, default
 ("kala1+lete" ?󿦧)	; kala lete, without eyes, default
 ("kala1*lete" ?󿦧)	; kala lete, without eyes, scaled
 ("kala1^lete" ?󿮹)	; kala lete, without eyes, stacked
 ("kala2-lete" ?󿦧)	; kala lete, with eyes, default
 ("kala2+lete" ?󿦧)	; kala lete, with eyes, default
 ("kala2*lete" ?󿦧)	; kala lete, with eyes, scaled
 ("kala2^lete" ?󿮺)	; kala lete, with eyes, stacked
 ("kala-lili" ?󿦨)	; kala lili, default, default
 ("kala+lili" ?󿦨)	; kala lili, default, default
 ("kala*lili" ?󿦨)	; kala lili, default, scaled
 ("kala^lili" ?󿮻)	; kala lili, default, stacked
 ("kala1-lili" ?󿦨)	; kala lili, without eyes, default
 ("kala1+lili" ?󿦨)	; kala lili, without eyes, default
 ("kala1*lili" ?󿦨)	; kala lili, without eyes, scaled
 ("kala1^lili" ?󿮻)	; kala lili, without eyes, stacked
 ("kala2-lili" ?󿦨)	; kala lili, with eyes, default
 ("kala2+lili" ?󿦨)	; kala lili, with eyes, default
 ("kala2*lili" ?󿦨)	; kala lili, with eyes, scaled
 ("kala2^lili" ?󿮼)	; kala lili, with eyes, stacked
 ("kala-pona" ?󿸁)	; kala pona, scaled
 ("kala+pona" ?󿸁)	; kala pona, scaled
 ("kala*pona" ?󿸁)	; kala pona, scaled
 ("kalama-musi" ?󿦩)	; kalama musi, stacked
 ("kalama+musi" ?󿦩)	; kalama musi, stacked
 ("kalama^musi" ?󿦩)	; kalama musi, stacked
 ("kama-pona" ?󿸂)	; kama pona, stacked
 ("kama+pona" ?󿸂)	; kama pona, stacked
 ("kama^pona" ?󿸂)	; kama pona, stacked
 ("kama-sona" ?󿸃)	; kama sona, stacked
 ("kama^sona" ?󿸃)	; kama sona, stacked
 ("kasi-jelo" ?󿦪)	; kasi jelo, stacked
 ("kasi+jelo" ?󿦪)	; kasi jelo, stacked
 ("kasi^jelo" ?󿦪)	; kasi jelo, stacked
 ("kasi-ko" ?󿸄)	; kasi ko, stacked
 ("kasi+ko" ?󿸄)	; kasi ko, stacked
 ("kasi^ko" ?󿸄)	; kasi ko, stacked
 ("kasi-kule" ?󿦫)	; kasi kule, stacked
 ("kasi+kule" ?󿦫)	; kasi kule, stacked
 ("kasi^kule" ?󿦫)	; kasi kule, stacked
 ("kasi-laso" ?󿦬)	; kasi laso, stacked
 ("kasi+laso" ?󿦬)	; kasi laso, stacked
 ("kasi^laso" ?󿦬)	; kasi laso, stacked
 ("kasi-lili" ?󿦭)	; kasi lili, stacked
 ("kasi+lili" ?󿦭)	; kasi lili, stacked
 ("kasi^lili" ?󿦭)	; kasi lili, stacked
 ("kasi-loje" ?󿦮)	; kasi loje, stacked
 ("kasi+loje" ?󿦮)	; kasi loje, stacked
 ("kasi^loje" ?󿦮)	; kasi loje, stacked
 ("kasi-pimeja" ?󿦯)	; kasi pimeja, stacked
 ("kasi+pimeja" ?󿦯)	; kasi pimeja, stacked
 ("kasi^pimeja" ?󿦯)	; kasi pimeja, stacked
 ("kasi-walo" ?󿦰)	; kasi walo, stacked
 ("kasi+walo" ?󿦰)	; kasi walo, stacked
 ("kasi^walo" ?󿦰)	; kasi walo, stacked
 ("kijetesantakalu-soweli" ?󿴨)	; kijetesantakalu soweli, stacked
 ("kijetesantakalu+soweli" ?󿴨)	; kijetesantakalu soweli, stacked
 ("kijetesantakalu^soweli" ?󿴨)	; kijetesantakalu soweli, stacked
 ("kili-jelo" ?󿦱)	; kili jelo, scaled
 ("kili+jelo" ?󿦱)	; kili jelo, scaled
 ("kili*jelo" ?󿦱)	; kili jelo, scaled
 ("kili-laso" ?󿦲)	; kili laso, scaled
 ("kili+laso" ?󿦲)	; kili laso, scaled
 ("kili*laso" ?󿦲)	; kili laso, scaled
 ("kili-lili" ?󿦳)	; kili lili, scaled
 ("kili+lili" ?󿦳)	; kili lili, scaled
 ("kili*lili" ?󿦳)	; kili lili, scaled
 ("kili-loje" ?󿦴)	; kili loje, scaled
 ("kili+loje" ?󿦴)	; kili loje, scaled
 ("kili*loje" ?󿦴)	; kili loje, scaled
 ("kili-palisa" ?󿦵)	; kili palisa, scaled
 ("kili+palisa" ?󿦵)	; kili palisa, scaled
 ("kili*palisa" ?󿦵)	; kili palisa, scaled
 ("kili-pimeja" ?󿦶)	; kili pimeja, scaled
 ("kili+pimeja" ?󿦶)	; kili pimeja, scaled
 ("kili*pimeja" ?󿦶)	; kili pimeja, scaled
 ("kili-suwi" ?󿦷)	; kili suwi, scaled
 ("kili+suwi" ?󿦷)	; kili suwi, scaled
 ("kili*suwi" ?󿦷)	; kili suwi, scaled
 ("kili-walo" ?󿦸)	; kili walo, scaled
 ("kili+walo" ?󿦸)	; kili walo, scaled
 ("kili*walo" ?󿦸)	; kili walo, scaled
 ("kiwen-ike" ?󿴪)	; kiwen ike, scaled
 ("kiwen+ike" ?󿴪)	; kiwen ike, scaled
 ("kiwen*ike" ?󿴪)	; kiwen ike, scaled
 ("kiwen-jelo" ?󿦹)	; kiwen jelo, scaled
 ("kiwen+jelo" ?󿦹)	; kiwen jelo, scaled
 ("kiwen*jelo" ?󿦹)	; kiwen jelo, scaled
 ("kiwen-kasi" ?󿦺)	; kiwen kasi, scaled
 ("kiwen+kasi" ?󿦺)	; kiwen kasi, scaled
 ("kiwen*kasi" ?󿦺)	; kiwen kasi, scaled
 ("kiwen-laso" ?󿦻)	; kiwen laso, scaled
 ("kiwen+laso" ?󿦻)	; kiwen laso, scaled
 ("kiwen*laso" ?󿦻)	; kiwen laso, scaled
 ("kiwen-lete" ?󿦼)	; kiwen lete, scaled
 ("kiwen+lete" ?󿦼)	; kiwen lete, scaled
 ("kiwen*lete" ?󿦼)	; kiwen lete, scaled
 ("kiwen-lili" ?󿦽)	; kiwen lili, scaled
 ("kiwen+lili" ?󿦽)	; kiwen lili, scaled
 ("kiwen*lili" ?󿦽)	; kiwen lili, scaled
 ("kiwen-loje" ?󿦾)	; kiwen loje, scaled
 ("kiwen+loje" ?󿦾)	; kiwen loje, scaled
 ("kiwen*loje" ?󿦾)	; kiwen loje, scaled
 ("kiwen-mun" ?󿦿)	; kiwen mun, scaled
 ("kiwen+mun" ?󿦿)	; kiwen mun, scaled
 ("kiwen*mun" ?󿦿)	; kiwen mun, scaled
 ("kiwen-pimeja" ?󿧀)	; kiwen pimeja, scaled
 ("kiwen+pimeja" ?󿧀)	; kiwen pimeja, scaled
 ("kiwen*pimeja" ?󿧀)	; kiwen pimeja, scaled
 ("kiwen-pona" ?󿴫)	; kiwen pona, scaled
 ("kiwen+pona" ?󿴫)	; kiwen pona, scaled
 ("kiwen*pona" ?󿴫)	; kiwen pona, scaled
 ("kiwen-seli" ?󿧁)	; kiwen seli, scaled
 ("kiwen+seli" ?󿧁)	; kiwen seli, scaled
 ("kiwen*seli" ?󿧁)	; kiwen seli, scaled
 ("kiwen-suno" ?󿧂)	; kiwen suno, scaled
 ("kiwen+suno" ?󿧂)	; kiwen suno, scaled
 ("kiwen*suno" ?󿧂)	; kiwen suno, scaled
 ("kiwen-walo" ?󿧃)	; kiwen walo, scaled
 ("kiwen+walo" ?󿧃)	; kiwen walo, scaled
 ("kiwen*walo" ?󿧃)	; kiwen walo, scaled
 ("ko-jaki" ?󿧄)	; ko jaki, scaled
 ("ko+jaki" ?󿧄)	; ko jaki, scaled
 ("ko*jaki" ?󿧄)	; ko jaki, scaled
 ("ko-jelo" ?󿧅)	; ko jelo, scaled
 ("ko+jelo" ?󿧅)	; ko jelo, scaled
 ("ko*jelo" ?󿧅)	; ko jelo, scaled
 ("ko-kasi" ?󿧆)	; ko kasi, scaled
 ("ko+kasi" ?󿧆)	; ko kasi, scaled
 ("ko*kasi" ?󿧆)	; ko kasi, scaled
 ("ko-kule" ?󿧇)	; ko kule, scaled
 ("ko+kule" ?󿧇)	; ko kule, scaled
 ("ko*kule" ?󿧇)	; ko kule, scaled
 ("ko-laso" ?󿧈)	; ko laso, scaled
 ("ko+laso" ?󿧈)	; ko laso, scaled
 ("ko*laso" ?󿧈)	; ko laso, scaled
 ("ko-lete" ?󿧉)	; ko lete, scaled
 ("ko+lete" ?󿧉)	; ko lete, scaled
 ("ko*lete" ?󿧉)	; ko lete, scaled
 ("ko-lili" ?󿧊)	; ko lili, scaled
 ("ko+lili" ?󿧊)	; ko lili, scaled
 ("ko*lili" ?󿧊)	; ko lili, scaled
 ("ko-loje" ?󿧋)	; ko loje, scaled
 ("ko+loje" ?󿧋)	; ko loje, scaled
 ("ko*loje" ?󿧋)	; ko loje, scaled
 ("ko-nasa" ?󿧌)	; ko nasa, scaled
 ("ko+nasa" ?󿧌)	; ko nasa, scaled
 ("ko*nasa" ?󿧌)	; ko nasa, scaled
 ("ko-pimeja" ?󿧍)	; ko pimeja, scaled
 ("ko+pimeja" ?󿧍)	; ko pimeja, scaled
 ("ko*pimeja" ?󿧍)	; ko pimeja, scaled
 ("ko-seli" ?󿧎)	; ko seli, scaled
 ("ko+seli" ?󿧎)	; ko seli, scaled
 ("ko*seli" ?󿧎)	; ko seli, scaled
 ("ko-walo" ?󿧏)	; ko walo, scaled
 ("ko+walo" ?󿧏)	; ko walo, scaled
 ("ko*walo" ?󿧏)	; ko walo, scaled
 ("kon-lete" ?󿧐)	; kon lete, scaled
 ("kon+lete" ?󿧐)	; kon lete, scaled
 ("kon*lete" ?󿧐)	; kon lete, scaled
 ("kule-ma" ?󿴟)	; kule ma, stacked
 ("kule+ma" ?󿴟)	; kule ma, stacked
 ("kule^ma" ?󿴟)	; kule ma, stacked
 ("kule-uta" ?󿴠)	; kule uta, stacked
 ("kule+uta" ?󿴠)	; kule uta, stacked
 ("kule^uta" ?󿴠)	; kule uta, stacked
 ("kule-kili" ?󿴡)	; kule kili, stacked
 ("kule+kili" ?󿴡)	; kule kili, stacked
 ("kule^kili" ?󿴡)	; kule kili, stacked
 ("kule-suno" ?󿴢)	; kule suno, stacked
 ("kule+suno" ?󿴢)	; kule suno, stacked
 ("kule^suno" ?󿴢)	; kule suno, stacked
 ("kule-kasi" ?󿴣)	; kule kasi, stacked
 ("kule+kasi" ?󿴣)	; kule kasi, stacked
 ("kule^kasi" ?󿴣)	; kule kasi, stacked
 ("kule-sewi" ?󿴤)	; kule sewi, stacked
 ("kule+sewi" ?󿴤)	; kule sewi, stacked
 ("kule^sewi" ?󿴤)	; kule sewi, stacked
 ("kule-sewi1" ?󿴤)	; kule sewi, stacked
 ("kule+sewi1" ?󿴤)	; kule sewi, stacked
 ("kule^sewi1" ?󿴤)	; kule sewi, stacked
 ("kule-sewi2" ?󿴤)	; kule sewi, stacked
 ("kule+sewi2" ?󿴤)	; kule sewi, stacked
 ("kule^sewi2" ?󿴤)	; kule sewi, stacked
 ("kule-telo" ?󿴥)	; kule telo, stacked
 ("kule+telo" ?󿴥)	; kule telo, stacked
 ("kule^telo" ?󿴥)	; kule telo, stacked
 ("kule-mun" ?󿴦)	; kule mun, stacked
 ("kule+mun" ?󿴦)	; kule mun, stacked
 ("kule^mun" ?󿴦)	; kule mun, stacked
 ("kule-pilin" ?󿴧)	; kule pilin, stacked
 ("kule+pilin" ?󿴧)	; kule pilin, stacked
 ("kule^pilin" ?󿴧)	; kule pilin, stacked
 ("laso-kasi" ?󿮽)	; laso kasi, stacked
 ("laso+kasi" ?󿮽)	; laso kasi, stacked
 ("laso^kasi" ?󿮽)	; laso kasi, stacked
 ("laso-mun" ?󿮾)	; laso mun, stacked
 ("laso+mun" ?󿮾)	; laso mun, stacked
 ("laso^mun" ?󿮾)	; laso mun, stacked
 ("laso-sewi" ?󿮿)	; laso sewi, default, stacked
 ("laso+sewi" ?󿮿)	; laso sewi, default, stacked
 ("laso^sewi" ?󿮿)	; laso sewi, default, stacked
 ("laso-sewi1" ?󿮿)	; laso sewi, Arabic, stacked
 ("laso+sewi1" ?󿮿)	; laso sewi, Arabic, stacked
 ("laso^sewi1" ?󿮿)	; laso sewi, Arabic, stacked
 ("laso-sewi2" ?󿯀)	; laso sewi, secularized, stacked
 ("laso+sewi2" ?󿯀)	; laso sewi, secularized, stacked
 ("laso^sewi2" ?󿯀)	; laso sewi, secularized, stacked
 ("laso-telo" ?󿯁)	; laso telo, stacked
 ("laso+telo" ?󿯁)	; laso telo, stacked
 ("laso^telo" ?󿯁)	; laso telo, stacked
 ("len-jan" ?󿧑)	; len jan, scaled
 ("len+jan" ?󿧑)	; len jan, scaled
 ("len*jan" ?󿧑)	; len jan, scaled
 ("len-jelo" ?󿧒)	; len jelo, scaled
 ("len+jelo" ?󿧒)	; len jelo, scaled
 ("len*jelo" ?󿧒)	; len jelo, scaled
 ("len-laso" ?󿧓)	; len laso, scaled
 ("len+laso" ?󿧓)	; len laso, scaled
 ("len*laso" ?󿧓)	; len laso, scaled
 ("len-lawa" ?󿧔)	; len lawa, scaled
 ("len+lawa" ?󿧔)	; len lawa, scaled
 ("len*lawa" ?󿧔)	; len lawa, scaled
 ("len-lili" ?󿧕)	; len lili, scaled
 ("len+lili" ?󿧕)	; len lili, scaled
 ("len*lili" ?󿧕)	; len lili, scaled
 ("len-loje" ?󿧖)	; len loje, scaled
 ("len+loje" ?󿧖)	; len loje, scaled
 ("len*loje" ?󿧖)	; len loje, scaled
 ("len-luka" ?󿧗)	; len luka, scaled
 ("len+luka" ?󿧗)	; len luka, scaled
 ("len*luka" ?󿧗)	; len luka, scaled
 ("len-noka" ?󿧘)	; len noka, scaled
 ("len+noka" ?󿧘)	; len noka, scaled
 ("len*noka" ?󿧘)	; len noka, scaled
 ("len-pimeja" ?󿧙)	; len pimeja, scaled
 ("len+pimeja" ?󿧙)	; len pimeja, scaled
 ("len*pimeja" ?󿧙)	; len pimeja, scaled
 ("len-sin" ?󿧚)	; len sin, scaled
 ("len+sin" ?󿧚)	; len sin, scaled
 ("len*sin" ?󿧚)	; len sin, scaled
 ("len-walo" ?󿧛)	; len walo, scaled
 ("len+walo" ?󿧛)	; len walo, scaled
 ("len*walo" ?󿧛)	; len walo, scaled
 ("linja-lili" ?󿧜)	; linja lili, stacked
 ("linja+lili" ?󿧜)	; linja lili, stacked
 ("linja^lili" ?󿧜)	; linja lili, stacked
 ("linja-pona" ?󿧝)	; linja pona, stacked
 ("linja+pona" ?󿧝)	; linja pona, stacked
 ("linja^pona" ?󿧝)	; linja pona, stacked
 ("linja-sike" ?󿯴)	; linja sike, stacked
 ("linja+sike" ?󿯴)	; linja sike, stacked
 ("linja^sike" ?󿯴)	; linja sike, stacked
 ("linja-suwi" ?󿯵)	; linja suwi, stacked
 ("linja+suwi" ?󿯵)	; linja suwi, stacked
 ("linja^suwi" ?󿯵)	; linja suwi, stacked
 ("lipu-kasi" ?󿧞)	; lipu kasi, scaled
 ("lipu+kasi" ?󿧞)	; lipu kasi, scaled
 ("lipu*kasi" ?󿧞)	; lipu kasi, scaled
 ("lipu-kule" ?󿴓)	; lipu kule, default
 ("lipu+kule" ?󿴓)	; lipu kule, default
 ("lipu*kule" ?󿴓)	; lipu kule, scaled
 ("lipu^kule" ?󿴒)	; lipu kule, stacked
 ("lipu-majuna" ?󿴑)	; lipu majuna, default, default
 ("lipu+majuna" ?󿴑)	; lipu majuna, default, default
 ("lipu*majuna" ?󿴑)	; lipu majuna, default, scaled
 ("lipu^majuna" ?󿴐)	; lipu majuna, default, stacked
 ("lipu-majuna2" ?󿴑)	; lipu majuna, lotus, default
 ("lipu+majuna2" ?󿴑)	; lipu majuna, lotus, default
 ("lipu*majuna2" ?󿴑)	; lipu majuna, lotus, scaled
 ("lipu^majuna2" ?󿴐)	; lipu majuna, lotus, stacked
 ("lipu-nanpa" ?󿧟)	; lipu nanpa, scaled
 ("lipu+nanpa" ?󿧟)	; lipu nanpa, scaled
 ("lipu*nanpa" ?󿧟)	; lipu nanpa, scaled
 ("lipu-nimi" ?󿯂)	; lipu nimi, scaled
 ("lipu+nimi" ?󿯂)	; lipu nimi, scaled
 ("lipu*nimi" ?󿯂)	; lipu nimi, scaled
 ("lipu-sewi" ?󿧠)	; lipu sewi, default, scaled
 ("lipu+sewi" ?󿧠)	; lipu sewi, default, scaled
 ("lipu*sewi" ?󿧠)	; lipu sewi, default, scaled
 ("lipu-sewi1" ?󿧠)	; lipu sewi, Arabic, scaled
 ("lipu+sewi1" ?󿧠)	; lipu sewi, Arabic, scaled
 ("lipu*sewi1" ?󿧠)	; lipu sewi, Arabic, scaled
 ("lipu-sewi2" ?󿯃)	; lipu sewi, secularized, scaled
 ("lipu+sewi2" ?󿯃)	; lipu sewi, secularized, scaled
 ("lipu*sewi2" ?󿯃)	; lipu sewi, secularized, scaled
 ("lipu-sona" ?󿧡)	; lipu sona, scaled
 ("lipu+sona" ?󿧡)	; lipu sona, scaled
 ("lipu*sona" ?󿧡)	; lipu sona, scaled
 ("lipu-tenpo" ?󿯄)	; lipu tenpo, default
 ("lipu+tenpo" ?󿯄)	; lipu tenpo, magazine logo
 ("lipu*tenpo" ?󿴕)	; lipu tenpo, scaled
 ("lipu^tenpo" ?󿴔)	; lipu tenpo, stacked
 ("lipu-toki" ?󿧢)	; lipu toki, scaled
 ("lipu+toki" ?󿧢)	; lipu toki, scaled
 ("lipu*toki" ?󿧢)	; lipu toki, scaled
 ("lipu-unpa" ?󿴗)	; lipu unpa, default
 ("lipu+unpa" ?󿴗)	; lipu unpa, default
 ("lipu*unpa" ?󿴗)	; lipu unpa, scaled
 ("lipu^unpa" ?󿴖)	; lipu unpa, stacked
 ("loje-jelo" ?󿯅)	; loje jelo, stacked
 ("loje+jelo" ?󿯅)	; loje jelo, stacked
 ("loje^jelo" ?󿯅)	; loje jelo, stacked
 ("loje-walo" ?󿯆)	; loje walo, stacked
 ("loje+walo" ?󿯆)	; loje walo, stacked
 ("loje^walo" ?󿯆)	; loje walo, stacked
 ("luka-luka" ?󿩉)	; luka luka, default
 ("luka+luka" ?󿩉)	; luka luka, horizontal
 ("luka^luka" ?󿧣)	; luka luka, stacked
 ("luka*luka" ?󿯇)	; luka luka, scaled
 ("luka-tu" ?󿩄)	; luka tu, default
 ("luka+tu" ?󿩄)	; luka tu, horizontal
 ("luka^tu" ?󿯍)	; luka tu, stacked
 ("luka-wan" ?󿩂)	; luka wan, default
 ("luka+wan" ?󿩂)	; luka wan, horizontal
 ("luka^wan" ?󿯎)	; luka wan, stacked
 ("lupa-jaki" ?󿧤)	; lupa jaki, scaled
 ("lupa+jaki" ?󿧤)	; lupa jaki, scaled
 ("lupa*jaki" ?󿧤)	; lupa jaki, scaled
 ("lupa-kiwen" ?󿧥)	; lupa kiwen, scaled
 ("lupa+kiwen" ?󿧥)	; lupa kiwen, scaled
 ("lupa*kiwen" ?󿧥)	; lupa kiwen, scaled
 ("lupa-kute" ?󿧦)	; lupa kute, scaled
 ("lupa+kute" ?󿧦)	; lupa kute, scaled
 ("lupa*kute" ?󿧦)	; lupa kute, scaled
 ("lupa-lili" ?󿧧)	; lupa lili, scaled
 ("lupa+lili" ?󿧧)	; lupa lili, scaled
 ("lupa*lili" ?󿧧)	; lupa lili, scaled
 ("lupa-meli" ?󿧨)	; lupa meli, default, scaled
 ("lupa+meli" ?󿧨)	; lupa meli, default, scaled
 ("lupa*meli" ?󿧨)	; lupa meli, default, scaled
 ("lupa-meli1" ?󿧨)	; lupa meli, head with hair, scaled
 ("lupa+meli1" ?󿧨)	; lupa meli, head with hair, scaled
 ("lupa*meli1" ?󿧨)	; lupa meli, head with hair, scaled
 ("lupa-meli2" ?󿯏)	; lupa meli, female sign, scaled
 ("lupa+meli2" ?󿯏)	; lupa meli, female sign, scaled
 ("lupa*meli2" ?󿯏)	; lupa meli, female sign, scaled
 ("lupa-monsi" ?󿧩)	; lupa monsi, scaled
 ("lupa+monsi" ?󿧩)	; lupa monsi, scaled
 ("lupa*monsi" ?󿧩)	; lupa monsi, scaled
 ("lupa-nena" ?󿧪)	; lupa nena, scaled
 ("lupa+nena" ?󿧪)	; lupa nena, scaled
 ("lupa*nena" ?󿧪)	; lupa nena, scaled
 ("lupa-tomo" ?󿧫)	; lupa tomo, scaled
 ("lupa+tomo" ?󿧫)	; lupa tomo, scaled
 ("lupa*tomo" ?󿧫)	; lupa tomo, scaled
 ("ma-ale" ?󿧬)	; ma ale, synonym of ma ali, stacked
 ("ma+ale" ?󿧬)	; ma ale, synonym of ma ali, stacked
 ("ma^ale" ?󿧬)	; ma ale, synonym of ma ali, stacked
 ("ma-ali" ?󿧬)	; ma ali, synonym of ma ale, stacked
 ("ma+ali" ?󿧬)	; ma ali, synonym of ma ale, stacked
 ("ma^ali" ?󿧬)	; ma ali, synonym of ma ale, stacked
 ("ma-ike" ?󿴅)	; ma ike, stacked
 ("ma+ike" ?󿴅)	; ma ike, stacked
 ("ma^ike" ?󿴅)	; ma ike, stacked
 ("ma-kasi" ?󿧭)	; ma kasi, stacked
 ("ma+kasi" ?󿧭)	; ma kasi, stacked
 ("ma^kasi" ?󿧭)	; ma kasi, stacked
 ("ma-ni" ?󿴂)	; ma ni, stacked
 ("ma+ni" ?󿴂)	; ma ni, stacked
 ("ma^ni" ?󿴂)	; ma ni, stacked
 ("ma-pona" ?󿴆)	; ma pona, stacked
 ("ma+pona" ?󿴆)	; ma pona, stacked
 ("ma^pona" ?󿴆)	; ma pona, stacked
 ("ma-tomo" ?󿧮)	; ma tomo, stacked
 ("ma+tomo" ?󿧮)	; ma tomo, stacked
 ("ma^tomo" ?󿧮)	; ma tomo, stacked
 ("mama-mama" ?󿧯)	; mama mama, scaled
 ("mama+mama" ?󿧯)	; mama mama, scaled
 ("mama*mama" ?󿧯)	; mama mama, scaled
 ("mama-meli" ?󿧰)	; mama meli, default, scaled
 ("mama+meli" ?󿧰)	; mama meli, default, scaled
 ("mama*meli" ?󿧰)	; mama meli, default, scaled
 ("mama-meli1" ?󿧰)	; mama meli, head with hair, scaled
 ("mama+meli1" ?󿧰)	; mama meli, head with hair, scaled
 ("mama*meli1" ?󿧰)	; mama meli, head with hair, scaled
 ("mama-meli2" ?󿯐)	; mama meli, female sign, scaled
 ("mama+meli2" ?󿯐)	; mama meli, female sign, scaled
 ("mama*meli2" ?󿯐)	; mama meli, female sign, scaled
 ("mama-mije" ?󿧱)	; mama mije, default, scaled
 ("mama+mije" ?󿧱)	; mama mije, default, scaled
 ("mama*mije" ?󿧱)	; mama mije, default, scaled
 ("mama-mije1" ?󿧱)	; mama mije, head and shoulders, scaled
 ("mama+mije1" ?󿧱)	; mama mije, head and shoulders, scaled
 ("mama*mije1" ?󿧱)	; mama mije, head and shoulders, scaled
 ("mama-mije2" ?󿯑)	; mama mije, male sign, scaled
 ("mama+mije2" ?󿯑)	; mama mije, male sign, scaled
 ("mama*mije2" ?󿯑)	; mama mije, male sign, scaled
 ("mama-tonsi" ?󿯒)	; mama tonsi, scaled
 ("mama+tonsi" ?󿯒)	; mama tonsi, scaled
 ("mama*tonsi" ?󿯒)	; mama tonsi, scaled
 ("meli-ike" ?󿧲)	; meli ike, default, scaled
 ("meli+ike" ?󿧲)	; meli ike, default, scaled
 ("meli*ike" ?󿧲)	; meli ike, default, scaled
 ("meli1-ike" ?󿧲)	; meli ike, head with hair, scaled
 ("meli1+ike" ?󿧲)	; meli ike, head with hair, scaled
 ("meli1*ike" ?󿧲)	; meli ike, head with hair, scaled
 ("meli2-ike" ?󿯓)	; meli ike, female sign, scaled
 ("meli2+ike" ?󿯓)	; meli ike, female sign, scaled
 ("meli2*ike" ?󿯓)	; meli ike, female sign, scaled
 ("meli-lili" ?󿧳)	; meli lili, default, scaled
 ("meli+lili" ?󿧳)	; meli lili, default, scaled
 ("meli*lili" ?󿧳)	; meli lili, default, scaled
 ("meli1-lili" ?󿧳)	; meli lili, head with hair, scaled
 ("meli1+lili" ?󿧳)	; meli lili, head with hair, scaled
 ("meli1*lili" ?󿧳)	; meli lili, head with hair, scaled
 ("meli2-lili" ?󿯔)	; meli lili, female sign, scaled
 ("meli2+lili" ?󿯔)	; meli lili, female sign, scaled
 ("meli2*lili" ?󿯔)	; meli lili, female sign, scaled
 ("meli-mije" ?󿴇)	; meli mije, head with hair and shoulders, combined
 ("meli+mije" ?󿴇)	; meli mije, head with hair and shoulders, combined
 ("meli1-mije1" ?󿴇)	; meli mije, head with hair and shoulders, combined
 ("meli1+mije1" ?󿴇)	; meli mije, head with hair and shoulders, combined
 ("meli2-mije2" ?󿴈)	; meli mije, male and female sign, combined
 ("meli2+mije2" ?󿴈)	; meli mije, male and female sign, combined
 ("meli-pona" ?󿧴)	; meli pona, default, scaled
 ("meli+pona" ?󿧴)	; meli pona, default, scaled
 ("meli*pona" ?󿧴)	; meli pona, default, scaled
 ("meli1-pona" ?󿧴)	; meli pona, head with hair, scaled
 ("meli1+pona" ?󿧴)	; meli pona, head with hair, scaled
 ("meli1*pona" ?󿧴)	; meli pona, head with hair, scaled
 ("meli2-pona" ?󿯕)	; meli pona, female sign, scaled
 ("meli2+pona" ?󿯕)	; meli pona, female sign, scaled
 ("meli2*pona" ?󿯕)	; meli pona, female sign, scaled
 ("meli-sama" ?󿧵)	; meli sama, default, scaled
 ("meli+sama" ?󿧵)	; meli sama, default, scaled
 ("meli*sama" ?󿧵)	; meli sama, default, scaled
 ("meli1-sama" ?󿧵)	; meli sama, head with hair, scaled
 ("meli1+sama" ?󿧵)	; meli sama, head with hair, scaled
 ("meli1*sama" ?󿧵)	; meli sama, head with hair, scaled
 ("meli2-sama" ?󿯖)	; meli sama, female sign, scaled
 ("meli2+sama" ?󿯖)	; meli sama, female sign, scaled
 ("meli2*sama" ?󿯖)	; meli sama, female sign, scaled
 ("meli-tonsi" ?󿯗)	; meli tonsi, default, scaled
 ("meli+tonsi" ?󿯗)	; meli tonsi, default, scaled
 ("meli*tonsi" ?󿯗)	; meli tonsi, default, scaled
 ("meli1-tonsi" ?󿯗)	; meli tonsi, head with hair, scaled
 ("meli1+tonsi" ?󿯗)	; meli tonsi, head with hair, scaled
 ("meli1*tonsi" ?󿯗)	; meli tonsi, head with hair, scaled
 ("meli2-tonsi" ?󿯘)	; meli tonsi, female sign, scaled
 ("meli2+tonsi" ?󿯘)	; meli tonsi, female sign, scaled
 ("meli2*tonsi" ?󿯘)	; meli tonsi, female sign, scaled
 ("meli-unpa" ?󿧶)	; meli unpa, default, scaled
 ("meli+unpa" ?󿧶)	; meli unpa, default, scaled
 ("meli*unpa" ?󿧶)	; meli unpa, default, scaled
 ("meli1-unpa" ?󿧶)	; meli unpa, head with hair, scaled
 ("meli1+unpa" ?󿧶)	; meli unpa, head with hair, scaled
 ("meli1*unpa" ?󿧶)	; meli unpa, head with hair, scaled
 ("meli2-unpa" ?󿯙)	; meli unpa, female sign, scaled
 ("meli2+unpa" ?󿯙)	; meli unpa, female sign, scaled
 ("meli2*unpa" ?󿯙)	; meli unpa, female sign, scaled
 ("meli-wawa" ?󿯚)	; meli wawa, default, scaled
 ("meli+wawa" ?󿯚)	; meli wawa, default, scaled
 ("meli*wawa" ?󿯚)	; meli wawa, default, scaled
 ("meli1-wawa" ?󿯚)	; meli wawa, head with hair, scaled
 ("meli1+wawa" ?󿯚)	; meli wawa, head with hair, scaled
 ("meli1*wawa" ?󿯚)	; meli wawa, head with hair, scaled
 ("meli2-wawa" ?󿯛)	; meli wawa, female sign, scaled
 ("meli2+wawa" ?󿯛)	; meli wawa, female sign, scaled
 ("meli2*wawa" ?󿯛)	; meli wawa, female sign, scaled
 ("mije-ike" ?󿧷)	; mije ike, default, scaled
 ("mije+ike" ?󿧷)	; mije ike, default, scaled
 ("mije*ike" ?󿧷)	; mije ike, default, scaled
 ("mije1-ike" ?󿧷)	; mije ike, head and shoulders, scaled
 ("mije1+ike" ?󿧷)	; mije ike, head and shoulders, scaled
 ("mije1*ike" ?󿧷)	; mije ike, head and shoulders, scaled
 ("mije2-ike" ?󿯜)	; mije ike, male sign, scaled
 ("mije2+ike" ?󿯜)	; mije ike, male sign, scaled
 ("mije2*ike" ?󿯜)	; mije ike, male sign, scaled
 ("mije-lili" ?󿧸)	; mije lili, default, scaled
 ("mije+lili" ?󿧸)	; mije lili, default, scaled
 ("mije*lili" ?󿧸)	; mije lili, default, scaled
 ("mije1-lili" ?󿧸)	; mije lili, head and shoulders, scaled
 ("mije1+lili" ?󿧸)	; mije lili, head and shoulders, scaled
 ("mije1*lili" ?󿧸)	; mije lili, head and shoulders, scaled
 ("mije2-lili" ?󿯝)	; mije lili, male sign, scaled
 ("mije2+lili" ?󿯝)	; mije lili, male sign, scaled
 ("mije2*lili" ?󿯝)	; mije lili, male sign, scaled
 ("mije-meli" ?󿴇)	; mije meli, head with hair and shoulders, combined
 ("mije+meli" ?󿴇)	; mije meli, head with hair and shoulders, combined
 ("mije1-meli1" ?󿴇)	; mije meli, head with hair and shoulders, combined
 ("mije1+meli1" ?󿴇)	; mije meli, head with hair and shoulders, combined
 ("mije2-meli2" ?󿴈)	; mije meli, male and female sign, combined
 ("mije2+meli2" ?󿴈)	; mije meli, male and female sign, combined
 ("mije-pona" ?󿧹)	; mije pona, default, scaled
 ("mije+pona" ?󿧹)	; mije pona, default, scaled
 ("mije*pona" ?󿧹)	; mije pona, default, scaled
 ("mije1-pona" ?󿧹)	; mije pona, head and shoulders, scaled
 ("mije1+pona" ?󿧹)	; mije pona, head and shoulders, scaled
 ("mije1*pona" ?󿧹)	; mije pona, head and shoulders, scaled
 ("mije2-pona" ?󿯞)	; mije pona, male sign, scaled
 ("mije2+pona" ?󿯞)	; mije pona, male sign, scaled
 ("mije2*pona" ?󿯞)	; mije pona, male sign, scaled
 ("mije-sama" ?󿧺)	; mije sama, default, scaled
 ("mije+sama" ?󿧺)	; mije sama, default, scaled
 ("mije*sama" ?󿧺)	; mije sama, default, scaled
 ("mije1-sama" ?󿧺)	; mije sama, head and shoulders, scaled
 ("mije1+sama" ?󿧺)	; mije sama, head and shoulders, scaled
 ("mije1*sama" ?󿧺)	; mije sama, head and shoulders, scaled
 ("mije2-sama" ?󿯟)	; mije sama, male sign, scaled
 ("mije2+sama" ?󿯟)	; mije sama, male sign, scaled
 ("mije2*sama" ?󿯟)	; mije sama, male sign, scaled
 ("mije-tonsi" ?󿯠)	; mije tonsi, default, scaled
 ("mije+tonsi" ?󿯠)	; mije tonsi, default, scaled
 ("mije*tonsi" ?󿯠)	; mije tonsi, default, scaled
 ("mije1-tonsi" ?󿯠)	; mije tonsi, head and shoulders, scaled
 ("mije1+tonsi" ?󿯠)	; mije tonsi, head and shoulders, scaled
 ("mije1*tonsi" ?󿯠)	; mije tonsi, head and shoulders, scaled
 ("mije2-tonsi" ?󿯡)	; mije tonsi, male sign, scaled
 ("mije2+tonsi" ?󿯡)	; mije tonsi, male sign, scaled
 ("mije2*tonsi" ?󿯡)	; mije tonsi, male sign, scaled
 ("mije-unpa" ?󿧻)	; mije unpa, default, scaled
 ("mije+unpa" ?󿧻)	; mije unpa, default, scaled
 ("mije*unpa" ?󿧻)	; mije unpa, default, scaled
 ("mije1-unpa" ?󿧻)	; mije unpa, head and shoulders, scaled
 ("mije1+unpa" ?󿧻)	; mije unpa, head and shoulders, scaled
 ("mije1*unpa" ?󿧻)	; mije unpa, head and shoulders, scaled
 ("mije2-unpa" ?󿯢)	; mije unpa, male sign, scaled
 ("mije2+unpa" ?󿯢)	; mije unpa, male sign, scaled
 ("mije2*unpa" ?󿯢)	; mije unpa, male sign, scaled
 ("mije-wawa" ?󿧼)	; mije wawa, default, scaled
 ("mije+wawa" ?󿧼)	; mije wawa, default, scaled
 ("mije*wawa" ?󿧼)	; mije wawa, default, scaled
 ("mije1-wawa" ?󿧼)	; mije wawa, head and shoulders, scaled
 ("mije1+wawa" ?󿧼)	; mije wawa, head and shoulders, scaled
 ("mije1*wawa" ?󿧼)	; mije wawa, head and shoulders, scaled
 ("mije2-wawa" ?󿯣)	; mije wawa, male sign, scaled
 ("mije2+wawa" ?󿯣)	; mije wawa, male sign, scaled
 ("mije2*wawa" ?󿯣)	; mije wawa, male sign, scaled
 ("musi-lili" ?󿧽)	; musi lili, scaled
 ("musi+lili" ?󿧽)	; musi lili, scaled
 ("musi*lili" ?󿧽)	; musi lili, scaled
 ("mute-mute" ?󿴝)	; mute mute, stacked
 ("mute+mute" ?󿴝)	; mute mute, stacked
 ("mute^mute" ?󿴝)	; mute mute, stacked
 ("nasin-nanpa" ?󿯶)	; nasin nanpa, default
 ("nasin+nanpa" ?󿯶)	; nasin nanpa, horizontal
 ("nasin^nanpa" ?󿯷)	; nasin nanpa, stacked
 ("nasin-sitelen" ?󿯸)	; nasin sitelen, stacked
 ("nasin+sitelen" ?󿯸)	; nasin sitelen, stacked
 ("nasin^sitelen" ?󿯸)	; nasin sitelen, stacked
 ("nena-kon" ?󿧾)	; nena kon, scaled
 ("nena+kon" ?󿧾)	; nena kon, scaled
 ("nena*kon" ?󿧾)	; nena kon, scaled
 ("nena-kute" ?󿧿)	; nena kute, scaled
 ("nena+kute" ?󿧿)	; nena kute, scaled
 ("nena*kute" ?󿧿)	; nena kute, scaled
 ("nena-lili" ?󿨀)	; nena lili, scaled
 ("nena+lili" ?󿨀)	; nena lili, scaled
 ("nena*lili" ?󿨀)	; nena lili, scaled
 ("nena-mama" ?󿨁)	; nena mama, scaled
 ("nena+mama" ?󿨁)	; nena mama, scaled
 ("nena*mama" ?󿨁)	; nena mama, scaled
 ("nena-meli" ?󿨂)	; nena meli, default, scaled
 ("nena+meli" ?󿨂)	; nena meli, default, scaled
 ("nena*meli" ?󿨂)	; nena meli, default, scaled
 ("nena-meli1" ?󿨂)	; nena meli, head with hair, scaled
 ("nena+meli1" ?󿨂)	; nena meli, head with hair, scaled
 ("nena*meli1" ?󿨂)	; nena meli, head with hair, scaled
 ("nena-meli2" ?󿯤)	; nena meli, female sign, scaled
 ("nena+meli2" ?󿯤)	; nena meli, female sign, scaled
 ("nena*meli2" ?󿯤)	; nena meli, female sign, scaled
 ("nimi-sin" ?󿶖)	; nimi sin, default
 ("nimi+sin" ?󿶖)	; nimi sin, default
 ("nimi^sin" ?󿯺)	; nimi sin, stacked
 ("nimi*sin" ?󿯻)	; nimi sin, scaled
 ("palisa-lili" ?󿨃)	; palisa lili, scaled
 ("palisa+lili" ?󿨃)	; palisa lili, scaled
 ("palisa*lili" ?󿨃)	; palisa lili, scaled
 ("pilin-ala" ?󿨄)	; pilin ala, scaled
 ("pilin+ala" ?󿨄)	; pilin ala, scaled
 ("pilin*ala" ?󿨄)	; pilin ala, scaled
 ("pilin-ike" ?󿨅)	; pilin ike, scaled
 ("pilin+ike" ?󿨅)	; pilin ike, scaled
 ("pilin*ike" ?󿨅)	; pilin ike, scaled
 ("pilin-nasa" ?󿨆)	; pilin nasa, scaled
 ("pilin+nasa" ?󿨆)	; pilin nasa, scaled
 ("pilin*nasa" ?󿨆)	; pilin nasa, scaled
 ("pilin-pakala" ?󿨇)	; pilin pakala, scaled
 ("pilin+pakala" ?󿨇)	; pilin pakala, scaled
 ("pilin*pakala" ?󿨇)	; pilin pakala, scaled
 ("pilin-pona" ?󿨈)	; pilin pona, scaled
 ("pilin+pona" ?󿨈)	; pilin pona, scaled
 ("pilin*pona" ?󿨈)	; pilin pona, scaled
 ("pilin-sama" ?󿨉)	; pilin sama, scaled
 ("pilin+sama" ?󿨉)	; pilin sama, scaled
 ("pilin*sama" ?󿨉)	; pilin sama, scaled
 ("pilin-seme" ?󿸅)	; pilin seme, scaled
 ("pilin+seme" ?󿸅)	; pilin seme, scaled
 ("pilin*seme" ?󿸅)	; pilin seme, scaled
 ("pimeja-jelo" ?󿴉)	; pimeja jelo, combined
 ("pimeja+jelo" ?󿴉)	; pimeja jelo, combined
 ("pimeja-laso" ?󿴊)	; pimeja laso, combined
 ("pimeja+laso" ?󿴊)	; pimeja laso, combined
 ("pimeja-loje" ?󿴋)	; pimeja loje, combined
 ("pimeja+loje" ?󿴋)	; pimeja loje, combined
 ("poki-kon" ?󿨊)	; poki kon, scaled
 ("poki+kon" ?󿨊)	; poki kon, scaled
 ("poki*kon" ?󿨊)	; poki kon, scaled
 ("poki-len" ?󿨋)	; poki len, scaled
 ("poki+len" ?󿨋)	; poki len, scaled
 ("poki*len" ?󿨋)	; poki len, scaled
 ("poki-lete" ?󿨌)	; poki lete, scaled
 ("poki+lete" ?󿨌)	; poki lete, scaled
 ("poki*lete" ?󿨌)	; poki lete, scaled
 ("poki-lili" ?󿨍)	; poki lili, scaled
 ("poki+lili" ?󿨍)	; poki lili, scaled
 ("poki*lili" ?󿨍)	; poki lili, scaled
 ("poki-seli" ?󿨎)	; poki seli, scaled
 ("poki+seli" ?󿨎)	; poki seli, scaled
 ("poki*seli" ?󿨎)	; poki seli, scaled
 ("poki-telo" ?󿨏)	; poki telo, scaled
 ("poki+telo" ?󿨏)	; poki telo, scaled
 ("poki*telo" ?󿨏)	; poki telo, scaled
 ("poki-tona" ?󿮯)	; poki tona, scaled
 ("poki+tona" ?󿮯)	; poki tona, scaled
 ("poki*tona" ?󿮯)	; poki tona, scaled
 ("pona-ala" ?󿨐)	; pona ala, stacked
 ("pona+ala" ?󿨐)	; pona ala, stacked
 ("pona^ala" ?󿨐)	; pona ala, stacked
 ("pona-lili" ?󿨑)	; pona lili, stacked
 ("pona+lili" ?󿨑)	; pona lili, stacked
 ("pona^lili" ?󿨑)	; pona lili, stacked
 ("pona-lukin" ?󿨒)	; pona lukin, stacked
 ("pona+lukin" ?󿨒)	; pona lukin, stacked
 ("pona^lukin" ?󿨒)	; pona lukin, stacked
 ("pona-mute" ?󿴞)	; pona mute, stacked
 ("pona+mute" ?󿴞)	; pona mute, stacked
 ("pona^mute" ?󿴞)	; pona mute, stacked
 ("selo-len" ?󿨓)	; selo len, stacked
 ("selo+len" ?󿨓)	; selo len, stacked
 ("selo^len" ?󿨓)	; selo len, stacked
 ("selo-soweli" ?󿨔)	; selo soweli, stacked
 ("selo+soweli" ?󿨔)	; selo soweli, stacked
 ("selo^soweli" ?󿨔)	; selo soweli, stacked
 ("sike-lili" ?󿨕)	; sike lili, scaled
 ("sike+lili" ?󿨕)	; sike lili, scaled
 ("sike*lili" ?󿨕)	; sike lili, scaled
 ("sitelen-ike" ?󿨖)	; sitelen ike, scaled
 ("sitelen+ike" ?󿨖)	; sitelen ike, scaled
 ("sitelen*ike" ?󿨖)	; sitelen ike, scaled
 ("sitelen-ma" ?󿨗)	; sitelen ma, scaled
 ("sitelen+ma" ?󿨗)	; sitelen ma, scaled
 ("sitelen*ma" ?󿨗)	; sitelen ma, scaled
 ("sitelen-monsuta" ?󿨘)	; sitelen monsuta, scaled
 ("sitelen+monsuta" ?󿨘)	; sitelen monsuta, scaled
 ("sitelen*monsuta" ?󿨘)	; sitelen monsuta, scaled
 ("sitelen-pona" ?󿨙)	; sitelen pona, scaled
 ("sitelen+pona" ?󿨙)	; sitelen pona, scaled
 ("sitelen*pona" ?󿨙)	; sitelen pona, scaled
 ("sitelen-sitelen" ?󿨚)	; sitelen sitelen, scaled
 ("sitelen+sitelen" ?󿨚)	; sitelen sitelen, scaled
 ("sitelen*sitelen" ?󿨚)	; sitelen sitelen, scaled
 ("sitelen-tawa" ?󿨛)	; sitelen tawa, scaled
 ("sitelen+tawa" ?󿨛)	; sitelen tawa, scaled
 ("sitelen*tawa" ?󿨛)	; sitelen tawa, scaled
 ("sitelen-toki" ?󿨜)	; sitelen toki, scaled
 ("sitelen+toki" ?󿨜)	; sitelen toki, scaled
 ("sitelen*toki" ?󿨜)	; sitelen toki, scaled
 ("sona-ala" ?󿨝)	; sona ala, scaled
 ("sona+ala" ?󿨝)	; sona ala, scaled
 ("sona*ala" ?󿨝)	; sona ala, scaled
 ("sona-ike" ?󿨞)	; sona ike, scaled
 ("sona+ike" ?󿨞)	; sona ike, scaled
 ("sona*ike" ?󿨞)	; sona ike, scaled
 ("sona-lili" ?󿨟)	; sona lili, scaled
 ("sona+lili" ?󿨟)	; sona lili, scaled
 ("sona*lili" ?󿨟)	; sona lili, scaled
 ("sona-ma" ?󿨠)	; sona ma, scaled
 ("sona+ma" ?󿨠)	; sona ma, scaled
 ("sona*ma" ?󿨠)	; sona ma, scaled
 ("sona-nanpa" ?󿨡)	; sona nanpa, scaled
 ("sona+nanpa" ?󿨡)	; sona nanpa, scaled
 ("sona*nanpa" ?󿨡)	; sona nanpa, scaled
 ("sona-pona" ?󿨢)	; sona pona, scaled
 ("sona+pona" ?󿨢)	; sona pona, scaled
 ("sona*pona" ?󿨢)	; sona pona, scaled
 ("sona-sijelo" ?󿨣)	; sona sijelo, scaled
 ("sona+sijelo" ?󿨣)	; sona sijelo, scaled
 ("sona*sijelo" ?󿨣)	; sona sijelo, scaled
 ("sona-tenpo" ?󿨤)	; sona tenpo, scaled
 ("sona+tenpo" ?󿨤)	; sona tenpo, scaled
 ("sona*tenpo" ?󿨤)	; sona tenpo, scaled
 ("sona-toki" ?󿨥)	; sona toki, scaled
 ("sona+toki" ?󿨥)	; sona toki, scaled
 ("sona*toki" ?󿨥)	; sona toki, scaled
 ("sona-utala" ?󿨦)	; sona utala, scaled
 ("sona+utala" ?󿨦)	; sona utala, scaled
 ("sona*utala" ?󿨦)	; sona utala, scaled
 ("soweli-kijetesantakalu" ?󿴩)	; soweli kijetesantakalu, stacked
 ("soweli+kijetesantakalu" ?󿴩)	; soweli kijetesantakalu, stacked
 ("soweli^kijetesantakalu" ?󿴩)	; soweli kijetesantakalu, stacked
 ("supa-lape" ?󿨧)	; supa lape, stacked
 ("supa+lape" ?󿨧)	; supa lape, stacked
 ("supa^lape" ?󿨧)	; supa lape, stacked
 ("supa-lawa" ?󿨨)	; supa lawa, stacked
 ("supa+lawa" ?󿨨)	; supa lawa, stacked
 ("supa^lawa" ?󿨨)	; supa lawa, stacked
 ("supa-lupa" ?󿨩)	; supa lupa, stacked
 ("supa+lupa" ?󿨩)	; supa lupa, stacked
 ("supa^lupa" ?󿨩)	; supa lupa, stacked
 ("supa-moku" ?󿨪)	; supa moku, stacked
 ("supa+moku" ?󿨪)	; supa moku, stacked
 ("supa^moku" ?󿨪)	; supa moku, stacked
 ("supa-monsi" ?󿨫)	; supa monsi, stacked
 ("supa+monsi" ?󿨫)	; supa monsi, stacked
 ("supa^monsi" ?󿨫)	; supa monsi, stacked
 ("supa-pali" ?󿨬)	; supa pali, stacked
 ("supa+pali" ?󿨬)	; supa pali, stacked
 ("supa^pali" ?󿨬)	; supa pali, stacked
 ("tawa-pona" ?󿸆)	; tawa pona, stacked
 ("tawa+pona" ?󿸆)	; tawa pona, stacked
 ("tawa^pona" ?󿸆)	; tawa pona, stacked
 ("tawa-sona" ?󿸇)	; tawa sona, stacked
 ("tawa+sona" ?󿸇)	; tawa sona, stacked
 ("tawa^sona" ?󿸇)	; tawa sona, stacked
 ("telo-lete" ?󿨭)	; telo lete, scaled
 ("telo+lete" ?󿨭)	; telo lete, scaled
 ("telo*lete" ?󿨭)	; telo lete, scaled
 ("telo-lili" ?󿨮)	; telo lili, scaled
 ("telo+lili" ?󿨮)	; telo lili, scaled
 ("telo*lili" ?󿨮)	; telo lili, scaled
 ("telo-sitelen" ?󿴌)	; telo sitelen, scaled
 ("telo+sitelen" ?󿴌)	; telo sitelen, scaled
 ("telo*sitelen" ?󿴌)	; telo sitelen, scaled
 ("tenpo-ike" ?󿴬)	; tenpo ike, stacked
 ("tenpo+ike" ?󿴬)	; tenpo ike, stacked
 ("tenpo^ike" ?󿴬)	; tenpo ike, stacked
 ("tenpo-ni" ?󿴃)	; tenpo ni, stacked
 ("tenpo+ni" ?󿴃)	; tenpo ni, stacked
 ("tenpo^ni" ?󿴃)	; tenpo ni, stacked
 ("tenpo-pona" ?󿴭)	; tenpo pona, stacked
 ("tenpo+pona" ?󿴭)	; tenpo pona, stacked
 ("tenpo^pona" ?󿴭)	; tenpo pona, stacked
 ("toki-ala" ?󿨯)	; toki ala, scaled
 ("toki+ala" ?󿨯)	; toki ala, scaled
 ("toki*ala" ?󿨯)	; toki ala, scaled
 ("toki-ike" ?󿨰)	; toki ike, scaled
 ("toki+ike" ?󿨰)	; toki ike, scaled
 ("toki*ike" ?󿨰)	; toki ike, scaled
 ("toki-pona" ?󿨱)	; toki pona, scaled
 ("toki+pona" ?󿨱)	; toki pona, scaled
 ("toki*pona" ?󿨱)	; toki pona, scaled
 ("toki-sin" ?󿨲)	; toki sin, scaled
 ("toki+sin" ?󿨲)	; toki sin, scaled
 ("toki*sin" ?󿨲)	; toki sin, scaled
 ("toki-sona" ?󿨳)	; toki sona, scaled
 ("toki+sona" ?󿨳)	; toki sona, scaled
 ("toki*sona" ?󿨳)	; toki sona, scaled
 ("toki-utala" ?󿨴)	; toki utala, scaled
 ("toki+utala" ?󿨴)	; toki utala, scaled
 ("toki*utala" ?󿨴)	; toki utala, scaled
 ("tomo-lape" ?󿨵)	; tomo lape, scaled
 ("tomo+lape" ?󿨵)	; tomo lape, scaled
 ("tomo*lape" ?󿨵)	; tomo lape, scaled
 ("tomo-mani" ?󿨶)	; tomo mani, scaled
 ("tomo+mani" ?󿨶)	; tomo mani, scaled
 ("tomo*mani" ?󿨶)	; tomo mani, scaled
 ("tomo-moku" ?󿨷)	; tomo moku, scaled
 ("tomo+moku" ?󿨷)	; tomo moku, scaled
 ("tomo*moku" ?󿨷)	; tomo moku, scaled
 ("tomo-monsuta" ?󿨸)	; tomo monsuta, scaled
 ("tomo+monsuta" ?󿨸)	; tomo monsuta, scaled
 ("tomo*monsuta" ?󿨸)	; tomo monsuta, scaled
 ("tomo-nasin" ?󿨹)	; tomo nasin, scaled
 ("tomo+nasin" ?󿨹)	; tomo nasin, scaled
 ("tomo*nasin" ?󿨹)	; tomo nasin, scaled
 ("tomo-ni" ?󿴄)	; tomo ni, stacked
 ("tomo+ni" ?󿴄)	; tomo ni, stacked
 ("tomo^ni" ?󿴄)	; tomo ni, stacked
 ("tomo-pali" ?󿨺)	; tomo pali, scaled
 ("tomo+pali" ?󿨺)	; tomo pali, scaled
 ("tomo*pali" ?󿨺)	; tomo pali, scaled
 ("tomo-sona" ?󿨻)	; tomo sona, scaled
 ("tomo+sona" ?󿨻)	; tomo sona, scaled
 ("tomo*sona" ?󿨻)	; tomo sona, scaled
 ("tomo-tawa" ?󿨼)	; tomo tawa, scaled
 ("tomo+tawa" ?󿨼)	; tomo tawa, scaled
 ("tomo*tawa" ?󿨼)	; tomo tawa, scaled
 ("tomo-telo" ?󿸈)	; tomo telo, scaled
 ("tomo+telo" ?󿸈)	; tomo telo, scaled
 ("tomo*telo" ?󿸈)	; tomo telo, scaled
 ("tomo-unpa" ?󿨽)	; tomo unpa, scaled
 ("tomo+unpa" ?󿨽)	; tomo unpa, scaled
 ("tomo*unpa" ?󿨽)	; tomo unpa, scaled
 ("tomo-utala" ?󿨾)	; tomo utala, scaled
 ("tomo+utala" ?󿨾)	; tomo utala, scaled
 ("tomo*utala" ?󿨾)	; tomo utala, scaled
 ("tonsi-ike" ?󿯥)	; tonsi ike, scaled
 ("tonsi+ike" ?󿯥)	; tonsi ike, scaled
 ("tonsi*ike" ?󿯥)	; tonsi ike, scaled
 ("tonsi-lili" ?󿯦)	; tonsi lili, scaled
 ("tonsi+lili" ?󿯦)	; tonsi lili, scaled
 ("tonsi*lili" ?󿯦)	; tonsi lili, scaled
 ("tonsi-pona" ?󿯧)	; tonsi pona, scaled
 ("tonsi+pona" ?󿯧)	; tonsi pona, scaled
 ("tonsi*pona" ?󿯧)	; tonsi pona, scaled
 ("tonsi-sama" ?󿯨)	; tonsi sama, scaled
 ("tonsi+sama" ?󿯨)	; tonsi sama, scaled
 ("tonsi*sama" ?󿯨)	; tonsi sama, scaled
 ("tonsi-sin" ?󿯩)	; tonsi sin, scaled
 ("tonsi+sin" ?󿯩)	; tonsi sin, scaled
 ("tonsi*sin" ?󿯩)	; tonsi sin, scaled
 ("tonsi-unpa" ?󿯪)	; tonsi unpa, scaled
 ("tonsi+unpa" ?󿯪)	; tonsi unpa, scaled
 ("tonsi*unpa" ?󿯪)	; tonsi unpa, scaled
 ("tonsi-wawa" ?󿯫)	; tonsi wawa, scaled
 ("tonsi+wawa" ?󿯫)	; tonsi wawa, scaled
 ("tonsi*wawa" ?󿯫)	; tonsi wawa, scaled
 ("tu-luka" ?󿩅)	; tu luka, horizontal
 ("tu+luka" ?󿩅)	; tu luka, horizontal
 ("tu-tu" ?󿨿)	; tu tu, horizontal
 ("tu+tu" ?󿨿)	; tu tu, horizontal
 ("tu-wan" ?󿩀)	; tu wan, horizontal
 ("tu+wan" ?󿩀)	; tu wan, horizontal
 ("walo-jelo" ?󿴍)	; walo jelo, combined
 ("walo+jelo" ?󿴍)	; walo jelo, combined
 ("walo-laso" ?󿴎)	; walo laso, combined
 ("walo+laso" ?󿴎)	; walo laso, combined
 ("walo-loje" ?󿴏)	; walo loje, combined
 ("walo+loje" ?󿴏)	; walo loje, combined
 ("walo-pimeja" ?󿯬)	; walo pimeja, scaled
 ("walo+pimeja" ?󿯬)	; walo pimeja, scaled
 ("walo*pimeja" ?󿯬)	; walo pimeja, scaled
 ("wan-luka" ?󿩃)	; wan luka, horizontal
 ("wan+luka" ?󿩃)	; wan luka, horizontal
 ("wan-tu" ?󿩁)	; wan tu, horizontal
 ("wan+tu" ?󿩁)	; wan tu, horizontal
 ("wawa-tenpo" ?󿯭)	; wawa tenpo, scaled
 ("wawa+tenpo" ?󿯭)	; wawa tenpo, scaled
 ("wawa*tenpo" ?󿯭)	; wawa tenpo, scaled

                                        ; compounds of three or more words
                                        ; stacking and scaling joiners do not apply here
 ("ijo-ni-li-seme" ?󿯿)	; ijo ni li seme
 ("ijo+ni+li+seme" ?󿯿)	; ijo ni li seme
 ("luka-luka-luka" ?󿩏)	; luka luka luka
 ("luka+luka+luka" ?󿩏)	; luka luka luka
 ("luka-luka-luka-luka" ?󿵩)	; luka luka luka luka
 ("luka+luka+luka+luka" ?󿵩)	; luka luka luka luka
 ("luka-luka-luka-tu" ?󿯈)	; luka luka luka tu
 ("luka+luka+luka+tu" ?󿯈)	; luka luka luka tu
 ("luka-luka-luka-tu-tu" ?󿯉)	; luka luka luka tu tu
 ("luka+luka+luka+tu+tu" ?󿯉)	; luka luka luka tu tu
 ("luka-luka-luka-tu-wan" ?󿯊)	; luka luka luka tu wan
 ("luka+luka+luka+tu+wan" ?󿯊)	; luka luka luka tu wan
 ("luka-luka-luka-wan" ?󿯋)	; luka luka luka wan
 ("luka+luka+luka+wan" ?󿯋)	; luka luka luka wan
 ("luka-luka-luka-wan-tu" ?󿯌)	; luka luka luka wan tu
 ("luka+luka+luka+wan+tu" ?󿯌)	; luka luka luka wan tu
 ("luka-luka-tu" ?󿩋)	; luka luka tu
 ("luka+luka+tu" ?󿩋)	; luka luka tu
 ("luka-luka-tu-tu" ?󿩎)	; luka luka tu tu
 ("luka+luka+tu+tu" ?󿩎)	; luka luka tu tu
 ("luka-luka-tu-wan" ?󿩌)	; luka luka tu wan
 ("luka+luka+tu+wan" ?󿩌)	; luka luka tu wan
 ("luka-luka-wan" ?󿩊)	; luka luka wan
 ("luka+luka+wan" ?󿩊)	; luka luka wan
 ("luka-luka-wan-tu" ?󿩍)	; luka luka wan tu
 ("luka+luka+wan+tu" ?󿩍)	; luka luka wan tu
 ("luka-tu-tu" ?󿩈)	; luka tu tu
 ("luka+tu+tu" ?󿩈)	; luka tu tu
 ("luka-tu-wan" ?󿩆)	; luka tu wan
 ("luka+tu+wan" ?󿩆)	; luka tu wan
 ("luka-wan-tu" ?󿩇)	; luka wan tu
 ("luka+wan+tu" ?󿩇)	; luka wan tu

 ;; spaces
 (" " "") ; one space: end glyph (i.e. e suno, not esun o)
 ("  " ? ) ; two space: space is the place
 ("_" ?󱦒)
 ("Pi" ?󱦓)
 ("," ?󱦔)
 ;;;("^" ?󱦕)
 ;;;("*" ?󱦖)
;;; ("(" ?󱦗) ; hm
;;; (")" ?󱦘) ; hm
 ;; ( ?󱦙)
 ;; ( ?󱦚)
 ;; ( ?󱦛)
 ;; ( ?󱦞)
 ;; ( ?󱦟)
 )


;; TODO
;; - ?Similar control char manual input for other extended glyphs
;; - Word documentation precisely
;; - ?toki pona (?minor) mode
;;   - Properly format extended glyphs and inners
;;   - cartouches as parens (partially working)
;;     - (modify-syntax-entry ?󱦐 "(󱦑")
;;     - (modify-syntax-entry ?󱦑 ")󱦐")
;;   - Long pi phrases ?to use prefix syntax
;; - Word and glyph completion
;;   - ?Dictionary
;; - Unicode character description strings

;; magick convert -background none -fill black -font "~/.fonts/FairfaxPonaHD.ttf" -pointsize 300 label:"󱤲" mani.png
