@echo off
chcp 65001 >nul
setlocal
echo [1/4] build from config...
cd /d D:\Hermes\work\jobfolio
python tools\glassgen.py configs\linche.json out\linche-onefile.html --assets inline --embed-model || goto :err

echo [2/4] copy to publish dir...
copy /y out\linche-onefile.html D:\Hermes\work\publish\glass-hero\index.html >nul || goto :err

echo [3/4] commit...
cd /d D:\Hermes\work\publish\glass-hero
git add -A
git -c user.name="8-321" -c user.email="8-321@users.noreply.github.com" commit -m "update hero" 2>nul || echo    no changes

echo [4/4] push (Pages rebuilds in ~1 min)...
git push || goto :err
echo.
echo DONE  -^>  https://8-321.github.io/glass-hero/
pause
exit /b 0

:err
echo.
echo FAILED at step above. Read the message, fix, run again.
pause
exit /b 1
