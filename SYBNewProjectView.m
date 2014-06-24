//
//  SYBNewProjectView.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBNewProjectView.h"
#import "SYBChapterView.h"
#import "SYBNav.h"
#import "SYBData.h"

@interface SYBNewProjectView () <UITextFieldDelegate>

@end

@implementation SYBNewProjectView
{
    SYBChapterView * chapters;
    SYBNav * nc;
    UITextField * projectName;
    UIButton * createProject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        background.image = [UIImage imageNamed:@"background"];
        [self.view insertSubview:background atIndex:0];
        self.navigationController.navigationBar.tintColor = TOP_COLOR;
        
        UISwipeGestureRecognizer * rSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissed)];
        rSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:rSwipe];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    int h = self.view.frame.size.height;
    int w = self.view.frame.size.width;
    
    projectName = [[UITextField alloc]initWithFrame:CGRectMake(20, h/4, w-40, 40)];
    projectName.backgroundColor=TEXTBOX_COLOR;
    projectName.textColor = BACKGROUND_COLOR;
    projectName.placeholder = @"Project Name";
    [projectName leftViewRectForBounds:CGRectMake(0, 0, 10, 10)];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    projectName.leftView = paddingView;
    projectName.leftViewMode = UITextFieldViewModeAlways;
    projectName.layer.cornerRadius = 5;
    [self.view addSubview:projectName];
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    createProject = [[UIButton alloc]initWithFrame:CGRectMake(20, h/2, w-40, 40)];
    [createProject setTitle:@"New Project" forState:UIControlStateNormal];
    createProject.layer.cornerRadius = 10;
    [createProject setTitleColor:[UIColor colorWithRed:161/255.0 green:151/255.0 blue:110/255.0 alpha:1] forState:UIControlStateNormal];
    createProject.backgroundColor = ONE_BUTTON;
    [createProject addTarget:self action:@selector(addProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createProject];
}

-(void)addProject
{
    if (projectName.text.length > 0)
    {
        NSDictionary * project = @{@"characters":[@{}mutableCopy],
                                   @"projectInfo":[@[]mutableCopy]};
        
        [[SYBData mainData] addNewProject:project atKey:projectName.text];
        
        [SYBData mainData].selectedProject = [SYBData mainData].allProjects[projectName.text];
        
        chapters = [[SYBChapterView alloc]init];
        
        nc = [[SYBNav alloc]initWithRootViewController:chapters];
        
        [nc titleWithText:projectName.text];
        
        [self.navigationController presentViewController:nc animated:YES completion:^{
            [self.view removeFromSuperview];
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)dismissed
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
