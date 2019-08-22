# videoxdemo_iOS_china

## 接入方式

1、拖拽 `libs` 文件到工程中。

2、在 ***target*** -> ***General*** -> ***Embedded Binaries*** 栏目中添加 `VideoXSDK.framework` 文件。

![embedded binarise](https://github.com/VideoX-RewardVideoAds/videoxdemo_iOS/blob/master/images/embedded_binarise.jpg)

## 初始化

在初始化SDK处导入 `<VideoXSDK/VideoXSDK.h>` 头文件，使用类方法：

```objective-c
+ (BOOL)initWithAppID:(nullable NSString *)appID pubKey:(nullable NSString *)pubKey;
```

* `appID`: 应用识别ID，请在VideoX Monetize界面复制并填写
* `pubKey`: 加密密钥，请在VideoX Account界面复制并填写

#### 代码示例

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.

  // Initialize VideoX SDK
  [VideoXSDK initWithAppID:@"appID" pubKey:@"pubKey"];
    
  return YES;
}
```

#### 调试模式

```objective-c
+ (void)setLogLevel:(VXLogLevel)loglevel;
```

##### 代码示例
```objective-c
[VideoXSDK setLogLevel:VXLogLevelDebug];
```

**注意：**
>如果你项目同时集成了 `AppsFlyer` SDK，请务必在AppsFlyer的方法回调 `-(void)onConversionDataReceived:(NSDictionary*) installData;` 中实现如下代码：
>
```objective-c
-(void)onConversionDataReceived:(NSDictionary*) installData {
	[VideoXSDK sendAfDeepLinkData:installData];
}
```


## 广告功能

### 1. 激励视频广告


#### 请求加载广告

```objective-c
+ (void)loadRewardAdWithUnitId:(NSString *)unitId;
```

##### 代码示例

```objective-c
[VXRewardAd loadRewardAdWithUnitId:@"adUnitId"];
```

#### 判断广告状态

```objective-c
+ (BOOL)isAdReady:(NSString *)unitId;
```

##### 代码示例

```objective-c
BOOL isReady = [VXRewardAd isAdReady:@"adUnitID"];
```

#### 展示广告

```objective-c
+ (void)playAdWithUnitId:(NSString *)unitId;
```

##### 代码示例

```objective-c
[VXRewardAd playAdWithUnitId:@"adUnitID"];
```


#### 获得广告状态回调

引用`<VideoXSDK/VXProtocol.h>`头文件,实现`VXRewardAdLoadDelegate`以获得广告加载状态，实现`VXRewardAdPlayDelegate`以获得广告播放状态。

* `VXRewardAdLoadDelegate`

```objective-c
- (void)adLoadSuccessWithUnitId:(NSString *)unitId;

- (void)adLoadFailedUnitId:(NSString *)unitId error:(NSString *)error;
```

* `VXRewardAdPlayDelegate`

```objective-c
- (void)adDidOpen:(NSString *)unitId;

- (void)adDidClose:(NSString *)unitId reward:(BOOL)shouldReward;

- (void)didClickAd:(NSString *)unitId;

- (void)adFailedToOpen:(NSString *)unitId error:(NSString *)error;
```

##### 代码示例

```objective-c
[VXRewardAd shareInstance].loadDelegate = self;
[VXRewardAd shareInstance].playDelegate = self;
```

>为了更好的用户体检，强烈建议在每次需要展示激励视频广告之前，先调用 `+ (void)loadRewardAdWithUnitId:(NSString *)unitId;` 做好视频缓存的准备，避免出现加载等待时间。
>


### 2、插屏广告


#### 请求加载广告

```objective-c
- (instancetype)initWithUnitId:(NSString *)unitId adLoadDelegate:(id <VXInterstitialAdLoadDelegate>)loadDelegate;
```

##### 代码示例

```objective-c
self.interstitialAd = [[VXInterstitialAd alloc] initWithUnitId:self.interTF.text adLoadDelegate:self];
```

#### 判断广告状态

```objective-c
-(BOOL)isAdReady;
```

##### 代码示例

```objective-c
BOOL isReady = [self.interstitialAd isAdReady];
```

##### 展示广告

```objective-c
-(void)playAdWithAdPlayDelegate:(id <VXInterstitialAdPlayDelegate>)playDelegate;
```

##### 代码示例

```objective-c
[self.interstitialAd playAdWithAdPlayDelegate:self];
```

#### 获得广告回调

引用 <VideoXSDK/VXProtocol.h> 头文件,实现`VXInterstitialAdLoadDelegate`以获得广告加载状态，实现`VXInterstitialAdPlayDelegate`以获得广告播放状态。

* `VXInterstitialAdLoadDelegate`

```objective-c
- (void)interAdLoadSuccessWithUnitId:(NSString *)sunitId;

