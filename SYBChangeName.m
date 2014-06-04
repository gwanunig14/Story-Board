//
//  SYBNewProjectView.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBChangeName.h"
#import "SYBChapterView.h"
#import "SYBNavigator.h"
#import "SYBData.h"

@interface SYBChangeName () <UITextFieldDelegate>

@end

@implementation SYBChangeName
{
    SYBChapterView * chapters;
    
    UITextField * projectName;
    UIButton * createProject;
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
    projectName.placeholder = self.oldTitle;
    [self.view addSubview:projectName];
    
    createProject = [[UIButton alloc]initWithFrame:CGRectMake(20, h/2, w-40, 40)];
    createProject.backgroundColor = [UIColor redColor];
    [createProject addTarget:self action:@selector(editProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createProject];
}

-(void)editProject
{
    [[SYBData mainData].currentProject setObject:projectName.text forKey:@"title"];
    
    chapters = [[SYBChapterView alloc]init];
    
    NSLog(@"%@",[SYBData mainData].currentProject);
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
