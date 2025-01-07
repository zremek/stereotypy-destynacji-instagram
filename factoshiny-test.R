# https://www.r-bloggers.com/2020/03/all-you-need-to-know-to-analyse-a-survey-with-mca/ 


install.packages("Factoshiny")
library(Factoshiny)


# Error: package or namespace load failed for ‘Factoshiny’:
#   .onLoad failed in loadNamespace() for 'tcltk', details:
#   call: dyn.load(file, DLLpath = DLLpath, ...)
# error: unable to load shared object '/Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/library/tcltk/libs/tcltk.so':
#   dlopen(/Library/Frameworks/R.framework/Versions/4.3-x86_64/Resources/library/tcltk/libs/tcltk.so, 10): Library not loaded: /opt/X11/lib/libfreetype.6.dylib
# Referenced from: /opt/R/x86_64/lib/libtk8.6.dylib
# Reason: Incompatible library version: libtk8.6.dylib requires version 25.0.0 or later, but libfreetype.6.dylib provides version 24.0.0
# > 



data(tea)
result <- Factoshiny(tea)
