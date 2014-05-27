//
//  SYBStartup.m
//  Story Board
//
//  Created by T.J. Mercer on 5/15/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBStartup.h"
#import "SYBNewProjectView.h"
#import "SYBProjectList.h"
#import "SYBChapterView.h"

@interface SYBStartup ()

@end

@implementation SYBStartup
{
    SYBChapterView * chapters;
    SYBNewProjectView * newScreen;
    SYBProjectList * loadScreen;
    
    UINavigationController * nc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UIButton * newProject = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-100, 150, 200, 40)];
        newProject.backgroundColor = [UIColor redColor];
        [newProject addTarget:self action:@selector(newProject) forControlEvents:UIControlEventTouchUpInside];
        [newProject setTitle:@"New Project" forState:UIControlStateNormal];
        newProject.layer.cornerRadius = newProject.frame.size.height/4;
        [self.view addSubview:newProject];
        
        UIButton * loadProject = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-100, 250, 200, 40)];
        loadProject.backgroundColor = [UIColor redColor];
        [loadProject setTitle:@"Load Project" forState:UIControlStateNormal];
        loadProject.layer.cornerRadius = loadProject.frame.size.height/4;
        [loadProject addTarget:self action:@selector(loadProjects) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:loadProject];
        
        chapters = [[SYBChapterView alloc]init];
        
        newScreen = [[SYBNewProjectView alloc]init];
        loadScreen = [[SYBProjectList alloc]init];
        
        nc = self.navigationController;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)loadProjects
{
    nc = self.navigationController;
    [nc pushViewController:loadScreen animated:YES];
}

-(void)newProject
{
    nc = self.navigationController;
    [nc pushViewController:newScreen animated:YES];
}

-(void)nextScreen:(UIViewController *)window
{
    [nc pushViewController:window animated:YES];
}

//-(void)projectChosen:(NSObject *)project
//{
//    UINavigationController * nc = self.navigationController;
//    [nc pushViewController: chapters animated:YES];
//    [chapters createArraywith:project];
//    [loadScreen removeFromParentViewController];
//}
//
//-(void)newProject:(NSObject *)project
//{
//    UINavigationController * nc = self.navigationController;
//    [nc pushViewController: chapters animated:YES];
//    [chapters createArraywith:project];
//    [newScreen removeFromParentViewController];
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
