@echo off
chcp 65001 >nul

echo Инициализация плагинов
powershell -ExecutionPolicy Bypass -File "%~dp0.powershell\plugin-init.ps1"