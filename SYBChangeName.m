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
    
    int h;
    int w;
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
    h = self.view.frame.size.height;
    w = self.view.frame.size.width;
    
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
    if ([projectName.text length] > 0) {
        if (self.function == 1)
        {
            [[SYBData mainData].projects setObject:[[SYBData mainData].projects objectForKey:self.oldTitle] forKey:projectName.text];
            [[SYBData mainData].projects removeObjectForKey:self.oldTitle];
            [SYBData mainData].selectedProject = [[[SYBData mainData].projects allKeys] count]-1;
            
        } else if (self.function == 2)
        {
            [[SYBData mainData].currentProject[@"projectInfo"][self.index] setObject:projectName.text forKey:@"heading"];
        } else if (self.function == 3)
        {
            [[SYBData mainData].characters setObject:[[SYBData mainData].characters objectForKey:self.oldTitle] forKey:projectName.text];
            [[SYBData mainData].characters removeObjectForKey:self.oldTitle];
        }
    }
    
    [[SYBData mainData] saveData];
    
    chapters = [[SYBChapterView alloc]init];
    
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:chapters];
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        [self.view removeFromSuperview];
    }];
}

@end