- (void)interAdLoadFailedUnitId:(NSString *)unitId error:(NSString *)error;
```


* `VXInterstitialAdPlayDelegate`

```objective-c
- (void)interAdDidOpen:(NSString *)unitId;

- (void)interAdDidClose:(NSString *)unitId;

- (void)interAdDidClickAd:(NSString *)unitId;

- (void)interAdFailedToOpen:(NSString *)unitId error:(NSString *)errorMsg;
```



### 3、横幅广告

#### 加载广告

```objective-c
- (instancetype)initWithUnitId:(NSString *)unitId adSize:(VXBannerSize)size rootViewController:(UIViewController *)controller delegate:(id<VXBannerAdDelegate>)delegate;
```
##### 代码示例

```objective-c
self.bannerAd = [[VXBannerAd alloc] initWithUnitId:@"adUnitId" adSize:VXBannerSize_BottomBanner rootViewController:self delegate:self];
```

#### 展示广告

如果横幅加载成功回调或已成功加载已知横幅，则将返回的self.bannerAd.banerView添加到视图中。

##### 代码示例

```objective-c
//banner Load successful callback
-(void)bannerAdLoadSuccess {
   CGFloat w = [UIScreen mainScreen].bounds.size.width;
   self.bannerAd.bannerView.frame = CGRectMake(0, 0, w, w * (50 / 320.0));
   [self.view addSubview:self.bannerAd.bannerView];
}
```

#### 关闭广告

```objective-c
-(void)destroyBanner;
```

##### 代码示例

```objective-c
[self.bannerAd destroyBanner];
```



#### 获得广告回调	

```objective-c
- (void)bannerAdLoadSuccess; // banner加载成功
- (void)bannerAdShowError:(NSError *)error; // banner加载失败
- (void)bannerAdDidClicked; //banner广告被点击
- (void)bannerAdDidClosed; // banner广告已关闭
```





### 4、开屏广告


#### 初始化开屏广告

```objective-c
- (instancetype)initWithAdUnitId:(NSString *)unitId;
```

#### 加载并展示开屏广告

```objective-c
- (void)loadAdAndShowInWindow:(UIWindow *)window;
```

##### 代码示例

```objective-c
@interface AppDelegate () <VXSplashAdDelegate>

@property(nonatomic, strong) VXSplashAd *splash;

@end
```

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.

  // Initialize VideoX SDK`
  [VideoXSDK initWithAppID:@"appID" pubKey:@"pubKey"];
    
  //初始化开屏广告
  self.splash = [[VXSplashAd alloc] initWithAdUnitId:@"adUnitId"];
  self.splash.delegate = self;
  //加载并展示开屏广告
  self.splash loadAdAndShowInWindow:self.window];

  return YES;
}
```

#### 获得广告回调

```objective-c
/**
 This method is called when splash ad loaded successfully.
 */
- (void)splashAdDidLoad:(VXSplashAd *)splashAd; //广告加载成功

/**
 This method is called when splash ad failed to load.
 @param errorMsg : error message
 */
- (void)splashAd:(VXSplashAd *)splashAd didFailWithError:(NSError *)error; // 广告加载失败

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillShow:(VXSplashAd *)splashAd; // 广告即将展示

/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(VXSplashAd *)splashAd; // 广告被点击

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(VXSplashAd *)splashAd; // 广告已经关闭
```



​	

### 5、原生广告

#### 加载原生广告

用`VXNativeAdLoader`类中调用加载广告方法

```objective-c
+ (void)loadNativeAdWithUnitID:(NSString *)unitId
                      delegate:(id<VXNativeAdDelegate>)delegate
            rootViewController:(UIViewController *)rootViewController;
```

#### 获取原生广告素材

在`VXNativeAdDelegate`的广告加载成功代理中，会返回一个`VXNativeAd`的原生广告对象，调用这个类的相应方法即可获得原生广告素材，开发者根据需求自行布局展示广告

```objective-c
- (UIView *)getAdView; //广告背景view
- (__kindof UIView *)getMediaImageView; //广告素材图片view
- (__kindof UIView *)getIconImageView; //广告icon图片view
- (UILabel *)getTitleLabel; //广告标题label
- (UILabel *)getBodyLabel; //广告内容label
- (UILabel *)getSourceLabel; //广告来源label
- (UIButton *)getActionButton; //广告按钮
```

**注意：**getMediaImageView可能返回UIImageView，此时需要开发者自行取`adMediaUrlString`做网络图片展示处理。

**示例**

```objective-c
if ([self.adIconImageView isKindOfClass:[UIImageView class]]) {
	[self.adMediaImageView sd_setImageWithURL:[NSURL URLWithString:self.nativeAd.adMediaUrlString]];
}
```



#### 展示原生广告

调用返回的`VXNativeAd`的原生广告对象方法

```objective-c
- (void)registerViewForAdView:(UIView *)adView
               viewController:(nullable UIViewController *)viewController
               clickableViews:(nullable NSArray<UIView *> *)clickableViews;
