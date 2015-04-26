//
//  SignInViewController.m
//  myVultr
//
//  Created by zhangyuan on 4/26/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import "SignInViewController.h"
#import "Vultr.h"
#import "Toast/UIView+Toast.h"


@interface SignInViewController () <UITextFieldDelegate>

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.accountRepository = [[AccountRepository alloc] init];
    self.submitButton.enabled = false;
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
    if (!self.apiKeyTextField.text) {
        return;
    }
    
    [self beforeSignIn];
    
    NSString* apiKey = self.apiKeyTextField.text;
    
    [Vultr accountInfo:apiKey success:^(Account *account) {
        [self afterSignIn];
        [self.accountRepository save:account];
        [self performSegueWithIdentifier:@"showDashboard" sender: sender];
    } failure:^(NSError *error){
        [self afterSignIn];
        NSInteger x = self.view.frame.origin.x + self.view.frame.size.width / 2;
        NSInteger y = self.view.frame.origin.y + self.view.frame.size.height / 2;
        NSValue* value = [NSValue valueWithCGPoint:CGPointMake(x , y)];
        
        if (error.code == 403) {
            [self.view makeToast:@"Please check the API Key." duration: 3 position: value];
        } else {
            [self.view makeToast:@"Error occurs, please try again later." duration: 3 position:value];
        }
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self isValid]) {
        [self signIn:textField];
        return TRUE;
    } else {
        return FALSE;
    }
}

-(void) beforeSignIn {
    [self.view makeToastActivity];
    self.submitButton.enabled = false;
    [self.apiKeyTextField resignFirstResponder];
}

-(void) afterSignIn {
    [self.view hideToastActivity];
    self.submitButton.enabled = true;
}

- (IBAction)apiKeyTextFieldEditingChanged:(UITextField* )sender {
    if ([self isValid]) {
        self.submitButton.enabled = true;
    } else{
        self.submitButton.enabled = false;
    }
}

-(BOOL) isValid {
    return self.apiKeyTextField.text.length > 5;
}
@end
