# yunxiao-java-build-image
Java build image with edas config center for [yunxiao](https://cn.aliyun.com/product/yunxiao).
在云效Pipeline中，进行[Pandora Boot 应用](https://help.aliyun.com/document_detail/91226.html)测试时，
需要[edas轻量级配置中心](https://help.aliyun.com/document_detail/44163.html)的支持，
该镜像在云效官方提供的java1.8镜像中添加了edas轻量级配置中心服务，以支持测试在云效中的执行。

### Refs
* [runit](http://smarden.org/runit/replaceinit.html)
* [云效Build环境简介](https://help.aliyun.com/document_detail/60101.html)
* [云效自定义Build镜像](https://help.aliyun.com/document_detail/70482.html)

### Cmds
```
# Build image
docker build --pull -t "yunxiao-base:dev" .
```


### Docs
* http://jpetazzo.github.io/2013/10/06/policy-rc-d-do-not-start-services-automatically/
* https://stackoverflow.com/questions/18047931/automatically-start-services-in-docker-container
