//
//  SYBCharacterList.m
//  Story Board
//
//  Created by T.J. Mercer on 6/4/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBCharacterList.h"
#import "SYBChangeName.h"
#import "SYBAllCharacter.h"
#import "SYBData.h"

@interface SYBCharacterList ()

@end

@implementation SYBCharacterList
{
    NSDictionary * allCharacters;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        allCharacters = [SYBData mainData].currentProject[@"characters"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[SYBData mainData].characters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UILabel * characterName = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, self.view.frame.size.width -12, 20)];
    
    characterName.text = [[SYBData mainData].characters allKeys][indexPath.row];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString * character = [[SYBData mainData].characters allKeys][indexPath.row];
    NSLog(@"%@",[[SYBData mainData].characters allKeys][indexPath.row]);
    cell.backgroundColor = [SYBData mainData].characters[character];
    
    [cell addSubview:characterName];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.editOrNot == 1) {
        SYBChangeName * newName = [[SYBChangeName alloc]init];
        newName.function = 3;
//        newName.index = [[[SYBData mainData].characters allValues][indexPath.row] intValue];
        newName.oldTitle = [allCharacters allKeys][indexPath.row];
        [self.navigationController pushViewController:newName animated:YES];
    } else {
        SYBAllCharacter * viewAC = [[SYBAllCharacter alloc]init];
        NSLog(@"newest %@",[allCharacters allValues]);
//        viewAC.character = [[allCharacters allValues][indexPath.row] intValue];
        [self.navigationController pushViewController:viewAC animated:YES];
    }
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
