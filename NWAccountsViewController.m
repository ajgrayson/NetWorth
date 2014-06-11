//
//  NWAccountsViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 25/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWAccount.h"
#import "NWAccountsViewController.h"
#import "NWOverviewViewController.h"

@interface NWAccountsViewController ()

@end

@implementation NWAccountsViewController

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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountCell" forIndexPath:indexPath];
    
    NWAccount *account = (self.accounts)[indexPath.row];
    cell.textLabel.text = account.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddAccount"]) {
        //UINavigationController *navigationController = segue.destinationViewController;
    
        NWAccountDetailsViewController *accountDetailsViewController = segue.destinationViewController;
        
        accountDetailsViewController.delegate = self;
        
    } else if ([segue.identifier isEqualToString:@"EditAccount"]) {
        //UINavigationController *navigationController = segue.destinationViewController;
        
        NWAccountDetailsViewController *accountDetailsViewController = segue.destinationViewController;
        
        accountDetailsViewController.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NWAccount *account = [self.accounts objectAtIndex:indexPath.row];
        
        accountDetailsViewController.data = account;
    } else if([segue.identifier isEqualToString:@"OpenAccount"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NWAccount *account = [self.accounts objectAtIndex:indexPath.row];
        
        NWOverviewViewController *viewController = segue.destinationViewController;
        viewController.account = account;
        viewController.navItem = self.navigationItem;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.tableView.editing == YES) {
        [self performSegueWithIdentifier:@"EditAccount" sender:indexPath];//IndexPath as sender
    } else {
        [self performSegueWithIdentifier:@"OpenAccount" sender:indexPath];//IndexPath as sender
    }
}

- (void)accountDetailsViewControllerDidCancel:(NWAccountDetailsViewController *)controller
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)accountDetailsViewController:(NWAccountDetailsViewController *)controller didAddAccount:(NWAccount *)account
{
    bool found = NO;
    for (int i = 0; i < self.accounts.count; i++) {
        NWAccount *ac = [self.accounts objectAtIndex:i];
        if(ac.id == account.id) {
            ac.name = account.name;
            found = true;
            [self.tableView reloadData];
        }
    }
    
    if(!found) {
        [self.accounts addObject:account];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.accounts count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [[self navigationController] popViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.accounts removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
