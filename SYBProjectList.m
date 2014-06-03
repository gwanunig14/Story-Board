//
//  SYBTableViewController.m
//  Story Board
//
//  Created by T.J. Mercer on 5/17/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBProjectList.h"
#import "SYBChapterView.h"
#import "SYBNavigator.h"
#import "SYBData.h"

@interface SYBProjectList ()

@end

@implementation SYBProjectList
{
    SYBChapterView * chapters;
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadRowsAtIndexPaths:self.tableView.indexPathsForVisibleRows withRowAnimation:UITableViewRowAnimationTop];
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
    
    NSMutableArray * titles = [@[]mutableCopy];
    
    for (NSDictionary * titleNames in [SYBData mainData].allProjects)
    {
        [titles addObject:titleNames[@"title"]];
    }
    
    NSArray * aBC = [titles sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    UILabel * projectName = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width -12, 20)];
    projectName.textAlignment = NSTextAlignmentCenter;
    projectName.text = aBC[indexPath.row];
    
    if (cell == nil) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    [cell addSubview:projectName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SYBData mainData].selectedProject = (int)indexPath.row;
    
    chapters = [[SYBChapterView alloc]init];
    
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:chapters];
    
    [self.navigationController presentViewController:navController animated:YES completion:^{
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
    [[SYBData mainData].allProjects removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [[SYBData mainData] saveData];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
