EXEC sp_ModifyColumn 'RaceResults', 'total_time', 'DECIMAL(10,2)'
EXEC sp_ModifyColumn 'RaceResults', 'total_time', 'INT'
EXEC sp_AddColumn 'Teams', 'coloana_noua', 'INT'
EXEC sp_RemoveColumn 'Teams', 'coloana_noua'

EXEC sp_AddDefaultConstraint 'RaceResults', 'default_total_time', '0', 'total_time'