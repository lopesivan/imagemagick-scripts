# imagemagick-scripts
Using imagemagick scripts like programs


## Examples

### File *example_1* :

```
  vector_head="path 'M 0,0  l -15,-5  +5,+5  -5,+5  +15,-5 z'"
    indicator="path 'M 10,0  l +15,+5  -5,-5  +5,-5  -15,+5  m +10,0 +20,0 '"

    convert -size 200x150 xc: \
            -draw "stroke black fill none  circle 10,10 11,11
                   push graphic-context
                     stroke blue fill skyblue
                     translate 10,10 rotate 90
                     line 0,0  100,0
                     translate 200,0
                     $vector_head
                   pop graphic-context
                   push graphic-context
                     stroke firebrick fill tomato
                     translate 20,50 rotate 40
                     $indicator
                     translate 40,0 rotate -40
                     stroke none fill firebrick
                     text 3,6 'Center'
                   pop graphic-context
                  " \
            a.png

  eog a.png
```

execution:
```
  bash example_1
```


### File *yellow* :

```
  color="rgb(255,255,0)"
  convert -respect-parenthesis \( -size 100x100 xc:"$color" \) \
  -background white -fill black -font Helvetica -pointsize 10 \
  label:"$color" -gravity south -append miff:- | convert - show:
```

### File *yellow2* :

```
  color="rgb(255,255,0)"
  convert -respect-parenthesis \( -size 100x100 xc:"$color" \) \
  -background white -fill black -font Helvetica -pointsize 10 \
  label:"$color" -gravity south -append show:

  color="rgb(255,255,0)"
  convert -respect-parenthesis \( -size 100x100 xc:"$color" \) \
  -background white -fill black -font Helvetica -pointsize 10 \
  label:"$color" -gravity south -append miff:- | convert - show:

  color="rgb(255,255,0)"
  convert -respect-parenthesis \( -size 100x100 xc:"$color" \) \
  -background white -fill black -font Helvetica -pointsize 10 \
  label:"$color" -gravity south -append miff:- | display -

  color="rgb(255,255,0)"
  convert -respect-parenthesis \( -size 100x100 xc:"$color" \) \
  -background white -fill black -font Helvetica -pointsize 10 \
  label:"$color" -gravity south -append tmp.png | convert tmp.png show:

  color="rgb(255,255,0)"
  convert -respect-parenthesis \( -size 100x100 xc:"$color" \) \
  -background white -fill black -font Helvetica -pointsize 10 \
  label:"$color" -gravity south -append -type truecolor show:
```


### File *yellow3* :
```
  convert -size 128x128 xc:black -fill white -draw "point 64,64" -alpha off -blur 0x8 -contrast-stretch 0 -negate gaussian8_neg.png
```
