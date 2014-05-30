//
//  NWAccountDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 30/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAccountDetailsViewController.h"

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
        self.nameTextField.text = self.data.name;
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
    NWAccount *account = [[NWAccount alloc] init];
    account.name = self.nameTextField.text;
    
    if(self.data != nil) {
        account.id = self.data.id;
    }
    
    [self.delegate accountDetailsViewController:self didAddAccount:account];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
