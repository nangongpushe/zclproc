@echo off
echo [INFO] install jars.

%~d0
cd %~dp0

call mvn install:install-file -DgroupId=cas.client.core -DartifactId=cas-client-core-3.2.1 -Dversion=3.2.1 -Dpackaging=jar -Dfile=./cas-client-core-3.2.1.jar

echo [INFO] finish!

pause