```

1. `adView`：**- (UIView *)getAdView** 方法返回的广告背景view

2. `viewController`： 传入当前展示广告的视图控制器

3. `clickableViews `：传入允许用户点击的广告元素视图

##### 代码示例

```objective-c
if (self.nativeAd) {
        self.adView = [self.nativeAd getAdView];
        
        self.adView.backgroundColor = [UIColor redColor];
        self.adView.frame = CGRectMake(0, 39, self.view.frame.size.width, 360);
        [self.view addSubview:self.adView];
        
        self.adIconImageView = [self.nativeAd getIconImageView];
        if ([self.adIconImageView isKindOfClass:[UIImageView class]]) {
            [self.adIconImageView sd_setImageWithURL:[NSURL URLWithString:self.nativeAd.adIconUrlString]];
        }
        self.adIconImageView.frame = CGRectMake(12, 12, 60, 60);
        [self.adView addSubview:self.adIconImageView];
        
        self.adTitleLabel = [self.nativeAd getTitleLabel];
        
        [self.adView addSubview:self.adTitleLabel];
        self.adTitleLabel.text = self.nativeAd.adTitle;
        self.adTitleLabel.frame = CGRectMake(77, 12, 150, 22);
        
        self.adSponsoredLabel = [self.nativeAd getSourceLabel];
        self.adSponsoredLabel.text = self.nativeAd.adSource;
        self.adSponsoredLabel.frame = CGRectMake(77, 50, 150, 20);
        [self.adView addSubview:self.adSponsoredLabel];
        
        self.adMediaImageView = [self.nativeAd getMediaImageView];
        self.adMediaImageView.frame = CGRectMake(12, 80,  self.adView.frame.size.width - 24, (self.adView.frame.size.width - 24) / self.nativeAd.aspectRatio);
        if ([self.adIconImageView isKindOfClass:[UIImageView class]]) {
            [self.adMediaImageView sd_setImageWithURL:[NSURL URLWithString:self.nativeAd.adMediaUrlString]];
        }
        [self.adView addSubview:self.adMediaImageView];
    
        self.adBodyLabel = [self.nativeAd getBodyLabel];
        self.adBodyLabel.text = self.nativeAd.adBodyText;
        self.adBodyLabel.frame = CGRectMake(12, 295, self.nativeAd.adActionTitle?180:355, 35);
        [self.adView addSubview:self.adBodyLabel];
        
        self.adActionButton = [self.nativeAd getActionButton];
        [self.adActionButton setTitle:self.nativeAd.adActionTitle forState:UIControlStateNormal];
        self.adActionButton.frame = CGRectMake(215, 300, 70, 30);
        self.adActionButton.hidden = !self.nativeAd.adActionTitle;
        [self.adView addSubview:self.adActionButton];
        
        [self.nativeAd registerViewForAdView:self.adView
                              viewController:self
                              clickableViews:@[self.adTitleLabel, self.adMediaImageView, self.adActionButton]];
    }
```

#### 获得广告回调	

```objective-c
- (void)nativeAdLoadSuccess:(VXNativeAd *)nativeAd unitID:(NSString *)unitID; // 广告加载成功
- (void)nativeAdLoadFailedUnitID:(NSString *)unitID error:(NSError *)error; // 广告加载失败
- (void)nativeAdDidDidClick:(VXNativeAd *)nativeAd unitID:(NSString *)unitID; // 广告已经被点击
```



## 注意

如果在使用XCode发布app的过程中，你收到如下的错误提示：

![upload_error](https://github.com/VideoX-RewardVideoAds/videoxdemo_iOS/blob/master/images/upload_error.png)

是因为我们的SDK支持了 i386、x86_64

解决方法 1:

* 使用lipo命令 去掉SDK对 i386、x86_64 的支持

解决方法 2:

* 在 ***target*** -> ***Build Phases*** 点击左上角的 ***+***，选中 ***New Run Script Phases***

* 在新添加的 ***Run Script***中添加如下脚本：

```shell
APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"  

# This script loops through the frameworks embedded in the application and  
# removes unused architectures.  
find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK  
do  
FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)  
FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"  
echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"  

EXTRACTED_ARCHS=()  

for ARCH in $ARCHS  
do  
echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"  
lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"  
EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")  
done  

echo "Merging extracted architectures: ${ARCHS}"  
lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"  
rm "${EXTRACTED_ARCHS[@]}"  

echo "Replacing original executable with thinned version"  
rm "$FRAMEWORK_EXECUTABLE_PATH"  
mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"  

done
```

如下图所示：

![run_script](https://github.com/VideoX-RewardVideoAds/videoxdemo_iOS/blob/master/images/run_script.png)



最后重新打包即可。
