//
//  VXInterstitialAdViewController.m
//  VideoXDemo_iOS
//
//  Created by 乔岩 on 2019/7/3.
//  Copyright © 2019 乔岩. All rights reserved.
//

#import "VXInterstitialAdViewController.h"

#import <VideoXSDK/VideoXSDK.h>

@interface VXInterstitialAdViewController () <VXInterstitialAdLoadDelegate, VXInterstitialAdPlayDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@property (nonatomic, strong) VXInterstitialAd *interAd;

@end

@implementation VXInterstitialAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateButtonUI {
    self.showAdButton.enabled = [self.interAd isAdReady];
}

#pragma mark - Events

- (IBAction)loadAd:(id)sender {
    self.interAd = [[VXInterstitialAd alloc] initWithUnitID:@"21321" adLoadDelegate:self];
}

- (IBAction)showAd:(id)sender {
    if ([self.interAd isAdReady]) {
        [self.interAd playAdWithAdPlayDelegate:self];
    }
}

#pragma mark - DCGInterstitialAdLoadDelegate

-(void)interAdLoadSuccessWithUnitID:(NSString *)unitID {
    [self updateButtonUI];
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

-(void)interAdLoadFailedUnitID:(NSString *)unitID error:(NSError *)error {
    [self updateButtonUI];
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

#pragma mark - DCGInterstitialAdPlayDelegate

-(void)interAdDidOpen:(NSString *)unitID {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

-(void)interAdDidClose:(NSString *)unitID {
    [self updateButtonUI];
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

-(void)interAdDidClickAd:(NSString *)unitID {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

-(void)interAdFailedToOpen:(NSString *)unitID error:(NSError *)errorMsg {
    [self updateButtonUI];
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

@end
