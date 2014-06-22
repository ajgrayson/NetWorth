//
//  NWAccountUserViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 22/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAccountUserViewController.h"

@interface NWAccountUserViewController ()

@end

@implementation NWAccountUserViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    if(self.user != nil)
    {
        self.userEmailTextField.enabled = NO;
        self.userEmailTextField.text = [self.user objectForKey:@"email"];
        self.inviteUserButton.enabled = NO;
    }
    
    self.pendingMessageLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)invite:(id)sender
{
    NSString *email = self.userEmailTextField.text;
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"email" equalTo:email];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // Do something with the found objects
            PFObject *user = [objects objectAtIndex:0];
            
            PFRelation *relation = [self.account relationForKey:@"members"];
            [relation addObject:user];
            [self.account saveInBackground];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
