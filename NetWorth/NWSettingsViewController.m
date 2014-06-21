//
//  NWSettingsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 21/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWSettingsViewController.h"
#import <Parse/Parse.h>

@interface NWSettingsViewController ()

@end

@implementation NWSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender
{
    [PFUser logOut];
}
@end
