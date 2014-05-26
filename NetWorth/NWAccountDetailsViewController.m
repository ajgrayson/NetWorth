//
//  NWAccountDetailsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 25/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAccount.h"
#import "NWAccountDetailsViewController.h"

@interface NWAccountDetailsViewController ()

@end

@implementation NWAccountDetailsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewDidAppear:(BOOL)animated
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.nameTextField becomeFirstResponder];
    }
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

@end
