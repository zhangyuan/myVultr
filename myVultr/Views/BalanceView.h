//
//  BalanceView.h
//  myVultr
//
//  Created by zhangyuan on 4/24/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BalanceView;

@protocol BalanceViewDelegate <NSObject>

@optional
- (void)onTap:(BalanceView *)view;

@end

@interface BalanceView : UIView
@property (strong, nonatomic) IBOutlet UILabel *balanceValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *pendingChargesValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *updatedAtLabel;
@property (nonatomic, assign) id<BalanceViewDelegate> delegate;
@end
