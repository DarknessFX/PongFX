@ECHO OFF
cd ..
cd Build
ECHO %cd%

REM GLOBAL
DEL /Q /F /S Manifest_NonUFSFiles_Win64.txt
DEL /Q /F /S Manifest_NonUFSFiles_Win32.txt

REM WINDOWSNOEDITOR
cd WindowsNoEditor
RD /S /Q Engine\Binaries\ThirdParty\DbgHelp
RD /S /Q Engine\Binaries\ThirdParty\libsndfile
RD /S /Q Engine\Binaries\ThirdParty\NVIDIA
RD /S /Q Engine\Binaries\ThirdParty\Windows

cd..

REM DEVELOPMENT
cd Development
RD /S /Q WindowsNoEditor\Engine\Binaries\ThirdParty\DbgHelp
RD /S /Q WindowsNoEditor\Engine\Binaries\ThirdParty\libsndfile
RD /S /Q WindowsNoEditor\Engine\Binaries\ThirdParty\NVIDIA
RD /S /Q WindowsNoEditor\Engine\Binaries\ThirdParty\Windows

cd..

REM SHIPPING
cd Shipping
RD /S /Q WindowsNoEditor\Engine\Binaries\ThirdParty\DbgHelp
RD /S /Q WindowsNoEditor\Engine\Binaries\ThirdParty\libsndfile
RD /S /Q WindowsNoEditor\Engine\Binaries\ThirdParty\NVIDIA
RD /S /Q WindowsNoEditor\Engine\Binaries\ThirdParty\Windows

cd..

REM == END ==
REM PAUSE