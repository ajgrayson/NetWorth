//
//  NWAccountDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 30/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAccountDetailsViewController.h"
#import "NWConstants.h"

@interface NWAccountDetailsViewController ()

@end

@implementation NWAccountDetailsViewController

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

-(void)viewDidAppear:(BOOL)animated
{
    if(self.data != nil) {
        //[cell.textLabel setText:[post objectForKey:@"textContent"]];
        self.nameTextField.text = [self.data objectForKey:@"name"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(id)sender
{
    [self.delegate accountDetailsViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    PFObject *account;
    
    if(self.data != nil) {
        account = self.data;
    } else {
        account = [PFObject objectWithClassName:AccountClassName];
        
        // Create relationship
        [account setObject:[PFUser currentUser] forKey:@"author"];
    }
    
    [account setObject:[self.nameTextField text] forKey:@"name"];
    
    // Save the new post
    //[self showLoading];
    [account saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.delegate accountDetailsViewController:self didSaveAccount:account];
        }
    }];
}

//- (void)showLoading
//{
//    UIActivityIndicatorView *activityView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    
//    activityView.center = self.view.center;
//    
//    [activityView startAnimating];
//    
//    [self.view addSubview:activityView];
//}


@end
