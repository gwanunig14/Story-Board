//
//  SYBViewAll.m
//  Story Board
//
//  Created by T.J. Mercer on 6/4/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBViewAll.h"
#import "SYBInfoCell.h"
#import "SYBData.h"

@interface SYBViewAll ()

@end

@implementation SYBViewAll
{
    NSArray * chapterPoints;
    NSMutableDictionary * allPoints;
    NSMutableArray * plotPoints;
    UITextView * plotPoint;
    float marker;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        NSLog(@"chapters %@",[SYBData mainData].chapters);
        plotPoints = [@[]mutableCopy];
        allPoints = [@{}mutableCopy];
        marker = 0;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[SYBData mainData].chapters count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"1");
    
    NSMutableArray * current = [@[]mutableCopy];
    [current addObject:plotPoints];
//    [allPoints insertObject:current atIndex:0];
//    NSLog(@"here we go %@",allPoints);
    chapterPoints = [SYBData mainData].chapters[section][@"info"];
    NSString * heading = [SYBData mainData].chapters[section][@"heading"];
    return heading;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    
    cell.plotInfo = allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    NSString * character = [SYBData mainData].chapters[indexPath.section][@"info"][indexPath.row][@"character"];
    cell.color = [SYBData mainData].characters[character];
    
    NSLog(@"%@",[SYBData mainData].chapters[indexPath.section][@"info"][indexPath.row][@"character"]);
    [cell makeCell];
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"2");
    if (allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]] == 0)
    {
        allPoints[[NSString stringWithFormat:@"%d",(int)indexPath.section]] = [@[]mutableCopy];
    }
    NSLog(@"3");
    plotPoint = [[UITextView alloc] initWithFrame: CGRectMake(10, 10, SCREEN_WIDTH - 70, 0)];
    NSLog(@"4");
    plotPoint.text = [SYBData mainData].chapters[indexPath.section][@"info"][indexPath.row][@"plotpoint"];
    NSLog(@"5");
//    plotPoint.tag = [[SYBData mainData].chapters[indexPath.section][@"info"][indexPath.row][@"character"] intValue];
    NSLog(@"6");
    [plotPoint layoutIfNeeded];
    NSLog(@"7");
    CGRect frame = plotPoint.frame;
    NSLog(@"8");
    frame.size.height = plotPoint.contentSize.height + 20;
    NSLog(@"9");
    plotPoint.frame = CGRectMake(10, 10, frame.size.width, frame.size.height - 20);
    NSLog(@"10");
    plotPoint.editable = NO;
    NSLog(@"11");
//    cell.plotInfo = plotPoints[indexPath.section][indexPath.row];
    [allPoints[[NSString stringWithFormat:@"%ld",(long)indexPath.section]] addObject:plotPoint];
    NSLog(@"%@",allPoints);
    
//    [allPoints addObject:plotPoints];
//    NSLog(@"Plot %@",allPoints);
    
//    [plotPoints insertObject:plotPoint atIndex:indexPath.row];
    
    return frame.size.height;
}


@end
