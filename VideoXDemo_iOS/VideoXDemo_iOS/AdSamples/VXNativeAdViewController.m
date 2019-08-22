//
//  VXNativeAdViewController.m
//  VideoXDemo_iOS
//
//  Created by 乔岩 on 2019/7/3.
//  Copyright © 2019 乔岩. All rights reserved.
//

#import "VXNativeAdViewController.h"

#import <VideoXSDK/VideoXSDK.h>

@interface VXNativeAdViewController () <VXNativeAdDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@property (nonatomic, strong) VXNativeAd *nativeAd;

@property (strong, nonatomic) UIView *adView;
@property (weak, nonatomic) UIImageView *adIconImageView;
@property (weak, nonatomic) UILabel *adTitleLabel;
@property (weak, nonatomic) UILabel *adSponsoredLabel;
@property (weak, nonatomic) UIImageView *adChoiceImageView;
@property (weak, nonatomic) UIImageView *adMediaImageView;
@property (weak, nonatomic) UILabel *adSocialLabel;
@property (weak, nonatomic) UILabel *adBodyLabel;
@property (weak, nonatomic) UIButton *adActionButton;

@end

@implementation VXNativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateButtonUI {
    self.showAdButton.enabled = self.nativeAd ? YES : NO;
}

#pragma mark - Events

- (IBAction)loadAd:(id)sender {
    [VXNativeAdLoader loadNativeAdWithUnitID:@"21609"
                                    delegate:self
                          rootViewController:self];
}

- (IBAction)showAd:(id)sender {
    if (self.nativeAd) {
        self.adView = [self.nativeAd getAdView];
        
        self.adView.backgroundColor = [UIColor redColor];
        self.adView.frame = CGRectMake(0, 39, self.view.frame.size.width, 360);
        [self.view addSubview:self.adView];
        
        self.adIconImageView = [self.nativeAd getIconImageView];
        if ([self.adIconImageView isKindOfClass:[UIImageView class]]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.nativeAd.adIconUrlString]];
                if (data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [UIImage imageWithData:data];
                        [self.adIconImageView setImage:image];
                    });
                }
            });
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
        if ([self.adMediaImageView isKindOfClass:[UIImageView class]]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.nativeAd.adMediaUrlString]];
                if (data) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImage *image = [UIImage imageWithData:data];
                        [self.adMediaImageView setImage:image];
                    });
                }
            });
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
    
}

#pragma mark - VXNativeAd Delegate

- (void)nativeAdLoadSuccess:(VXNativeAd *)nativeAd unitID:(nonnull NSString *)unitID {
    self.nativeAd = nativeAd;
    
    [self updateButtonUI];
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

- (void)nativeAdLoadFailedUnitID:(NSString *)unitID error:(NSError *)error {
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

- (void)nativeAdDidDidClick:(VXNativeAd *)nativeAd unitID:(NSString *)unitID{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
}

@end
