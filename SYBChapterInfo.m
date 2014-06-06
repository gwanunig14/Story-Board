//
//  SYBChapterInfo.m
//  Story Board
//
//  Created by T.J. Mercer on 5/27/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBChapterInfo.h"

#import "SYBNewPlotPoint.h"

#import "SYBInfoCell.h"

#import "SYBData.h"

@interface SYBChapterInfo ()<UITextViewDelegate>

@end

@implementation SYBChapterInfo
{
    SYBInfoCell * cell;
    
    NSArray * bulletPoints;
    
    UITextView * plotPoint;
    
    NSMutableArray * plotPoints;
    
    SYBNewPlotPoint * plotWindow;
    
    UIButton * cellButton;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        plotPoints = [@[] mutableCopy];
        
        plotWindow = [[SYBNewPlotPoint alloc]init];
        
//        bulletPoints = [SYBData mainData].currentChapter[@"info"];
        
        self.tableView.separatorColor = [UIColor clearColor];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIBarButtonItem * createNewPlotPoint = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newPlotWindow)];
    createNewPlotPoint.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItems = @[createNewPlotPoint, self.editButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    bulletPoints = [SYBData mainData].currentChapter[@"info"];
    return [bulletPoints count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[SYBInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.plotInfo = plotPoints[indexPath.row];
    cell.colorNumber = [bulletPoints[indexPath.row][@"character"] intValue];
    
    [cell makeCell];
    
    cellButton = [[UIButton alloc]initWithFrame:cell.frame];
    [cellButton addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    cellButton.tag = indexPath.row;
    
    [self.tableView addSubview:cellButton];
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    plotPoint = [[UITextView alloc] initWithFrame: CGRectMake(10, 10, SCREEN_WIDTH - 70, 0)];
    
    plotPoint.text = bulletPoints[indexPath.row][@"plotpoint"];
    
    [plotPoint layoutIfNeeded];
    
    CGRect frame = plotPoint.frame;
    
    frame.size.height = plotPoint.contentSize.height + 20;
    
    plotPoint.frame = CGRectMake(10, 10, frame.size.width, frame.size.height - 20);
    
    plotPoint.editable = NO;
    
    [plotPoints insertObject:plotPoint atIndex:indexPath.row];

    return frame.size.height;
}

-(void)cellClick:(UIButton *)sender
{
    UITextView * editText = plotPoints[sender.tag];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:plotWindow];
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        plotWindow.chapterAssignment = [SYBData mainData].selectedChapter;
        plotWindow.characterAssignment = [bulletPoints[sender.tag][@"character"] intValue];
        plotWindow.storyThought.text = editText.text;
        plotWindow.editNumber = (int)sender.tag;
        [plotWindow buttonLabels];
    }];
}

-(void)newPlotWindow
{
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:plotWindow];
    [self.navigationController presentViewController:nc animated:YES completion:^{
        [plotWindow buttonLabels];
    }];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SYBData mainData].currentChapter[@"info"] removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [[SYBData mainData] saveData];
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[SYBData mainData] movePlotPoint:bulletPoints[fromIndexPath.row] fromIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

@end
