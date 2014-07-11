//
//  SYBTableViewController.m
//  Story Board
//
//  Created by T.J. Mercer on 5/17/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBProjectList.h"
#import "SYBNewProjectView.h"
#import "SYBChapterView.h"
#import "SYBInfoCell.h"
#import "SYBNav.h"
#import "SYBData.h"

@interface SYBProjectList ()

@end

@implementation SYBProjectList
{
    SYBChapterView * chapters;
    SYBNewProjectView * new;
    SYBInfoCell * cell;
    SYBData * data;
    SYBNav * nc;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        data = [[SYBData alloc]init];
        UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        background.image = [UIImage imageNamed:@"background"];
        [self.view insertSubview:background atIndex:0];
        self.navigationItem.leftBarButtonItem.tintColor = BACKGROUND_COLOR;
        self.navigationItem.rightBarButtonItem.tintColor = BACKGROUND_COLOR;
        self.tableView.rowHeight = 78;
        self.tableView.separatorColor = [UIColor clearColor];
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIButton * addNewI = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [addNewI setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [addNewI addTarget:self action:@selector(newProject) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * addNew = [[UIBarButtonItem alloc]initWithCustomView:addNewI];
    self.navigationItem.rightBarButtonItem = addNew;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationTop];
    if ([[SYBData mainData].projects count] == 0)
    {
        UITextView * welcome = [[UITextView alloc]initWithFrame:CGRectMake(40, 100, SCREEN_WIDTH - 80, 70)];
        welcome.textAlignment = NSTextAlignmentCenter;
        welcome.text =@"Welcome to \n Writer Blocks \n Click the + Button to Get Started";
        welcome.backgroundColor = TOP_COLOR;
        welcome.textColor = BACKGROUND_COLOR;
        welcome.layer.cornerRadius = 5;
        [self.view addSubview:welcome];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[SYBData mainData].allProjects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel * projectName = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 200, 20)];
    UIView * back = [[UIView alloc]initWithFrame:CGRectMake(-10, 12, 275, projectName.frame.size.height+34)];
    back.layer.cornerRadius = 5;
    back.backgroundColor = TEXTBOX_COLOR;
    projectName.backgroundColor = TEXTBOX_COLOR;
//    projectName.textAlignment = NSTextAlignmentCenter;
    projectName.text = [[SYBData mainData].allProjects allKeys][indexPath.row];
    projectName.textColor = BACKGROUND_COLOR;
    
    if (cell == nil) cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    [back addSubview:projectName];
    [cell addSubview:back];
    cell.height = back.frame.size.height;
    cell.color = TEXTBOX_COLOR;
    
    [cell makeCell];
    
    cell.backgroundColor =[UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SYBData mainData].selectedProject = [[SYBData mainData].allProjects allKeys][indexPath.row];
    chapters = [[SYBChapterView alloc]init];
    nc = [[SYBNav alloc]initWithRootViewController:chapters];
    [nc titleWithText:[SYBData mainData].selectedProject];
    [self.navigationController presentViewController:nc animated:YES completion:^{
        [self.view removeFromSuperview];
    }];

}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * killIt =[[SYBData mainData].allProjects allKeys][indexPath.row];
    [[SYBData mainData].allProjects removeObjectForKey:killIt];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [[SYBData mainData] saveData];
}

-(void)newProject
{
    new = [[SYBNewProjectView alloc]init];
    [self.navigationController pushViewController:new animated:YES];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
