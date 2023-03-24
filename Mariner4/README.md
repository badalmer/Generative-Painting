# // Mariner 4

I’ve always been very interested in space. Growing up I would crawl libraries for interesting texts about the universe. Mostly for the artist renderings of far off worlds. When I first stumbled upon the Mariner 4 drawing done by the NASA/JPL team I found a connection to digital images and art that I never had put together before. This led me down the rabbit hole in terms of all this research. What better place to start than by reverse engineering what I believe the image compression was doing back in 1964.

https://github.com/badalmer/Studio/blob/0895df8767120627e12e1a6d015efc3a0584a38d/images/First_Image_Coloring.jpg

https://github.com/badalmer/Generative-Painting/blob/af9eb12cf02856c34961d5ffc777b0674b7470d7/Mariner4/Mariner%204.pde#L1-L53

***
**Global**

[*code*](https://github.com/badalmer/Generative-Painting/blob/1161948cf8b4a27d7487b959a95081662a1d2804/Mariner4/Mariner%204.pde#L10) - this will act as the output number used to calculate brightness of each pixel. 0 meaning black, 255 meaning white.

[*file*](https://github.com/badalmer/Generative-Painting/blob/1161948cf8b4a27d7487b959a95081662a1d2804/Mariner4/Mariner%204.pde#L9) - this program uses the drop library. A file can be any size, however since we’re going pixel by pixel here a very low dpi image should be used. An example being an image no larger than 82 pixels by 110 pixels. 

***
**Draw**

This program loads our file as a set of pixels. One by one it will cycle through its color value, i.e (RGB) 255, 0, 0 for pure red. After grabbing these values it will then average them. 

> (Red + Green + Blue) / 3 = average value

These values are then recorded before moving on to the next pixel. Once completed, our values are turned back into a text document which gets saved. The smaller the image used the faster the process. This program is almost instantaneous. The new file is then saved in the sketch folder of the program. Here are some examples:
