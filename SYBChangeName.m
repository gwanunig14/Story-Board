//
//  SYBNewProjectView.m
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBChangeName.h"
#import "SYBChapterView.h"
#import "SYBColorChange.h"
#import "SYBNav.h"
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
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        background.image = [UIImage imageNamed:@"background"];
        [self.view insertSubview:background atIndex:0];
        
        UISwipeGestureRecognizer * rSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissed)];
        rSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self.view addGestureRecognizer:rSwipe];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    h = self.view.frame.size.height;
    w = self.view.frame.size.width;
    
    projectName = [[UITextField alloc]initWithFrame:CGRectMake(20, h/4, w-40, 40)];
    projectName.backgroundColor=TEXTBOX_COLOR;
    projectName.textColor = BACKGROUND_COLOR;
    projectName.placeholder = self.oldTitle;
    [projectName leftViewRectForBounds:CGRectMake(0, 0, 10, 10)];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    projectName.leftView = paddingView;
    projectName.leftViewMode = UITextFieldViewModeAlways;
    projectName.layer.cornerRadius = 5;
    [self.view addSubview:projectName];
    
    createProject = [[UIButton alloc]initWithFrame:CGRectMake(20, h/2, w-40, 40)];
    [createProject setTitle:@"Save Change" forState:UIControlStateNormal];
    createProject.layer.cornerRadius = 10;
    [createProject setTitleColor:[UIColor colorWithRed:161/255.0 green:151/255.0 blue:110/255.0 alpha:1] forState:UIControlStateNormal];
    createProject.backgroundColor = ONE_BUTTON;
    [createProject addTarget:self action:@selector(editProject) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createProject];
    
    if (self.function == 3) {
        UIButton * cColor = [[UIButton alloc]initWithFrame:CGRectMake(20, h-100, w-40, 40)];
        cColor.backgroundColor = [SYBData mainData].characters[self.oldTitle];
        cColor.layer.cornerRadius = 5;
        [cColor setTitle:@"Change Color" forState:UIControlStateNormal];
        [cColor setTitleColor:[UIColor colorWithRed:240/255.0 green:236/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
        [cColor addTarget:self action:@selector(colorChange) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cColor];
    }
}

-(void)editProject
{
    if ([projectName.text length] > 0) {
        if (self.function == 1)
        {
            [[SYBData mainData].projects setObject:[[SYBData mainData].projects objectForKey:self.oldTitle] forKey:projectName.text];
            [[SYBData mainData].projects removeObjectForKey:self.oldTitle];
            [SYBData mainData].selectedProject = projectName.text;
            
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

-(void)colorChange
{
    SYBColorChange * colors = [[SYBColorChange alloc]initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    colors.character = self.oldTitle;
//    colors.oldColor = [[SYBData mainData].characters[self.oldTitle] intValue];
    
    [self.navigationController pushViewController:colors animated:YES];
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
