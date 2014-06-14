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
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    self.pageTitles = @[@"Page 1", @"Page 2", @"Page 3"];
    
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
    
    self.navigationItem.rightBarButtonItem.title = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController<NWPageContentViewProtocol> *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
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
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ManagePortfolio"]) {
        NWManagePortfolioTabViewController *viewController = segue.destinationViewController;
        
        viewController.delegate2 = self;
    }
}

- (void)portfolioDetailsViewControllerDidDone:(NWManagePortfolioTabViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
