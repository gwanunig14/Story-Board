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
#import "SYBNavigator.h"
#import "SYBData.h"

@interface SYBProjectList ()

@end

@implementation SYBProjectList
{
    SYBChapterView * chapters;
    SYBNewProjectView * new;
    SYBData * data;
    UINavigationController * nc;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        data = [[SYBData alloc]init];
        self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem * addNew = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newProject)];
    self.navigationItem.rightBarButtonItem = addNew;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationTop];
    if ([[SYBData mainData].projects count] == 0)
    {
        UITextView * welcome = [[UITextView alloc]initWithFrame:CGRectMake(40, 100, SCREEN_WIDTH - 80, 100)];
        welcome.textAlignment = NSTextAlignmentCenter;
        welcome.text =@"Welcome to \n Writer Blocks \n Click the + Button to Get Started";
        welcome.backgroundColor = [UIColor blueColor];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel * projectName = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width -12, 20)];
    projectName.textAlignment = NSTextAlignmentCenter;
    projectName.text = [[SYBData mainData].allProjects allKeys][indexPath.row];
    
    if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    [cell addSubview:projectName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SYBData mainData].selectedProject = (int)indexPath.row;
    
    chapters = [[SYBChapterView alloc]init];

    nc = [[UINavigationController alloc]initWithRootViewController:chapters];

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
    NSLog(@"1");
    NSString * killIt =[[SYBData mainData].allProjects allKeys][indexPath.row];
    [[SYBData mainData].allProjects removeObjectForKey:killIt];
    NSLog(@"1");
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    NSLog(@"3");
    [[SYBData mainData] saveData];
}

-(void)newProject
{
    new = [[SYBNewProjectView alloc]init];
    [self.navigationController pushViewController:new animated:YES];
}

@end
