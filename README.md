#### 组件化中路由跟协议的设计

##### 1. 常见的组件化方法

1. Router路由方案
2. Target-Action
3. Protocol

##### 2. 路由体现

1. 页面间的跳转采用路由

   ```objective-c
   // 配置路由
   - (void)configRouter {
   	[Router registerName:@"Test" ClassName:@"TestViewController"];
   	[Router registerName:@"Comment" ClassName:@"CommentViewController"];
   }
   ```

2. 打开一个页面

   ```objective-c
   [Router openName:@"Test" params:@{}];
   ```

3. 打开一个页面有回调

    ```objective-c
   [Router openName:@"Test" params:@{} callBack:^(NSString *name, id params) {
   	         NSLog(@"页面名称：%@  回调内容：%@",name,params);
   	 }];
    ```

##### 3. 协议的体现

1. 导入对应的协议以及协议管理

   ```objective-c
   #import "BWService.h"
   #import "CommentProtocol.h"
   #import "LoginProtocol.h"
   ```

2. 调用协议的方法

   ```objective-c
   id<LoginProtocol> login = [[BWService sharedManger]serviceInstanceWithProtocol:@protocol(LoginProtocol)];
   	[login openLogin];
   
   
   id<CommentProtocol> comment = [[BWService sharedManger]serviceInstanceWithProtocol:@protocol(CommentProtocol)];
   	[comment openComment];
   	[comment getComment:^(NSString *text) {
   	         NSLog(@"获取评论啊==========%@",text);
   	 }];
   ```

##### 4. 优点

1. 规范了页面间的跳转，A，B页面无需互相引用头文件。
2. 模块间的通讯采用协议，模块具备封装，以及单一性的特点。
3. 调用者之需要知道模块的协议提供了什么方法，无需了解内部如何实现，具备“最少了解的原则”。

##### 5. 总结

1. 路由的解析可以参考蘑菇街，这里不再嗷述。

2. 路由的调整是否只能push或者present呢？可以定义一个协议，若视图控制器实现了这个协议，则可以自定义跳转。

3. 定义路由协议

   ```objective-c
   typedef void (^RouterCallBack)(NSString *name,id params);
   @protocol RouterProtocol <NSObject>
   @optional
   - (void)openVc:(UIViewController *)vc;
   - (void)eventCallBack:(RouterCallBack)callBack;
   @end
   ```

4. 判断控制器是否实现open方法

   ```objective-c
   // 实现了协议
   	if ([target conformsToProtocol:@protocol(RouterProtocol)]) {
   		id <RouterProtocol> helloVc = target;
   		if ([helloVc respondsToSelector:@selector(openVc:)]) {
   			[helloVc openVc:[self sharedInstance].rootVc];
   		}
   		else {
   			[[self sharedInstance]openTarget:target];
   		}
   		if ([helloVc respondsToSelector:@selector(eventCallBack:)]) {
   			[helloVc eventCallBack:callback];
   		}
   		return target;
   	}
   	// 未实现
   	else {
   		[[self sharedInstance]openTarget:target];
   	}
   ```

5. 视图控制器实现了协议，则跳转相关交给控制器自由定义。

   ```objective-c
   @interface CommentViewController ()<RouterProtocol>
   @end
   
   @implementation CommentViewController
   
   - (void)viewDidLoad {
   	[super viewDidLoad];
   	self.title = @"评论模块";
   	// Do any additional setup after loading the view from its nib.
   }
   
   - (void)openVc:(UIViewController *)vc {
   	[vc presentViewController:self animated:YES completion:nil];
   }
   ```

6. 对于回调的处理也是同理

   ```objective-c
   if ([helloVc respondsToSelector:@selector(eventCallBack:)]) {
   			[helloVc eventCallBack:callback];
   		}
   ...
   
   // vc
   @property(nonatomic, copy) RouterCallBack callback;
   
   ...
   - (void)sendMessage {
   	if (self.callback) {
   		self.callback(@"Test", @{@"name":@"hello"});
   	}
   }
   
   
   - (void)eventCallBack:(RouterCallBack)callBack {
   	self.callback = callBack;
   }
   ```

7. 需要拓展更多功能的方法，只需要在RouterProtocol添加。