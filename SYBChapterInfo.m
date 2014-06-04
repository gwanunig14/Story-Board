//
//  SYBChapterInfo.m
//  Story Board
//
//  Created by T.J. Mercer on 5/27/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBChapterInfo.h"

#import "SYBNewPlotPoint.h"

#import "SYBData.h"

@interface SYBChapterInfo ()<UITextViewDelegate>

@end

@implementation SYBChapterInfo
{
    NSArray * bulletPoints;
    
    UITextView * plotPoint;
    
    NSMutableArray * plotPoints;
    
    SYBNewPlotPoint * plotWindow;
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

-(void)viewWillAppear:(BOOL)animated
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
//    plotPoint.text = bulletPoints[indexPath.row][@"plotpoint"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    UITextView * plot = [plotPoints objectAtIndex:indexPath.row];
    
    int colorNumber = [bulletPoints[indexPath.row][@"character"] intValue];
    
    plot.backgroundColor = [SYBData mainData].colors[colorNumber];
    
    [cell.contentView addSubview:plot];
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    plotPoint = [[UITextView alloc] initWithFrame: CGRectMake(10, 10, SCREEN_WIDTH - 20, 0)];

    plotPoint.text = bulletPoints[indexPath.row][@"plotpoint"];
    
    [plotPoint layoutIfNeeded];
    
    CGRect frame = plotPoint.frame;
    
    frame.size.height = plotPoint.contentSize.height + 20;
    
    plotPoint.frame = CGRectMake(10, 10, frame.size.width, frame.size.height - 20);
    
    plotPoint.editable = NO;
    
    [plotPoints insertObject:plotPoint atIndex:indexPath.row];

    return frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITextView * editText = plotPoints[indexPath.row];
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:plotWindow];
    
    [self.navigationController presentViewController:nc animated:YES completion:^{
        plotWindow.chapterAssignment = [SYBData mainData].selectedChapter;
        plotWindow.characterAssignment = [bulletPoints[indexPath.row][@"character"] intValue];
        plotWindow.storyThought.text = editText.text;
        plotWindow.editNumber = (int)indexPath.row;
    }];
}

-(void)newPlotWindow
{
    UINavigationController * nc = [[UINavigationController alloc]initWithRootViewController:plotWindow];
    [self.navigationController presentViewController:nc animated:YES completion:^{
        
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
    [[SYBData mainData] moveChapter:bulletPoints[fromIndexPath.row] fromIndex:fromIndexPath.row toIndex:toIndexPath.row];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

@end
