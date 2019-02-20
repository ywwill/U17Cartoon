# U17Cartoon
U17漫画
纯粹是为了研究一下[Moya](https://github.com/Moya/Moya)这个网络框架，用上它有一种耳目一新的感觉，[基本用法](https://github.com/Moya/Moya/blob/master/docs_CN/Examples/Basic.md)

参考文档：</br>
[Moya 的初始化](https://www.jianshu.com/p/adee88ddcd06)</br>

[Moya+HandyJSON封装](https://www.jianshu.com/p/7286503db415)

目前的一些效果图

![效果图](https://github.com/ywwill/U17Cartoon/blob/master/result/效果图.gif)

首页的样式和AppStore的首页卡片式很接近，都是根据日期阶段几张大图首推另外穿插小编推荐。
首页部分我所采用的使用分区TableView,大图部分使用tableviewcell，而上面星期天的显示区域做为tableView的headerView,下面小编推荐的部分作为tableview的footerView，其中footerView内部再嵌套TableView展示列表。
