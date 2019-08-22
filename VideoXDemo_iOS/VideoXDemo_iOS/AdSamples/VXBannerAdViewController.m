//
//  VXBannerAdViewController.m
//  VideoXDemo_iOS
//
//  Created by 乔岩 on 2019/7/2.
//  Copyright © 2019 乔岩. All rights reserved.
//

#import "VXBannerAdViewController.h"

#import <VideoXSDK/VXBannerAd.h>

@interface VXBannerAdViewController () <VXBannerAdDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showAdButton;
@property (weak, nonatomic) IBOutlet UIButton *destroyButton;

@property (nonatomic, strong) VXBannerAd *bannerAd;

@end

@implementation VXBannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)addBannerView {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    self.bannerAd.bannerView.frame = CGRectMake(0, 0, w, w * (50 / 320.0));
    [self.view addSubview:self.bannerAd.bannerView];
}

- (void)updateButtonUI {
    self.showAdButton.enabled = self.bannerAd.bannerView ? YES : NO;
    self.destroyButton.enabled = self.showAdButton.enabled;
}

#pragma mark - Events

- (IBAction)loadAd:(id)sender {
    [self.bannerAd destroyBanner];
    self.bannerAd = [[VXBannerAd alloc] initWithUnitID:@"21608"
                                    rootViewController:self
                                              delegate:self];
}

- (IBAction)showAd:(id)sender {
    [self addBannerView];
}

- (IBAction)destroyAd:(id)sender {
    [self.bannerAd destroyBanner];
    [self updateButtonUI];
}

#pragma mark - VXBannerAdDelegate

-(void)bannerAdLoadSuccess {
    [self updateButtonUI];
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

- (void)bannerAdShowError:(NSError *)error {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

- (void)bannerAdDidClicked {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

- (void)bannerAdDidClosed {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}


@end
