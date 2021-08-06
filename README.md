# flux-file-converter
### Code and instructions for converting a FluxMed .flux file to .csv format.

The following code was developed in an effort to streamline the .flux to .csv file conversion process, allowing for multiple files to be converted at once without opening them individually in FluxReview. It was first coded in Matlab (matlab-fluxconvert.m) and then in Octave (fluxconvert.m, the preferred version). Though Octave is a free alternative to Matlab and is therefore very similar, the two are not identical, and certain modifications had to be made. These include:
* using the fprintf() function to write data to the output file instead of the writematrix() function
* avoiding instances of the string() function as this is not yet implemented in Octave.

The program can be launched by opening and running it in Octave, or in command line with the following prompt:
```sh
octave fluxconvert.m
```
A window will pop up allowing the user to browse through their computer and select the .flux file(s) they'd like to convert. (Note that it may take several minutes to convert them all, depending on the number of files selected and the amount of data within them.)
