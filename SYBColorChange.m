//
//  SYBColorChange.m
//  Story Board
//
//  Created by T.J. Mercer on 6/13/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBColorChange.h"
#import "SYBData.h"

@interface SYBColorChange ()

@end

@implementation SYBColorChange
{
    NSMutableArray * cells;
}

-(id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    self= [super initWithCollectionViewLayout:layout];
    if (self)
    {
        cells = [@[]mutableCopy];
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.collectionView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[SYBData mainData].colors count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-40) /3, (SCREEN_HEIGHT -50)/4);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [SYBData mainData].colors[indexPath.row];

    [cells addObject:cell];
    NSLog(@"%@",cells);

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = cells[indexPath.row];
    UIColor * color = cell.backgroundColor;
    [[SYBData mainData].characters setObject:color forKey:self.character];

    NSLog(@"%@",[SYBData mainData].currentProject);
    [[SYBData mainData] saveData];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
