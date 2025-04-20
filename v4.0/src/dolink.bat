@echo off
cd %1
set LIB=\src\tools\bld\lib
\src\tools\link %2 %3 %4 %5 %6 %7 %8 %9
