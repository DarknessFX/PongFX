@ECHO OFF
REM == Builder Settings ==
SET Rar="C:\Program Files\WinRAR\"
SET proj_name=PongFX
SET build_folder=D:/workbench/PongFX
SET ue4_folder=C:\Unreal/UE_4.23
SET ue4_UAT=%ue4_folder%\Engine\Build\BatchFiles\RunUAT.bat
REM ==============================================================================

REM == Change from \Tools to \Build ==
cd ..
cd Build
REM ==============================================================================

REM == Start Screen ==
ECHO ==============================================================================
ECHO  - Update project VERSION.
ECHO  - Remove Android ^> Oculus Quest.
ECHO  - Remove Input ^> Always Show Touch Interface.
ECHO.
ECHO Ready to compile?
PAUSE
REM ==============================================================================

REM == Start Building Win64 ==
CALL %ue4_UAT% -ScriptsForProject=%build_folder%/%proj_name%.uproject BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%build_folder%/%proj_name%.uproject -cook -stage -archive -archivedirectory=%build_folder%/Build/Shipping -package -ue4exe=%ue4_folder%\Engine\Binaries\Win64\UE4Editor-Cmd.exe -compressed -SkipCookingEditorContent -pak -nodebuginfo -manifests -build -utf8output -targetplatform=Win64 -distribution -clientconfig=Shipping
CALL ..\Tools\CleanWinBuilds.bat
CD Shipping
MOVE WindowsNoEditor %proj_name%_Win64
%Rar%\RAR.EXE a -ed -ep -ep1 -m5 -mt4 -t -vd -av- -c- -col -tk -y -mmf -s -r %cd%\%proj_name%_Win64.rar %proj_name%_Win64
%Rar%\RAR.EXE v %cd%\%proj_name%_Win64.rar
%Rar%\WINRAR.EXE cv -afzip -y -v %cd%\%proj_name%_Win64.rar
REM ==============================================================================

REM == Start Building Win64_Portable ==
COPY ..\Windows\Application.ico .
COPY ..\..\ContentRaw\PongFX_Portable.bmp .
DEL /Q rarsfx.txt
ECHO Path=%%TEMP%%>> rarsfx.txt
ECHO SavePath>> rarsfx.txt
ECHO Setup=%%TEMP%%\RARSFX0\%proj_name%_Win64\%proj_name%.exe>> rarsfx.txt
ECHO TempMode>> rarsfx.txt
ECHO Overwrite=1>> rarsfx.txt
ECHO Title=PongFX_Portable>> rarsfx.txt
%Rar%\WinRar.exe c -zrarsfx.txt %proj_name%_Win64.rar
%Rar%\WinRar.exe s -iiconApplication.ico -iimg%proj_name%_Portable.bmp %proj_name%_Win64.rar
DEL %cd%\Application.ico
DEL %cd%\%proj_name%_Portable.bmp
DEL %cd%\%proj_name%_Win64.rar
DEL %cd%\rarsfx.txt
MOVE %proj_name%_Win64.exe %proj_name%_Win64_Portable.exe
CD ..
REM ==============================================================================

REM == Start Building Win32 ==
CALL %ue4_UAT% -ScriptsForProject=%build_folder%/%proj_name%.uproject BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%build_folder%/%proj_name%.uproject -cook -stage -archive -archivedirectory=%build_folder%/Build/Shipping -package -ue4exe=%ue4_folder%\Engine\Binaries\Win64\UE4Editor-Cmd.exe -compressed -SkipCookingEditorContent -pak -nodebuginfo -manifests -build -utf8output -targetplatform=Win32 -distribution -clientconfig=Shipping

CALL ..\Tools\CleanWinBuilds.bat
CD Shipping
MOVE WindowsNoEditor %proj_name%_Win32
%Rar%\RAR.EXE a -ed -ep -ep1 -m5 -mt4 -t -vd -av- -c- -col -tk -y -mmf -s -r %cd%\%proj_name%_Win32.rar %proj_name%_Win32
%Rar%\RAR.EXE v %cd%\%proj_name%_Win32.rar
%Rar%\WINRAR.EXE cv -afzip -y -v %cd%\%proj_name%_Win32.rar
REM ==============================================================================

REM == Start Building Win32_Portable ==
COPY ..\Windows\Application.ico .
COPY ..\..\ContentRaw\PongFX_Portable.bmp .
DEL /Q rarsfx.txt
ECHO Path=%%TEMP%%>> rarsfx.txt
ECHO SavePath>> rarsfx.txt
ECHO Setup=%%TEMP%%\RARSFX0\%proj_name%_Win32\%proj_name%.exe>> rarsfx.txt
ECHO TempMode>> rarsfx.txt
ECHO Overwrite=1>> rarsfx.txt
ECHO Title=PongFX_Portable>> rarsfx.txt
%Rar%\WinRar.exe c -zrarsfx.txt %proj_name%_Win32.rar
%Rar%\WinRar.exe s -iiconApplication.ico -iimg%proj_name%_Portable.bmp %proj_name%_Win32.rar
DEL %cd%\Application.ico
DEL %cd%\%proj_name%_Portable.bmp
DEL %cd%\%proj_name%_Win32.rar
DEL %cd%\rarsfx.txt
MOVE %proj_name%_Win32.exe %proj_name%_Win32_Portable.exe
CD ..
REM ==============================================================================

