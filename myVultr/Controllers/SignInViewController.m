//
//  SignInViewController.m
//  myVultr
//
//  Created by zhangyuan on 4/26/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import "SignInViewController.h"
#import "Vultr.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.accountRepository = [[AccountRepository alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signIn:(id)sender {
    NSString* apiKey = self.apiKeyTextField.text;
    self.submitButton.enabled = false;
    
    [Vultr accountInfo:apiKey success:^(Account *account) {
        self.submitButton.enabled = true;
        [self.accountRepository save:account];
        [self performSegueWithIdentifier:@"showDashboard" sender: sender];
    } failure:^{
        self.submitButton.enabled = true;
    }];
}
@end
