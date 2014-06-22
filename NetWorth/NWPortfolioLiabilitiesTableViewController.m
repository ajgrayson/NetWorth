//
//  NWPortfolioLiabilitiesTableViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 21/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWPortfolioLiabilitiesTableViewController.h"
#import "NWManagePortfolioTabViewController.h"
#import "NWHelper.h"
#import "NWConstants.h"

@interface NWPortfolioLiabilitiesTableViewController ()

@end

@implementation NWPortfolioLiabilitiesTableViewController

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
    
    UINavigationController *nc = (UINavigationController *)[self parentViewController];
    NWManagePortfolioTabViewController *tabView = (NWManagePortfolioTabViewController *)[nc parentViewController];
    self.account = tabView.account;
    self.user = tabView.user;
    
    [self loadLiabilities];
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
    return [self.liabilities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiabilityCell" forIndexPath:indexPath];
    
    PFObject *liability = [self.liabilities objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[liability objectForKey:@"name"]];
    
    NSString *val = [liability objectForKey:@"value"];
    NSNumber *nval = [[NSNumber alloc] initWithFloat:[val floatValue]];
    NSString *sval = [NWHelper formatNumberAsMoney:nval];
    
    [cell.detailTextLabel setText:sval];
    
    PFObject *user = [liability objectForKey:@"author"];
    if(![self.user.objectId isEqualToString:user.objectId])
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddLiability"]) {
        NWLiabilityDetailsViewController *viewController = segue.destinationViewController;
        
        viewController.delegate = self;
        viewController.user = [self user];
        viewController.account = [self account];
    } else if ([segue.identifier isEqualToString:@"EditLiability"]) {
        NWLiabilityDetailsViewController *viewController = segue.destinationViewController;
        
        viewController.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PFObject *liability = [self.liabilities objectAtIndex:indexPath.row];
        
        viewController.liability = liability;
        viewController.user = [self user];
        viewController.account = [self account];
    }
}

- (void)loadLiabilities
{
    self.liabilities = [NSMutableArray arrayWithCapacity:0];
    
    PFQuery *postQuery = [PFQuery queryWithClassName:ItemClassName];
    
    // Follow relationship
    [postQuery whereKey:@"author" equalTo:self.user];
    [postQuery whereKey:@"account" equalTo:[self account]];
    [postQuery whereKey:@"type" equalTo:LiabilityTypeName];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.liabilities removeAllObjects]; // Store results
            [self.liabilities addObjectsFromArray:objects];
            [self.tableView reloadData];   // Reload table
        }
    }];
}

- (IBAction)done:(id)sender
{
    UINavigationController* navigationController = (UINavigationController*)self.parentViewController;
    UITabBarController<NWTabItemProtocol>* tabBarController = (UITabBarController<NWTabItemProtocol>*)navigationController.parentViewController;
    [tabBarController portfolioViewControllerDidDone:self];
}

- (void)liabilityDetailsViewControllerDidCancel:(NWLiabilityDetailsViewController *)controller
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)liabilityDetailsViewController:(NWLiabilityDetailsViewController *)controller didSaveLiability:(PFObject *)liability
{
    [self loadLiabilities];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
