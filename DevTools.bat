@echo off
chcp 65001 >nul
title 개발 도구 설치 스크립트

echo ===================================
echo   winget 설치 여부 확인 중...
echo ===================================

where winget >nul 2>nul
if errorlevel 1 (
    echo winget이 설치되어 있지 않습니다. 설치를 진행합니다...
    powershell -NoProfile -Command "Invoke-RestMethod 'https://aka.ms/getwinget' -OutFile '%TEMP%\winget.msixbundle'"
    if errorlevel 1 (
        echo winget installation file download failed.
        pause
        exit /b 1
    )

    powershell -NoProfile -Command "Add-AppxPackage -Path '%TEMP%\winget.msixbundle'"
    if errorlevel 1 (
        echo winget installation failed.
        pause
        exit /b 1
    )
    
    winget --version >nul 2>nul
    if errorlevel 1 (
        echo winget 설치에 실패했습니다. 수동 설치가 필요합니다.
        echo Microsoft Store에서 "앱 설치 관리자"를 검색해 설치해주세요.
        pause
        exit /b 1
    )
    echo winget 설치 완료.
)

echo ===================================
echo   개발 도구 설치 시작
echo ===================================

call :install "1/6" "Dev-C++ 5.11" "Bloodshed.Dev-C++" "--version 5.11"
call :install "2/6" "Visual Studio Code" "Microsoft.VisualStudioCode"
call :install "3/6" "IntelliJ IDEA Community" "JetBrains.IntelliJIDEA.Community"
call :install "4/6" "MySQL Server" "Oracle.MySQL"
call :install "5/6" "MySQL Workbench" "Oracle.MySQLWorkbench"
call :install "6/6" "Miniconda3" "Anaconda.Miniconda3"

echo ===================================
echo   설치 완료
echo ===================================
pause
exit /b 0

:install
echo [%~1] %~2 설치 중...
winget install -e --id %~3 %~4 --accept-package-agreements --accept-source-agreements
if errorlevel 1 (
    echo %~2 설치에 실패했습니다.
    exit /b 0
)
exit /b 0