REM == Start Building HTML5 ==
CALL %ue4_UAT% -ScriptsForProject=%build_folder%/%proj_name%.uproject BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%build_folder%/%proj_name%.uproject -cook -stage -archive -archivedirectory=%build_folder%/Build/Shipping -package -ue4exe=%ue4_folder%\Engine\Binaries\Win64\UE4Editor-Cmd.exe -compressed -SkipCookingEditorContent -pak -nodebuginfo -manifests -build -utf8output -targetplatform=HTML5 -clientconfig=Shipping -distribution
CD Shipping
MOVE HTML5 %proj_name%_HTML5
%Rar%\RAR.EXE a -ed -ep -ep1 -m5 -mt4 -t -vd -av- -c- -col -tk -y -mmf -s -r %cd%\%proj_name%_HTML5.rar %proj_name%_HTML5
%Rar%\RAR.EXE v %cd%\%proj_name%_HTML5.rar
%Rar%\WINRAR.EXE cv -afzip -y -v %cd%\%proj_name%_HTML5.rar
DEL %cd%\%proj_name%_HTML5.rar
CD ..
REM ==============================================================================

ECHO.
ECHO.
ECHO.
ECHO ==============================================================================
ECHO  - Enable Input ^> Always Show Touch Interface.
ECHO.
ECHO Ready to compile Android Mobile (Multi:ETC^/ASTC)?
REM ==============================================================================
PAUSE

REM == Start Building Android Mobile ==
CALL %ue4_UAT% -ScriptsForProject=%build_folder%/%proj_name%.uproject BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%build_folder%/%proj_name%.uproject -cook -stage -archive -archivedirectory=%build_folder%/Build/Shipping -package -ue4exe=%ue4_folder%\Engine\Binaries\Win64\UE4Editor-Cmd.exe -compressed -SkipCookingEditorContent -pak -nodebuginfo -manifests -build -utf8output -targetplatform=Android -cookflavor=Multi -clientconfig=Shipping
CD Shipping
MOVE Android_Multi %proj_name%_Android
%Rar%\RAR.EXE a -ed -ep -ep1 -m5 -mt4 -t -vd -av- -c- -col -tk -y -mmf -s -r %cd%\%proj_name%_Android.rar %proj_name%_Android
%Rar%\RAR.EXE v %cd%\%proj_name%_Android.rar
%Rar%\WINRAR.EXE cv -afzip -y -v %cd%\%proj_name%_Android.rar
DEL %cd%\%proj_name%_Android.rar
REM ==============================================================================

ECHO.
ECHO.
ECHO.
ECHO ==============================================================================
ECHO  - Remove Input ^> Always Show Touch Interface.
ECHO  - Add Android ^> Oculus Quest.
ECHO.
ECHO Ready to compile Android OculusQuest ?
REM ==============================================================================
PAUSE

REM == Start Building Android OculusQuest ==
CALL %ue4_UAT% -ScriptsForProject=%build_folder%/%proj_name%.uproject BuildCookRun -nocompile -nocompileeditor -installed -nop4 -project=%build_folder%/%proj_name%.uproject -cook -stage -archive -archivedirectory=%build_folder%/Build/Shipping -package -ue4exe=%ue4_folder%\Engine\Binaries\Win64\UE4Editor-Cmd.exe -compressed -SkipCookingEditorContent -pak -nodebuginfo -manifests -build -utf8output -targetplatform=Android -cookflavor=ASTC -clientconfig=Development 
CD Shipping
MOVE Android_ASTC %proj_name%_OculusQuest
%Rar%\RAR.EXE a -ed -ep -ep1 -m5 -mt4 -t -vd -av- -c- -col -tk -y -mmf -s -r %cd%\%proj_name%_OculusQuest.rar %proj_name%_OculusQuest
%Rar%\RAR.EXE v %cd%\%proj_name%_OculusQuest.rar
%Rar%\WINRAR.EXE cv -afzip -y -v %cd%\%proj_name%_OculusQuest.rar
DEL %cd%\%proj_name%_OculusQuest.rar
REM ==============================================================================

REM == Start Screen ==
ECHO ==============================================================================
ECHO.
ECHO Don't forget to:
ECHO  - Remove Android ^> Oculus Quest.
ECHO.
ECHO Finished.
PAUSE
REM ==============================================================================

REM == END ==