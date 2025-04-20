@echo off
cd %1
\src\tools\masm -Mx -t -I. -I\src\inc -I\src\dos %4 %5 %6 %7 %8 %9 %2,%3;
