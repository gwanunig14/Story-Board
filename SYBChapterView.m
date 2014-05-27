//
//  SYBChapterView.m
//  Story Board
//
//  Created by T.J. Mercer on 5/21/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBChapterView.h"

#import "SYBChapterInfo.h"

#import "SYBNewPlotPoint.h"

@interface SYBChapterView ()

@end

@implementation SYBChapterView
{
    NSMutableArray * chapterInfo;
    
    SYBChapterInfo * chosenBlock;
    
    SYBNewPlotPoint * plotWindow;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        chapterInfo = [@[]mutableCopy];
        chosenBlock = [[SYBChapterInfo alloc]init];
        
        plotWindow = [[SYBNewPlotPoint alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * createNewPlotPoint = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newPlotWindow)];
    createNewPlotPoint.tintColor = [UIColor blueColor];
    self.navigationItem.rightBarButtonItem = createNewPlotPoint;
}

-(void)createArraywith:(NSDictionary *)listItem
{
    chapterInfo = listItem[@"projectInfo"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [chapterInfo count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel * chapterName = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, self.view.frame.size.width -12, 20)];
    
    chapterName.text = chapterInfo[indexPath.row][@"heading"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell addSubview:chapterName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * selectedChapter = (NSArray *)chapterInfo[indexPath.row][@"info"];
    
    [chosenBlock fillInfoWithArray:selectedChapter];
    
    [self.navigationController pushViewController:chosenBlock animated:YES];
}

-(void)newPlotWindow
{
    [self.navigationController pushViewController: plotWindow animated:YES];
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
