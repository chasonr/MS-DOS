@echo off
cd %1
set INCLUDE=\src\tools\bld\inc
\src\tools\cl -c -AS -Od -Zp -I. -I\src\h -Fo%3 %2
