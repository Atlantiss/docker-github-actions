ARG version=ltsc2019
FROM mcr.microsoft.com/windows/servercore:$version

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV chocolateyUseWindowsCompression false

RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress

RUN choco install -n cmake ccache git openssl mysql

RUN Import-Module C:\ProgramData\chocolatey\helpers\chocolateyInstaller.psm1 ; \
    Install-ChocolateyPackage ` \
    -packageName 'boost-msvc-14.2' ` \
    -installerType 'exe' ` \
    -silentArgs '/VERYSILENT' ` \
    -url64bit 'https://vorboss.dl.sourceforge.net/project/boost/boost-binaries/1.75.0/boost_1_75_0-msvc-14.2-64.exe' ` \
	-checksum64 403DF37906EA7951C3C26BC046A5901A392E7E62DC386D22F8D7A0EAACD7696F ` \
	-checksumType64 sha256
