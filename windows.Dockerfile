# docker image to run test on simple dedicated server
FROM mcr.microsoft.com/windows:1809
MAINTAINER devin@monodrive.io

# use cmd shell
SHELL ["cmd", "/S", "/C"]

# setup
RUN mkdir c:\\home\\dump\\staged_dlls

# install directx runtime (h/t adamrehn/ue4-docker)
ADD https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe c:\\home\\dump\\directx_redist.exe
RUN start /wait c:\\home\\dump\\directx_redist.exe /Q /T:c:\\home\\dump\\directx
WORKDIR c:\\home\\dump\\directx
RUN expand APR2007_xinput_x64.cab -F:xinput1_3.dll c:\\home\\dump\\staged_dlls
RUN expand Jun2010_D3DCompiler_43_x64.cab -F:D3DCompiler_43.dll c:\\home\\dump\\staged_dlls
RUN expand Feb2010_X3DAudio_x64.cab -F:X3DAudio1_7.dll c:\\home\\dump\\staged_dlls
RUN expand Jun2010_XAudio_x64.cab -F:XAPOFX1_5.dll c:\\home\\dump\\staged_dlls
RUN expand Jun2010_XAudio_x64.cab -F:XAudio2_7.dll c:\\home\\dump\\staged_dlls

# install visual c++ redistributable
ADD https://aka.ms/vs/16/release/vc_redist.x64.exe c:\\home\\dump\\vc_redist.x64.exe
RUN c:\\home\\dump\\vc_redist.x64.exe /install /passive /norestart

# install stages dlls
RUN move c:\\home\\dump\\staged_dlls\\* c:\\windows\\system32

# include pre-built exe
COPY . c:\\home\\server

# expose ports
EXPOSE 7777/udp

# runtime
WORKDIR c:\\home\\server
CMD c:\\home\\server\\UE4DedicatedServer\\Binaries\\Win64\\UE4DedicatedServerServer.exe -log
