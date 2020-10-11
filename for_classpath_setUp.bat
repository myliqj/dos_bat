@echo OFF
SET RDF_BIN=%~dp0

SET RDFSTORE_HOME=%RDF_BIN%\\..\\lib

set clspath=%RDF_BIN%

for /r "%RDFSTORE_HOME%" %%v IN (*.jar) do call :buildcp %%v

SET CLASSPATH=%clspath%;%CLASSPATH%

goto :end

:buildcp
set clspath=%clspath%;%*

goto :end
:end