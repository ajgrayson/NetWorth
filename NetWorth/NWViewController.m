//
//  NWViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 24/05/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWViewController.h"
#import "NWPageContentView.h"
#import "NWPageContentViewController.h"
#import "NWHomePageContentViewController.h"

@interface NWViewController ()

@end

@implementation NWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Do any additional setup after loading the view, typically from a nib.
    
    self.pageTitles = @[@"Page 1", @"Page 2", @"Page 3"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    UIViewController<NWPageContentView> *startingViewController = [self viewControllerAtIndex:0];
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

- (UIViewController<NWPageContentView> *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    if(index == 0) {
        // Home page
        NWHomePageContentViewController *pageContentViewController1 = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageContentViewController"];
        
        pageContentViewController1.pageIndex = index;
        
        return pageContentViewController1;
    } else  {
        // Create a new view controller and pass suitable data.
        NWPageContentViewController *pageContentViewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
        
        pageContentViewController2.titleText = self.pageTitles[index];
        pageContentViewController2.pageIndex = index;
        
        return pageContentViewController2;
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((UIViewController<NWPageContentView> *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    UIViewController<NWPageContentView> *vc = (UIViewController<NWPageContentView> *)viewController;
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

@end
