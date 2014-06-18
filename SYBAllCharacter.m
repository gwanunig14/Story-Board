//
//  SYBAllCharacter.m
//  Story Board
//
//  Created by T.J. Mercer on 6/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBAllCharacter.h"
#import "SYBInfoCell.h"
#import "SYBData.h"


@interface SYBAllCharacter ()

@end

@implementation SYBAllCharacter

{
    NSMutableArray * chapterPoints;
    NSMutableArray * plotPoints;
    UITextView * plotPoint;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        plotPoints = [@[]mutableCopy];
        chapterPoints = [@[]mutableCopy];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (NSDictionary * one in [SYBData mainData].currentProject[@"projectInfo"])
    {
        NSLog(@"change 1 %@",one);
        for (NSMutableDictionary * two in one[@"info"])
        {
            NSLog(@"change 2 %@",two);
//            int change = [[two objectForKey:@"character"] intValue];
//            NSLog(@"change 3 %i",change);
//            if (change == self.character)
//            {
//                NSLog(@"change 4 %@",two[@"character"]);
//                [chapterPoints addObject:two];
//                NSLog(@"change 5 %@",two);
//            };
        };
    };
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"rows %lu",(unsigned long)[chapterPoints count]);
    return [chapterPoints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"a");
    SYBInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSLog(@"b");
    if (cell == nil)
    {
        cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSLog(@"c");
    cell.plotInfo = plotPoints[indexPath.row];
    NSLog(@"%@",plotPoints);
    NSString * character = chapterPoints[indexPath.row][@"character"];
    cell.color = [SYBData mainData].characters[character];
//    cell.colorNumber = cell.plotInfo.tag;
    NSLog(@"e");
    [cell makeCell];
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    plotPoint = [[UITextView alloc] initWithFrame: CGRectMake(10, 10, SCREEN_WIDTH - 70, 0)];
    
    plotPoint.text = chapterPoints[indexPath.row][@"plotpoint"];
    
//    plotPoint.tag = [chapterPoints[indexPath.row][@"character"] integerValue];

    [plotPoint layoutIfNeeded];
    
    CGRect frame = plotPoint.frame;
    
    frame.size.height = plotPoint.contentSize.height + 20;
    
    plotPoint.frame = CGRectMake(10, 10, frame.size.width, frame.size.height - 20);
    
    plotPoint.editable = NO;
    
    [plotPoints addObject:plotPoint];
    
    NSLog(@"Plot %@",plotPoint);
    
    return frame.size.height;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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
