@echo off
echo Iniciando Cerebro Colectivo...
echo.
cd /d "c:\Users\u_38015281\Desktop\Proyecto\cerebro-colectivo"

echo Instalando dependencias...
call npm install

echo.
echo Iniciando servidor...
echo ESPERA a que veas "Ready on http://localhost:3000"
echo.
echo Cuando aparezca ese mensaje, abre tu navegador y ve a:
echo http://localhost:3000
echo.
call npm run dev

pause
