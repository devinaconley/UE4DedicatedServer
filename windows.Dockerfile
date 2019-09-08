# WORK IN PROGRESS
# docker image to run test on simple dedicated server
# FROM mcr.microsoft.com/windows:1809
FROM adamrehn/ue4-build-prerequisites:ltsc2019
MAINTAINER devin@monodrive.io

# setup directx
RUN sc config wuauserv start=demand
# RUN dism.exe /online /norestart /add-capability /capabilityname:Tools.Graphics.DirectX~~~~0.0.1.0

# include pre-built exe
COPY . c:\\home\\server

# expose ports
EXPOSE 7777/udp

# runtime
WORKDIR c:\\home\\server
CMD c:\\home\\server\\UE4DedicatedServerServer.exe -server -log
