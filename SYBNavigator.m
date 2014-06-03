//
//  SYBNavigator.m
//  Story Board
//
//  Created by T.J. Mercer on 6/2/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBNavigator.h"
#import "SYBProjectList.h"
#import "SYBNewProjectView.h"

@interface SYBNavigator ()

@end

@implementation SYBNavigator

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

//-(void)listViewAndDeleteOld:(UIViewController *)old
//{
//    NSLog(@"pressed");
//    SYBProjectList * oldProjects = [[SYBProjectList alloc]init];
//    [self.delegate pushViewController:oldProjects];
//}
//
//-(void)newViewAndDeleteOld:(UIViewController *)old
//{
//    NSLog(@"pressed");
//    SYBNewProjectView * newProject = [[SYBNewProjectView alloc]init];
//    [self pushViewController:newProject animated:YES];
//    [self.delegate pushViewController:newProject];
//}

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
