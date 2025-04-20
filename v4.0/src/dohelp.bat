@echo off
cd %1
attrib -R %3
\src\tools\asc2hlp %2 %3
