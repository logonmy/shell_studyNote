#[TOC]

##创建逻辑目录

	create directory yue_dumpdp as '/home/oracle/dmp/';

##查看管理理员目录（同时查看操作系统是否存在，因为Oracle并不关心该目录是否存在，如果不存在，则出错）

	select * from dba_directories;

##给pm4332test用户赋予在指定目录的操作权限，最好以system等管理员赋予。

	grant read,write on directory yue_dumpdp to pm4332test;

##导出/还原数据

1. 按用户导出
  expdp pm4332test/pm4332test@orcl schemas=pm4332test DIRECTORY=yue_dumpdp dumpfile=pm4332test.dmp logfile=pm4332_dmpdp.log;

2. impdp pm4332test/pm4332test@orcl remap_schema=pm4332test:pm4332dev DIRECTORY=yue_dumpdp1 DUMPFILE=pm4332test.dmp logfile=pm4332_dmpdp.log;


##导出错误
1. error creating worker process with worker id 1 
解决方法：修改pfile文件  
	oracle使用的是pfile 和spfile 要1、show parameter spfile 2、show parameter pfile 3、看v$spparameter视图 去确定
	SELECT NAME, VALUE, DISPLAY_VALUE FROM V$PARAMETER WHERE NAME ='spfile';
发现使用的是 spfile,spfile不二进制文件，不能通过直接修改文件修改
show parameter AQ_TM_PROCESSES 发现值为0
 alter system set aq_tm_processes=10 scope=both; 
 问题解决没有解决 重启oracle之后解决