//
//  VXSplashAdViewController.m
//  VideoXDemo_iOS
//
//  Created by 乔岩 on 2019/9/26.
//  Copyright © 2019 乔岩. All rights reserved.
//

#import "VXSplashAdViewController.h"
#import <VideoXSDK/VideoXSDK.h>

@interface VXSplashAdViewController () <VXSplashAdDelegate>

@property(nonatomic, strong) VXSplashAd *splash;

@end

@implementation VXSplashAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)loadAndShow:(id)sender {
    self.splash = [[VXSplashAd alloc] initWithAdUnitId:@"21824"];
    self.splash.delegate = self;
    [self.splash loadAdAndShowInWindow:[UIApplication sharedApplication].keyWindow];
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
