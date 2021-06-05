# graph
A program for quick evaluation of performance of Transd programming language.

This little program written on Transd generates a graph of a user provided shading function, that is a function which for each pair (x, y) of image coordinates (in other words, for each image pixel) returns a number describing the color with which that pixel should be filled. This means, that for generating a 1000x1000 image the shading function will be called 1 million times.

#### How to use

For running the program a Transd command line interpreter is necessary. It can be downloaded here: 

[Command line interpreter for Transd](https://github.com/transd-lang/frend)

The program is launched from the command line with the following syntax:

```
<frend> <graph.td>
```

`<frend>` is the full path to the FREND command line interpreter, and `<graph.td>`
is the full path to the "graph.td" file from this repository.

Before running the program, the user should open the `graph.td` file in any text editor and assign the desired values to the variables in the "Export" module. These variables are:

* height: the number containing the image height in pixels;
* width: the number containing the image width in pixels;
* fileName: the name of the image file where the rendered image will be written. This file name must end with '.ppm' file extension.

Note, that `height` and `width` define the number of pixels in the image and therefore how many times the shading function is called during the program run. This number is obtained by multiplying `height` on `width`.

The image is written to a file in PPM format, which can be viewed in many graphic viewers. It also can be opened with LibreOffice Draw application.

The program has a default shading function which can be used for the performance test. The default function will generate the graph of the quadratic math function: f(x) = x^2. 

The shading function need not necessarily be a math function with one value per each x-coordinate. This can be any routine that sets on each call three bytes in the pixel vector with RGB values from 0 to 255. The shading function can, for example, render graphs of several different math functions simultaneously.

#### How the program works

Apart from demonstrating the language performance, the program provides a quick glance
on the Transd language, its syntax and program structure.

Transd programs are composed of modules, which can be defined in one or in many source files. The 'graph' program containes two modules: 'Export' and 'MainModule', and one class 'Quad'.

The 'Export' module serves as a configuration interface of the program. The user, or other program that has Transd embedded, can read and change the members of that module.

The 'MainModule' module controls the main logic of program execution. The whole run of the program is done within the `_start()` function. It sets up the inner program variables based on the values in the 'Export' module, creates a byte array as the container for image pixels and then repeatedly calls the shading function for filling that array with color values for each pixel.

The default shading function is defined as the 'shade()' method of the 'Quad' class (this function is the math quadratic function f(x) = x^2 and its graph is a parabola). The 'MainModule' instantiates an object of this class in the `_start()` function and then uses it by calling its 'shade()' method.

After the pixel array is filled, it's written to a file as a PPM image.
