# FisherMan

### 架构概览

![FisherMan](https://github.com/Geforceyu/FisherMan/blob/master/ReadmeSource/main.png)


**此架构的核心思想是，将经典的基于整个APP维度的AppDelegate、RootViewController缩小为模块维度，即整个项目由多个模块组合而成，每个模块都有自己的ModDelegate、ModRootViewController，由一个全局的容器来包含这些模块，APP的生命周期也交由这个全局容器处理，容器再将APP事件分发到各个模块。所有模块和服务只依赖此容器，模块间互不依赖**

![](https://github.com/Geforceyu/FisherMan/blob/master/ReadmeSource/modules.png)

### 面向协议
>此架构主要利用OC的协议,来达到约束模块和服务的目的，同时协议也使得架构更加灵活、有效减少耦合和强依赖。以下两个协议即此架构的核心协议

1. **FSMModProtocol**<br/>
*所有模块的代理者都需要遵守此协议，以统一模块与容器的交互一致性，以及接收app的生命周期事件。*
```Objective-C
@protocol FSMModProtocol <NSObject>

@required
//返回当前模块的根视图控制器
- (UIViewController *)rootViewControllerForMod;

@optional

- (void)modDidFinishLaunchingWithOptions:(NSDictionary *)options;

- (void)modWillResignActive;

- (void)modDidEnterBackground;

- (void)modWillEnterForeground;

- (void)modDidBecomeActive;

- (void)modWillTerminate;

- (void)modDidReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
```

2. **FSMServiceProtol**<br/>
*所有服务协议的根协议，主要定义了服务的生命周期事件，统一服务模型，以便于各服务提供者在各个生命周期做数据初始化或逻辑处理等*


-----------------------------
### 核心方法

- 模块间的跳转
```Objective-C
//启动订单模块
[[FisherMan man] launchModuleWithName:@"TradeMod" parameters:nil transition:FMModTransitionTypePush];
```

- 服务的调用
```Objective-C
//定义登录服务所能提供的服务
@protocol LoginService <FSMServiceProtocol>

- (void)loginWithUserName:(NSString *)userName passwd:(NSString *)passwd;

- (NSString *)loginUserName;

@end

//调用登录服务
id<LoginService> loginService = [[FisherMan man] findServiceWithName:@"LoginService"];
[loginService loginWithUserName:@"xiaowang" passwd:@"123"];
```
>服务的调用方和提供方不直接依赖，而是通过中间者和虚拟的服务协议，若以后服务提供方需要更换，调用方代码无需变动，易于切换



### 注册

> 采用plist来保存模块和服务的注册信息

![](https://github.com/Geforceyu/FisherMan/blob/master/ReadmeSource/profile.png)

> tip:这里services和modules的信息放在一个plist文件里面，若项目过大，可考虑将services和modules的注册plist文件拆成两个分别存放。
- 每个服务的信息包括服务名(name)及服务的实现类名(imp)组成。
- 每个模块的信息包括模块的名(name)及模块的代理者类名(delegate)组成。

### 大致流程
1. APP启动后初始化FisherContext,指定plist等
2. FisherMan读取plist文件,获取模块和服务的注册信息
2. 启动注册的服务,并记录运行中的服务
3. 创建注册表中第一个模块的代理者,询问代理者以获取第一个模块的根视图控制器，作为app启动的第一个界面
4. 模块中调用服务时，通过FisherMan和`服务名`查找对应服务，FisherMan通过服务注册信息找到实际服务提供者
5. 启动其它模块时，通过FiserMan和`模块名`来启动并跳转，FisherMan通过模块注册信息，找到模块的代理者，并向模块代理者询问此模块的根视图控制器以跳转到此视图控制器。

--------------------------
#### 详细内容请下载代码查看
--------------------------








