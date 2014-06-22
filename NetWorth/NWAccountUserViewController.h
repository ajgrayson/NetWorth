//
//  NWAccountUserViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 22/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NWAccountUserViewController : UIViewController

@property (strong, nonatomic) PFObject *account;

@property (strong, nonatomic) PFObject *user;

@property (weak, nonatomic) IBOutlet UITextField *userEmailTextField;

@property (weak, nonatomic) IBOutlet UILabel *pendingMessageLabel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *inviteUserButton;

@property BOOL inviting;

- (IBAction)invite:(id)sender;

@end
