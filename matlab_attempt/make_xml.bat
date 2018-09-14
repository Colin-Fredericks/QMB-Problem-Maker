@echo off
REM "bunnies" is my anaconda environment for python. Pipe the output to nul
call activate bunnies > nul
python convertXLSXtoXML.py "Processed excel problems" -sf
call deactivate > nul
