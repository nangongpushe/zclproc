@echo off
echo [INFO] install jars.

%~d0
cd %~dp0

call mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc6 -Dversion=11.2.0 -Dpackaging=jar -Dfile=./ojdbc6.jar

echo [INFO] finish!

pause