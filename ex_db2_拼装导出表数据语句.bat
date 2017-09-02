@setlocal enabledelayedexpansion
@rem ex ys_grjbxx where grbh '102751995'
@set file=%1
@set ext=%2
@if "%ext%" == "" (set ext=del)
@if "%ext%" == "where" (
  @set ww=where %3=%4 %5 %6 %7 %8 %9
  echo ww=%ww%
  @db2 -v "export to %file%.del of del messages ex_%file%.msg select * from %file% %ww%" >>ex.log
  @set v_ex_err_level=!errorlevel!
  @echo errorlevel-if:db2 -v "export to %file%.del of del messages ex_%file%.msg select * from %file% %ww%"
)else (
  @db2 -v "export to %file%.%ext% of %ext% messages ex_%file%.msg select * from %file%" >>ex.log
  @set v_ex_err_level=!errorlevel!
  @echo errorlevel-else:db2 -v "export to %file%.%ext% of %ext% messages ex_%file%.msg select * from %file%"
)
@type ex_%file%.msg
@echo errorlevel=!v_ex_err_level!