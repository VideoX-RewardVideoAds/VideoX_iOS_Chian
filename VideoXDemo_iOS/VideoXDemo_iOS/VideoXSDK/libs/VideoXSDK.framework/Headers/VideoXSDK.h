//
//  VideoXSDK.h
//  DotcAd
//
//  Created by user on 2018/7/27.
//  Copyright © 2018年 DotC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VXProtocol.h"
#import "VXRewardAd.h"
#import "VXInterstitialAd.h"
#import "VXBannerAd.h"
#import "VXLogLevel.h"
#import "VXNativeAd.h"
#import "VXNativeAdLoader.h"
#import "VXSplashAd.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoXSDK : NSObject

/**
 初始化SDK
 initialize SDK
 
 */
+ (BOOL)initWithAppID:(nullable NSString *)appID
               pubKey:(nullable NSString *)pubKey;

/**
 广告SDK初始化结果查询接口
 Check the 'VideoXSDK' has been initialized.

 @return If 'YES',the SDK has been successfully initialized.
 */
+ (BOOL)isAdSDKInitialized;

+ (void)setLogLevel:(VXLogLevel)loglevel;

+ (void)sendAfDeepLinkData:(NSDictionary *)data;

+ (void)setGDPRConsentStatus:(BOOL)status;

+ (void)showConsentInfoTips:(nullable void (^)(BOOL consentStatus, NSError *_Nullable error))callback;

@end

NS_ASSUME_NONNULL_END
