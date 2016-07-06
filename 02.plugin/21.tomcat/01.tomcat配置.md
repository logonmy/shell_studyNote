[TOC]
#tomcat配置

##tomcat 配置虚拟目录
	<Host appBase="test" autoDeploy="true" name="x.com"
		unpackWARs="true">
		<Valve className="org.apache.catalina.valves.AccessLogValve"
			directory="logs" pattern="%h %l %u %t &quot;%r&quot; %s %b" prefix="x.com_log."
			suffix=".txt" />

		<Context docBase="payband1" path="/payband1" reloadable="true"  workDir="C:/tomcat/work/payband1"/>
	</Host>

##tomcat 禁止tomcat access日志输出
<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs" pattern="%h %l %u %t &quot;%r&quot; %s %b" prefix="localhost_access_log." suffix=".txt"/>

去掉该行即可禁止