[TOC]
#svn常见问题

##备份和还原
svnadmin hotcopy /data/svn/Payband/ /data/Payband.dump –clean-logs
svnadmin hotcopy /data/svn/BigDataPlatform/ /data/BigDataPlatform.dump –clean-logs
##clean up 失败
sqlite3 .svn/wc.db "select * from work_queue"
sqlite3 .svn/wc.db "delete from work_queue"