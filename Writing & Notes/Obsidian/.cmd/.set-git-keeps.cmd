@echo off
setlocal
chcp 65001 >nul

echo Удаление старых .gitkeep файлов...
powershell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0.powershell\remove-gitkeeps.ps1'"
if %ERRORLEVEL% neq 0 goto :error

echo Добавление новых .gitkeep файлов...
powershell -NoProfile -ExecutionPolicy Bypass -Command "& '%~dp0.powershell\add-gitkeeps-empty-folders.ps1'"
if %ERRORLEVEL% neq 0 goto :error

echo Все операции успешно завершены
goto :end

:error
echo Произошла ошибка при выполнении операции
pause
exit /b 1

:end
pause
endlocal
