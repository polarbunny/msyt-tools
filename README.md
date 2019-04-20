msyt-tools
==========
Author: `polarbunny`

A toolset for working with BotW dialogue files via msyt.

*Requires **Python 3.6+ 64bit**, **sarc** and **rstb***

 Thanks to `Kyle Clemens (jkcclemens)`!

Usage:
------
See - [notes.txt](../master/docs/notes.txt) - Also included in `docs` folder in download.

PDF Guide for Beginners / Visual Learners:
------------------------------------------
See - [msyt-tools-guide-v4.pdf](../master/docs/msyt-tools-guide-v4.pdf) - Also included in `docs` folder in download.

Download:
---------
Latest - [here](https://github.com/polarbunny/msyt-tools/releases/latest)

FAQ:
----
- *"What benefits does* `msyt` *have over MSBT Editor Reloaded, Kuriimu, or* `.xmsbt`?"

  1. Instead of being a full fledged editor, `msyt` is simply a tool for converting BotW `msbt` files to and from a `yaml` format. This allows for easy and efficient editing using whatever method is most comfortable to the user.

   2. Additionally, `msyt` also converts (known) BotW dialogue control codes into an easy to modify `yaml` representation.

      **TL;DR:** No more hex editing.

- *"What does* `msyt` *mean?"*
  -  `msbt` is assumed to be an acronym for `Message Standard Binary Table`, so in the same respect, `msyt` stands for `Message Standard Yaml Table`.

 - *"Awh, geez.. EVERY time I open* `notepad++`*, my \*FAVORITE\* editor, I have to manually set the language to* `yaml`*. I want pretty colors by default!"*
 
   - Don't fear, there's a simple solution!
     1. In `notepad++`, select `Settings -> Style Configurator...`
     2. In the `Language` box, find and select `YAML` from the list.
     3. Under `User ext.`, type `msyt`

Tools utilized:
---------------
msyt - https://gitlab.com/jkcclemens/msyt/
  
7z - https://www.7-zip.org/

curl - https://github.com/curl/curl
