@echo off
cd %1
set INCLUDE=\src\tools\bld\inc
\src\tools\cl -c -AS -Os -Zp -I. -I\src\h -D__cdecl= -Fo%3 %2
