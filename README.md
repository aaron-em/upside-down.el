upside-down.el
==============

ɔⵑƃɐɯ uoⵑsɹǝʌuⵑ ʇxǝʇ

Copyright (C) 2013 Aaron Miller. All rights reversed.
Share and Enjoy!

Last revision: Thursday, December 26, 2013, ca. 06:30.

Author: Aaron Miller <me@aaron-miller.me>

Commentary
----------

Websites such as [FileFormat.info's Unicode Upside-Down Converter][CONV]
establish a mapping between a range of Unicode characters
(usually alphanumerics and a selected set of punctuation) and
characters which resemble their upside-down versions, and use it to
transform a given string of text into its visually inverted
version. I saw no reason not to do something similar in
Emacs. This is that thing.

To use this code, drop this file into your Emacs load path, then
(require 'upside-down). The library defines two functions:
'upside-down-invert-string', which takes a string argument and
returns the upside-down version, and 'upside-down-replace-region',
which applies that transformation to the active region, and which
can be called interactively. Also defined is the variable
`upside-down-mapping', which contains an alist mapping characters
with their upside-down versions, in case you have some other use
for that.

Possibly of interest is that the transform implemented by
'upside-down-invert-string' is its own inverse, such that
`(string= "string"
         (upside-down-invert-string
          (upside-down-invert-string
           "string")))`
evaluates to `T`.

Bugs/TODO
---------

Some of the digits are mapped poorly, 5 in particular.

Acknowledgements
----------------

Much of the mapping defined in this library comes from
[FileFormat.info's converter][CONV], with significant improvements
made possible by
[Shapecatcher.com's Unicode character recognition service][SHAPE],
which takes a hand-drawn representation of the character you want and
finds the most visually similar among its database of ca. 12000
characters.

Miscellany
----------

The canonical version of this file is hosted in [my Github
repository][REPO]. If you didn't get it from there, great! I'm
happy to hear my humble efforts have achieved wide enough interest
to result in a fork hosted somewhere else. I'd be obliged if you'd
drop me a line to let me know about it.

[CONV]: http://www.fileformat.info/convert/text/upside-down.htm
[REPO]: https://github.com/aaron-em/upside-down.el
[SHAPE]: http://shapecatcher.com
