//
//  VXRewardVideoAdViewController.m
//  VideoXDemo_iOS
//
//  Created by 乔岩 on 2019/7/3.
//  Copyright © 2019 乔岩. All rights reserved.
//

#import "VXRewardVideoAdViewController.h"

#import <VideoXSDK/VXRewardAd.h>
#import <VideoXSDK/VXProtocol.h>

@interface VXRewardVideoAdViewController () <VXRewardAdLoadDelegate, VXRewardAdPlayDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@end

@implementation VXRewardVideoAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateButtonUI {
    self.showAdButton.enabled = [VXRewardAd isAdReady:@"21322"];
}

#pragma mark - Events

- (IBAction)loadAd:(id)sender {
    [VXRewardAd shareInstance].loadDelegate = self;
    [VXRewardAd shareInstance].playDelegate = self;
    [VXRewardAd loadRewardAdWithUnitID:@"21322"];
}

- (IBAction)showAd:(id)sender {
    [VXRewardAd playAdWithUnitID:@"21322"];
}

#pragma mark - DCGRewardAdLoadDelegate

-(void)adLoadSuccessWithUnitID:(NSString *)unitID {
    [self updateButtonUI];
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

-(void)adLoadFailedSUnitID:(NSString *)unitID error:(NSString *)error {
    [self updateButtonUI];
    
   NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

#pragma mark - DCGRewardAdPlayDelegate

-(void)adDidOpen:(NSString *)unitID {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

-(void)adDidClose:(NSString *)unitID reward:(BOOL)shouldReward {
    [self updateButtonUI];
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

-(void)didClickAd:(NSString *)unitID {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

-(void)adFailedToOpen:(NSString *)unitID error:(NSError *)error {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

- (void)adLoadFailedUnitID:(NSString *)unitID error:(NSString *)error {
    [self updateButtonUI];
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

@end
