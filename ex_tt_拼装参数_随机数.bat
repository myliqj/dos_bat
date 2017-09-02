@set log=logs\%3_%1_%RANDOM%-%TIME:~6,2%.log
@mkdir logs
echo db2 -v connect to %1 user cqsi using cqsi>>%log%
@echo db2 -v call p_get_test('%3','%2','%1',?,?)>>%log%
@echo db2 -v export to xx.del of del messages ex_%log%.msg select * from xx>>%log%
@echo db2 -v connect reset>>%log%
