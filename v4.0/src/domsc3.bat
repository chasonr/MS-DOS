@echo off
cd %1
set INCLUDE=\src\tools\bld\inc
\src\tools\cl -c -ASw -G2 -Oat -Gs -Ze -Zl -Fc -I. -I\src\h -Fo%3 %2
