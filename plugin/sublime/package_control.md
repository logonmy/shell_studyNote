[TOC]

#sublime text package_control安装

##安装包管理控制器
	import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())

##pci
1. 按Ctrl + Shift + P
2. 输入pci 后回车(Package Control: Install Package)
