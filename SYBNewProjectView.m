//
//  SYBNewProjectView.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBNewProjectView.h"
#import "SYBChapterView.h"
#import "SYBData.h"

@interface SYBNewProjectView () <UITextFieldDelegate>

@end

@implementation SYBNewProjectView
{
    SYBChapterView * chapters;
    
    UITextField * projectName;
    UIButton * createProject;
    
    UINavigationController * nc;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    int h = self.view.frame.size.height;
    int w = self.view.frame.size.width;
    
    chapters = [[SYBChapterView alloc]init];
    
    projectName = [[UITextField alloc]initWithFrame:CGRectMake(20, h/4, w-40, 40)];
    projectName.backgroundColor=[UIColor blueColor];
    projectName.placeholder = @"Project Name";
    [self.view addSubview:projectName];
    
    createProject = [[UIButton alloc]initWithFrame:CGRectMake(20, h/2, w-40, 40)];
    createProject.backgroundColor = [UIColor redColor];
    [createProject addTarget:self action:@selector(addProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createProject];
    
    nc = self.navigationController;
}

-(void)addProject
{
    if (projectName.text == nil)
    {
        return;
    }
    
    NSMutableDictionary * project = [@{@"title":projectName.text,
                                       @"info":[@[]mutableCopy]}mutableCopy];
    
    [[SYBData mainData] addNewProject:project];
    
    NSLog(@"%@",[SYBData mainData].allProjects);
    
    [chapters createArraywith:project];
    
    [nc pushViewController: chapters animated:YES];
}

@end
