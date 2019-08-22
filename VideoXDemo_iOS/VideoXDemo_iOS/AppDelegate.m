//
//  AppDelegate.m
//  VideoXDemo_iOS
//
//  Created by 乔岩 on 2019/7/1.
//  Copyright © 2019 乔岩. All rights reserved.
//

#import "AppDelegate.h"

#import <VideoXSDK/VideoXSDK.h>

@interface AppDelegate () <VXSplashAdDelegate>

@property(nonatomic, strong) VXSplashAd *splash;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [VideoXSDK setLogLevel:VXLogLevelOff];
    [VideoXSDK initWithAppID:@"3238"
                      pubKey:@"f52275c7006fe85101637eedb1f73d5b"];
    
    self.splash = [[VXSplashAd alloc] initWithAdUnitId:@"21803"];
    self.splash.delegate = self;
    [self.splash loadAdAndShowInWindow:self.window];
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - VXSplashAdDelegate

/**
 This method is called when splash ad loaded successfully.
 */
- (void)splashAdDidLoad:(VXSplashAd *)splashAd {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

/**
 This method is called when splash ad failed to load.
 @param error : error message
 */
- (void)splashAd:(VXSplashAd *)splashAd didFailWithError:(NSError *)error {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

/**
 This method is called when splash ad slot will be showing.
 */
- (void)splashAdWillShow:(VXSplashAd *)splashAd
{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}


/**
 This method is called when splash ad is clicked.
 */
- (void)splashAdDidClick:(VXSplashAd *)splashAd {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

/**
 This method is called when splash ad is closed.
 */
- (void)splashAdDidClose:(VXSplashAd *)splashAd {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

@end
