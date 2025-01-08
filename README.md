# sitelen-el

A way to enter sitelen pona (toki pona) glyphs in emacs, but not an ideal way.

For now, the result is an input method that inputs sitelen pona unicode glyphs as you type ASCII characters. There are many improvements to be made.

## Setup

Read on for stepwise instruction. If you just want the input method then look at `toki-pona.el`. In short:
1. Install the font
2. Map unicode blocks
3. Define and use the input method

### 1: Install the font

I have only tested this with [Fairfax Pona HD](https://www.kreativekorp.com/software/fonts/fairfaxponahd/). The website gives a good account of the font's features, not all of which will work just now. The rest of these instructions are emacs-specific, so install the font on your system and let's go already.

### 2: Map unicode blocks

Enable unicode fonts. For instance, if you use `use-package` then you can add this line in `init.el`:

    (use-package unicode-fonts)

sitelen pona does not have its own unicode block. For more on that story, see [sona.pona.la](https://sona.pona.la/wiki/Unicode). By convention, sitelen pona glyphs map onto specific code points in two so called Private Use Areas. So we need to tell emacs to use unicode characters from Fairfax Pona HD (only) when it needs to enter a character whose code point is in one of those two ranges. For instance, add to `init.el`:

    (set-fontset-font t '(#xe000 . #xf8ff) "Fairfax Pona HD")
    (set-fontset-font t '(#xf0000 . #x10ffff) "Fairfax Pona HD")
    
A handy visualisation of the glyph to unicode code point mappings is on this [lipu-sona.pona.la gif](https://lipu-sona.pona.la/sitelen_ucsur.gif).

If you've evaled those lines then trying to enter a code point from that table into any buffer should show a sitelen pona glyph. For instance <kbd>C-x 8 RET F1932 RET</kbd> and be rewarded with the glyph for ![mani](./doc/mani.png).

### 3: Define the input method

Eval `toki-pona.el` to load the emacs quail input rules that enter sitelen pona when you type ASCII characters. For instance, to load it when emacs starts, clone the git repo and load it from `init.el`:

    (load "~/PATH-TO-GIT-REPO/toki-pona.el")

`toki-pona.el` also defines a function `my/quailify` that I used to derive the many ASCII->unicode rule mappings from the Opentype font feature (`.fea`) file.

## Usage

<kbd>C-\</kbd> (`toggle-input-method`) and select `toki pona`. I've only tested this with an english keyboard layout. Repeat to toggle back.

ASCII to sitelen pona mappings are like those describes in Fairfax Pona HD features, with some additions:
- single space ends current glyph entry (if necessary)
  - so <kbd>e suno</kbd> gives ![e suno](./doc/e_suno.png), and <kbd>esun o</kbd> ![esun o](./doc/esun_o.png)
- double space is mapped to a single space character
- underscore _ places the preceding glyph between horizontal cartouche lines
  - square brackets enclose the cartouche
  - <kbd>[jan_pona_]</kbd> ![jan pona in a cartouche](./doc/janPona.png)
- <kbd>Pi</kbd> starts extended pi
  - comma , places preceding glyph onto Pi extension line
  - <kbd>tomo Pi telo,nasa,</kbd> ![tomo pi telo nasa with extended pi](./doc/tomoPiTeloNasa.png)
- all ASCII transliterations work; see the font features or the quail rules in `toki-pona.el` for fun like:
  - <kbd>kijtesantakalu</kbd> ![kijetesantakalu](./doc/kijetesantakalu.png)
  - combined glyphs with all joiners
    - zero-width <kbd>kala-lili</kbd> ![kala lili with zero-width joiner](./doc/kalaLiliZero.png)
    - stacked <kbd>kala^lili</kbd> ![kala lili with stacked joiner](./doc/kalaLiliStacked.png)
    - scale <kbd>kala*lili</kbd> ![kala lili with scale joiner](./doc/kalaLiliScale.png)
    
## Background

This is based on a discouraged method [described by Fairfax fonts' creators](https://www.kreativekorp.com/ucsur/charts/sitelen.html), after I failed to get Opentype features working automatically in emacs. A possibly related issue is discussed here on [stackexchange](https://emacs.stackexchange.com/a/61981).

In support of future goals, I looked at treating extended glyphs as syntactical enclosures, so for instance having cartouches behave like parens. The first step is modifying the syntax table:
    (modify-syntax-entry ?󱦐 "(󱦑")
    (modify-syntax-entry ?󱦑 ")󱦐")

## TODO

- [ ] Control char manual input for other extended glyphs (a la cartouche, extended pi)
- [ ] ?toki pona mode
  - [ ] Properly format extended glyphs and inners (?ligatures)
  - [ ] Cartouches as parens (partial progress using syntax table)
  - [ ] Long Pi phrases as ?prefix syntax
- [ ] Completion, e.g. glyphs
  - [ ] ?Dictionary
- [ ] ?Recognition of grammatical structures, hinting like in programming modes
- [ ] Unicode character description strings (e.g. currently no completion for UCSUR `insert-char`)
- [ ] Additional abbreviated input methods

## Credit

This is almost entirely based on resources in Fairfax HD etc. fonts, and the existing emacs quail input method.

Thank you for reading!
