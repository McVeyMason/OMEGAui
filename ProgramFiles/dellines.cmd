@echo off
::startstring is the string that starts the deletion 
::endstring is the string that ends the deletion
::infile is the file that is the target
::outfile is the file that is that output
::this script requires sed

sed "/%startstring%/,/%endstring%/d" %infile% > %outfile%
pause