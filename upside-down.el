;;; upside-down.el --- ɔⵑƃɐɯ uoⵑsɹǝʌuⵑ ʇxǝʇ

;; Copyright (C) 2013 Aaron Miller. All rights reversed.
;; Share and Enjoy!

;; Last revision: Thursday, December 26, 2013, ca. 06:30.

;; Author: Aaron Miller <me@aaron-miller.me>

;; This file is not part of Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation; either version 2, or (at your
;; option) any later version.

;; This file is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see `http://www.gnu.org/licenses'.

;;; Commentary:

;; Websites such as FileFormat.info's Unicode Upside-Down Converter
;; [CONV] establish a mapping between a range of Unicode characters
;; (usually alphanumerics and a selected set of punctuation) and
;; characters which resemble their upside-down versions, and use it to
;; transform a given string of text into its visually inverted
;; version. I saw no reason not to do something similar in
;; Emacs. This is that thing.

;; To use this code, drop this file into your Emacs load path, then
;; (require 'upside-down). The library defines two functions:
;; `upside-down-invert-string', which takes a string argument and
;; returns the upside-down version, and `upside-down-replace-region',
;; which applies that transformation to the active region, and which
;; can be called interactively. Also defined is the variable
;; `upside-down-mapping', which contains an alist mapping characters
;; with their upside-down versions, in case you have some other use
;; for that.

;; Possibly of interest is that the transform implemented by
;; `upside-down-invert-string' is its own inverse, such that
;; (string= "string"
;;          (upside-down-invert-string
;;           (upside-down-invert-string
;;            "string")))
;; evaluates to T.

;;; Bugs/TODO:

;; Some of the digits are mapped poorly, 5 in particular.

;;; Acknowledgements:

;; Much of the mapping defined in this library comes from
;; FileFormat.info's converter [CONV], with significant improvements
;; made possible by Shapecatcher.com's Unicode character recognition
;; service [SHAPE], which takes a hand-drawn representation of the
;; character you want and finds the most visually similar among its
;; database of ca. 12000 characters.

;;; Miscellany:

;; The canonical version of this file is hosted in my Github
;; repository [REPO]. If you didn't get it from there, great! I'm
;; happy to hear my humble efforts have achieved wide enough interest
;; to result in a fork hosted somewhere else. I'd be obliged if you'd
;; drop me a line to let me know about it.

;; [CONV]: http://www.fileformat.info/convert/text/upside-down.htm
;; [REPO]: https://github.com/aaron-em/upside-down.el
;; [SHAPE]: http://shapecatcher.com

(defvar upside-down-mapping
  '(; quotes
    ("\"" . "„") ("'" . ",")
    ; brackets and braces
    ("(" . ")") (")" . "(") ("[" . "]") ("]" . "[")
    ("{" . "}") ("}" . "{") ("<" . ">") (">" . "<")
    ; punctuation
    ("." . "˙") ("_" . "‾") ("&" . "⅋") ("!" . "¡")
    (";" . "؛") ("?" . "¿") ("-" . "-") ("," . "'")
    ; majuscules
    ("A" . "∀") ("B" . "ჵ") ("C" . "Ↄ") ("D" . "ᗡ")
    ("E" . "Ǝ") ("F" . "Ⅎ") ("G" . "⅁") ("H" . "H")
    ("I" . "I") ("J" . "ᒋ") ("K" . "ʞ") ("L" . "⅂")
    ("M" . "ꟽ") ("N" . "И") ("O" . "O") ("P" . "Ԁ")
    ("Q" . "Ό") ("R" . "ᴚ") ("S" . "S") ("T" . "⊥")
    ("U" . "∩") ("V" . "ᴧ") ("W" . "M") ("X" . "X")
    ("Y" . "⅄") ("Z" . "Z")
    ; minuscules
    ("a" . "ɐ") ("b" . "q") ("c" . "ɔ") ("d" . "p")
    ("e" . "ǝ") ("f" . "ɟ") ("g" . "ƃ") ("h" . "ɥ")
    ("i" . "ⵑ") ("j" . "ṛ") ("k" . "ʞ") ("l" . "ʃ")
    ("m" . "ɯ") ("n" . "u") ("o" . "o") ("p" . "d")
    ("q" . "b") ("r" . "ɹ") ("s" . "s") ("t" . "ʇ")
    ("u" . "n") ("v" . "ʌ") ("w" . "ʍ") ("x" . "x")
    ("y" . "ʎ") ("z" . "z")
    ; digits
    ("0" . "0") ("1" . "⥝") ("2" . "ⵒ") ("3" . "Ɛ")
    ("4" . "ᔭ") ("5" . "Ϛ") ("6" . "9") ("7" . "∠")
    ("8" . "8") ("9" . "6"))
  "A mapping between Unicode characters and their upside-down
equivalents.")

(defun upside-down-invert-string (string)
  "Return the inverted version of STRING. This transformation is
its own inverse; performing it twice on the same region will
leave the original text unchanged."
  (let ((bits (split-string string "" t)))
    (mapconcat
     #'(lambda (s)
         (let ((inv   (cdr (assoc s  upside-down-mapping)))
               (uninv (car (rassoc s upside-down-mapping))))
           (cond
            (inv inv)
            (uninv uninv)
            (t s))))
     (reverse bits)
     "")))

(defun upside-down-replace-region (begin end)
  "Invert a span of text. When called interactively, use the
current region, or do nothing; otherwise, use the range of text
bounded by BEGIN and END."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (let ((region
         (buffer-substring-no-properties begin end)))
    (if (and begin end)
        (progn
          (delete-region begin end)
          (insert (upside-down-invert-string region))))))

(provide 'upside-down)
