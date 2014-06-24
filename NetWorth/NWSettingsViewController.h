//
//  NWSettingsViewController.h
//  NetWorth
//
//  Created by Johnathan Grayson on 21/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NWSettingsViewController;

@protocol NWSettingsViewControllerDelegate <NSObject>
- (void)settingsViewControllerDidLogout:(NWSettingsViewController *)controller;
@end

@interface NWSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (strong, nonatomic) id<NWSettingsViewControllerDelegate> delegate;

- (IBAction)logout:(id)sender;

@end
