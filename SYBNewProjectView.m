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
    
    NSDictionary * project = @{@"title":projectName.text,
                               @"characters":[@{}mutableCopy],
                               @"projectInfo":[@[]mutableCopy]};
    
    [SYBData mainData].selectedProject = (int)[[SYBData mainData].allProjects count];
    
    [[SYBData mainData] addNewProject:project];
    
    chapters = [[SYBChapterView alloc]init];
    
    NSLog(@"%@",[SYBData mainData].currentProject);
    
    
    
    [nc pushViewController: chapters animated:YES];
}

@end
