[TOC]
#svn常见问题

##clean up 失败
sqlite3 .svn/wc.db "select * from work_queue"
sqlite3 .svn/wc.db "delete from work_queue"