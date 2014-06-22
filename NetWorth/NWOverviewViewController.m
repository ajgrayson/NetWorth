//
//  NWViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWOverviewViewController.h"
#import "NWPageContentViewProtocol.h"
#import "NWAccountPageContentViewController.h"
#import "NWOverviewPageContentViewController.h"

@interface NWOverviewViewController ()

@end

@implementation NWOverviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view, typically from a nib.
    
    PFRelation *relation = [self.account relationForKey:@"members"];
    
    [[relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // There was an error
        } else {
            self.users = [[NSArray alloc] initWithArray:objects];
            [self loadPages];
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    self.navigationItem.rightBarButtonItem.title = @"Edit";
}

- (void)loadPages
{
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    //PFObject *u = [self.account objectForKey:@"author"];
    //self.users = [[NSArray alloc] init];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    UIViewController<NWPageContentViewProtocol> *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController<NWPageContentViewProtocol> *)viewControllerAtIndex:(NSUInteger)index
{
    if (index > [self.users count]) {
        return nil;
    }
    
    if(index == 0) {
        // Home page
        NWOverviewPageContentViewController *pageContentViewController1 = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageContentViewController"];
        
        pageContentViewController1.pageIndex = index;
        pageContentViewController1.account = self.account;
        pageContentViewController1.navItem = self.navigationItem;
        
        return pageContentViewController1;
    } else  {
        // Create a new view controller and pass suitable data.
        NWAccountPageContentViewController *pageContentViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
        
        pageContentViewController2.pageIndex = index;
        pageContentViewController2.account = self.account;
        pageContentViewController2.user = [self.users objectAtIndex:index-1];
        pageContentViewController2.navItem = self.navigationItem;
        
        return pageContentViewController2;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((UIViewController<NWPageContentViewProtocol> *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    UIViewController<NWPageContentViewProtocol> *vc = (UIViewController<NWPageContentViewProtocol> *)viewController;
    NSUInteger index = vc.pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index > [self.users count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.users count] + 1;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NWAccountPageContentViewController *vc = (NWAccountPageContentViewController *)[[self.pageViewController viewControllers] objectAtIndex:0];
    
    if([segue.identifier isEqualToString:@"ManagePortfolio"]) {
        NWManagePortfolioTabViewController *destinationViewController = segue.destinationViewController;
        
        destinationViewController.delegate2 = self;
        destinationViewController.user = [self.users objectAtIndex:vc.pageIndex - 1];
        destinationViewController.account = self.account;
    } else if ([segue.identifier isEqualToString:@"EditAccount"]) {
        NWAccountDetailsViewController *accountDetailsViewController = segue.destinationViewController;
        
        accountDetailsViewController.delegate = self;
        accountDetailsViewController.account = self.account;
    }
}

- (IBAction)manage:(id)sender
{
    if([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Edit"]) {
        [self performSegueWithIdentifier:@"EditAccount" sender:self];//IndexPath as sender
    } else {
        [self performSegueWithIdentifier:@"ManagePortfolio" sender:self];//IndexPath as sender
    }
}

- (void)portfolioDetailsViewControllerDidDone:(NWManagePortfolioTabViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)accountDetailsViewControllerDidCancel:(NWAccountDetailsViewController *)controller
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void) accountDetailsViewController:(NWAccountDetailsViewController *)controller didSaveAccount:(PFObject *)account
{
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
