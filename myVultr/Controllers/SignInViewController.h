//
//  SignInViewController.h
//  myVultr
//
//  Created by zhangyuan on 4/26/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountRepository.h"

@interface SignInViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *apiKeyTextField;
- (IBAction)signIn:(id)sender;
@property (strong, nonatomic) AccountRepository* accountRepository;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end
