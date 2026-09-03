@echo off
setlocal

where winget >nul 2>nul
if errorlevel 1 (
    echo [ERROR] winget was not found. Install Microsoft App Installer and try again.
    exit /b 1
)

call :install "NAVER.Whale"
call :install "Microsoft.PowerShell"
call :install "Kakao.KakaoTalk"
call :install "Notion.Notion"
call :install "GeekUninstaller.GeekUninstaller"
call :install "Bandisoft.Bandizip"
call :install "Microsoft.PowerToys"
call :install "9PKTQ5699M62"



echo.
echo All installation commands have finished.
pause
exit /b 0

:install
echo.
echo [INSTALL] %~1 %~2
if "%~2"=="" (
    winget install --exact --id "%~1" --accept-package-agreements --accept-source-agreements
) else (
    winget install --exact --id "%~1" --version "%~2" --accept-package-agreements --accept-source-agreements
)

if errorlevel 1 (
    echo [WARNING] %~1 failed, or requires user input.
) else (
    echo [OK] %~1 installed successfully.
)
exit /b 0
