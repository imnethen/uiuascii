# uiuascii
[Acerola's ascii art algorithm](https://www.youtube.com/watch?v=gg40RWiaHRY) implemented in [uiua](https://uiua.org)

---
# Usage
uiuascii wouldnt work well in pad so you have to run it locally:

- install [uiua](https://www.uiua.org/install)
- clone this repo (and cd into the folder):
```
$ git clone https://github.com/imnethen/uiuascii
$ cd uiuascii
```
- run the program:
```
$ uiua run main.ua [input] [output]
```

The program accepts up to 2 arguments:
- input. the path to the input file. if not provided, default to Lena
- output. the path to the output file. if not provided, try to render to terminal

Note that you cant have an output file without input because i dont think theres an easy way to properly parse arguments in uiua so input is just the first arg and output is the second

Also you have to be in the uiuascii folder when running it because it cant find the resources folder otherwise

# BAD APPLE
https://www.youtube.com/watch?v=fD3MQzcSHtk
(a bit broken by youtube compression)
