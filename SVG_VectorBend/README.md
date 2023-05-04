# //Vector Bending

[![Furby Organ Example](https://github.com/badalmer/Generative-Painting/blob/main/SVG_VectorBend/images/lmnc%20-%20furbies.jpg)](https://www.youtube.com/watch?v=GYLBjScgb7o)

Circuit bending is the act of interrupting electrical connections using various switches, potentiometers, or even just a few static resistors. By doing this, the user is able to modulate the electrical signals passing through the circuit. In practice, usually in audio applications this can result in strange drone-like sounds. In 2018 [Youtuber Sam Battle or Look Mum No Computer](https://www.youtube.com/watch?v=GYLBjScgb7o) took this to an extreme with the creation of “The Furby Organ''. Housed in a traditionally oak finished electric organ composed of 44 furbys each with the ability to be keyed to a different octave. With the flick of the “collective awakening switch”, the furbys all spring to life in unison. Their eyes start to blink, their furry groans of 90’s nostalgia begin to sync. A looping-freeze button sustains them into an endless tone - reminiscent of the jarring sound of a computer program freezing. The guts of the machine are a nest of wires and terminal strips connected to each Furby’s PCB board.

Oddly enough, this idea of bending signals can be applied to digital applications as well. Digital images or video are composed of data. Opening a .jpeg into a text editor results in a seemingly incomprehensible series of characters. By modifying this text even a little results in a jpeg with large sections of recolored areas of the image. Modifying this text significantly might result in the image being corrupted.

```
IHDR  (  ž   ¾vúp   sRGB ®Îé    IDATx^ì½i“$Ç•$¨~{ÜyÖ£  	²§wfšóaöÿ‹ì×mö4I udefÜ‡ß¾¢jæ‘Q™Y Av½‘”¼âðÃÌžš>}úÇÔµëcôì}€Ä‰P¸!Ü0 &I!\TðP AópQ;jÇEmÿâ pj€ßï|Øÿßûœ½»u§ÌÐ‹CTYŠÅtŒÙõŠd2O †[V¨Š¥ãÀ	¤eøâVq·/
QÙ¬ks´ÛïúÍA}ã¨u&÷Åö<_×9|.?Ã^ÇüÔ\£ÛÞôÝ×ß|–ãþ°cùA|ø$Ýs„ÎÁy¸Žk®UQ .*¤ë
6‹%ª$Cèùè¶ÚèuHÖÊ¢B]—¨ªŽË÷ªõ=@‰ Ý Þ,Pd
Ã _ú~õâD¨põö%>>AV&˜/˜-—¨jÀBdEŽÅbŽt3Gìy8êöqÜéã¼w„Ü¼D‘ep¾ï¡F¼,à…>¢VŒ²ª°\.‘â8†ë¹ÈŠ›dƒåzÙbŽë4AÚëaíù¨9Î[üùí%®—k¬Ë
uØAu‘—.œÊEà†p*yZ¡.~€ª*‘®×@Q
```
>**example of a .jpeg file opened in a text editor*

[.SVG files [vectors], opposed to .JPEG files [rasters]](https://en.wikipedia.org/wiki/Vector_graphics), are based on XML and are human readable when opened in a text editor. Looking closely at the code that makes up an .SVG file we’re able to recognize recurring syntax. The **"Fill"** for instance refers to the colors used in the vector file. **“Path”** refers to the specific node handles that make up each vector shape. Vectors are simply shapes determined by points. Similar to a connect the dots puzzle. Each “node” represents a dot, with the string of numbers corresponding to where these nodes exist on the virtual canvas. Since vectors rely on geometry rather than pixels, they are infinitely scalable. There are no low quality images, simply shapes and paths. A vector could be scaled from the size of a piece of paper to the side of a building. 

```
<style type="text/css">
	.st0{fill:#7BA0CD;}
	.st1{fill:#F2E6C8;}
 </style>
 <g>
	<g>
		<path class="st0" d="M677.3,261.8c26.5,0,53,0,79.5,0c0,9.8,0,19.5,0,29.3c-4.7,0-9.4,0-14.1,0c0,0.9,0,1.5,0,2.5
	c3.7-1.2,7.2,1.3,10.7-0.2c0.3-0.1,0.8,0.4,1.3,0.4c0.7,0.1,1.4,0.2,2.1,0.3c0,0.5,0,1,0,1.5c-2.2,0-4.4,0-6.6,0
			c-0.3,0-0.6,0.5-0.9,0.7c-0.5,0-1,0-1.5,0c-0.3-0.3-0.5-0.5-0.8-0.8c-0.7,0-1.4-0.1-2.1,0c-0.3,0.1-0.6,0.5-0.9**
```
>**example of a .svg file opened with notepad*				     
				     
Hypothetically, if given the correct information - any image could be created. This might be humanly impossible, however since vectors are a lot more human readable this feels a little easier. By modifying existing node handles we can visualize change within the file. By automating this process, a dataset could be applied and the changes could be generative and more quickly recognized. For the purposes of this text I will be using the programming language [Processing](https://processing.org/download/). Initiated in 2001 by Casey Reas and Benjamin Fry, Processing is an open-source programming language for artists. Tutorials can be found [here](https://processing.org/tutorials/). I will be assuming you’ve familiarized yourself with a bit of its concepts for this next part.

***
## The Code

https://github.com/badalmer/Generative-Painting/blob/e8becddbb723e6477d1beb5c5aa97f0a389368fa/SVG_VectorBend/SVG_VectorBend.pde#L1-L82

***
**Global Settings**

[*numCopy*](https://github.com/badalmer/Generative-Painting/blob/5bee838fa1bce13befae92b5a9f31e4a35a75e15/SVG_VectorBend/SVG_VectorBend.pde#L15) - the number of output files we ultimately want. Be careful with this number. 

[*corLevel*](https://github.com/badalmer/Generative-Painting/blob/5bee838fa1bce13befae92b5a9f31e4a35a75e15/SVG_VectorBend/SVG_VectorBend.pde#L16) - the corruption level. The higher the number the more extreme the bend. I keep this below 10,000.

[*colorRefresh*](https://github.com/badalmer/Generative-Painting/blob/5bee838fa1bce13befae92b5a9f31e4a35a75e15/SVG_VectorBend/SVG_VectorBend.pde#L17) - true or false, this allows the program to grab new colors for each file. Some colors might be picked more than once.

[*colorNum*](https://github.com/badalmer/Generative-Painting/blob/5bee838fa1bce13befae92b5a9f31e4a35a75e15/SVG_VectorBend/SVG_VectorBend.pde#L18) - how many colors we might want. Maximum is 16.

***
**Draw**

This is where the magic happens. This program is essentially translating a vector file into a String, or series of characters. It skips the first 30 lines of the selected file in order to prevent corruption. Then, based on the value of [*corLevel*](https://github.com/badalmer/Generative-Painting/blob/5bee838fa1bce13befae92b5a9f31e4a35a75e15/SVG_VectorBend/SVG_VectorBend.pde#L16), cycles through each character looking for a random number (between 10 and 150). Once found, it then replaces this number with another number (between 0 and 500). This section can be modified however, I’ve found an aesthetic sweet spot here.

***
**Recolor**

Before outputting a file. The program will replace the original color data or the **fill** section of the file with a new color. These new colors are pulled from a list, taken from the [16 unique colors of the Commodore 64 system](https://www.c64-wiki.com/wiki/Color). A nostalgic source of computing for me.

https://github.com/badalmer/Generative-Painting/blob/5bee838fa1bce13befae92b5a9f31e4a35a75e15/SVG_VectorBend/SVG_VectorBend.pde#L84-L107

We can simply drag and drop a .SVG image into the sketch and start getting some outputs. Let's start with this image.

![original image](https://github.com/badalmer/Generative-Painting/blob/main/SVG_VectorBend/images/cloud02.jpg)
>**Original Image*

The new file is then saved in the sketch folder of the program. Here are some examples:

![example 01](https://github.com/badalmer/Generative-Painting/blob/main/SVG_VectorBend/images/BEND-12023_102.png)
>**Example Output 01*

![example 02](https://github.com/badalmer/Generative-Painting/blob/main/SVG_VectorBend/images/BEND-12023_257.png)
>**Example Output 02*

![example 03](https://github.com/badalmer/Generative-Painting/blob/main/SVG_VectorBend/images/BEND-12023_745.png)
>**Example Output 03*
