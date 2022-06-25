FROM mcr.microsoft.com/windows:20H2

ADD https://aka.ms/vs/16/release/vc_redist.x64.exe vcredist_x64.exe
RUN vcredist_x64.exe /install /passive /norestart /log out.txt

ADD https://github.com/microsoft/winget-cli/releases/download/v1.2.10271/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle Microsoft.DesktopAppInstaller.zip 

RUN powershell -command "Expand-Archive -Path Microsoft.DesktopAppInstaller.zip -DestinationPath Microsoft.DesktopAppInstaller"
RUN powershell -command "Move-Item -Path .\Microsoft.DesktopAppInstaller\AppInstaller_x64.msix -Destination AppInstaller_x64.zip"
RUN powershell -command "Expand-Archive -Path .\AppInstaller_x64.zip -DestinationPath AppInstaller"
RUN powershell -command "[Environment]::SetEnvironmentVariable('Path', $env:Path + ';C:\AppInstaller', [EnvironmentVariableTarget]::Machine)"
RUN powershell -command "Remove-Item .\Microsoft.DesktopAppInstaller\, .\AppInstaller_x64.zip, .\Microsoft.DesktopAppInstaller.zip -Recurse -Force"

CMD powershell