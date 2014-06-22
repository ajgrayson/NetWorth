//
//  NWAccountDetailsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 30/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@class NWAccountDetailsViewController;

@protocol NWAccountDetailsViewControllerDelegate <NSObject>
- (void)accountDetailsViewControllerDidCancel:(NWAccountDetailsViewController *)controller;
- (void)accountDetailsViewController:(NWAccountDetailsViewController *)controller didSaveAccount:(PFObject *)account;
@end

@interface NWAccountDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *inviteUserButton;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (weak, nonatomic) IBOutlet UILabel *userTableTitleLabel;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) id <NWAccountDetailsViewControllerDelegate> delegate;

@property (strong, nonatomic) PFObject *account;

@property (strong, nonatomic) NSMutableArray *users;

- (IBAction)cancel:(id)sender;

- (IBAction)done:(id)sender;

@end
