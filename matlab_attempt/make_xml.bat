@echo off
REM "bunnies" is my anaconda environment for python. Pipe the output to nul
call activate bunnies > nul
python convertXLSXtoXML.py "Filled-in Excel files" -sf
call deactivate > nul
