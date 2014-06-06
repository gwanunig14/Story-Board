//
//  SYBNewPlotPoint.m
//  Story Board
//
//  Created by T.J. Mercer on 5/27/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import "SYBNewPlotPoint.h"
#import "SYBChapterInfo.h"
#import "SYBData.h"

@interface SYBNewPlotPoint () <UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>

@end

@implementation SYBNewPlotPoint
{
    NSMutableArray * scrollArray;
    
    NSInteger button;
    
    UIView * addNewBackground;
    UITextField * newItemName;
    UIButton * addItemButton;
    
    UIButton * selectChapter;
    UIButton * selectCharacter;
    UIButton * newChapterButton;
    UIButton * newCharacterButton;
    UIButton * chosen;
    UIButton * addPlotPoint;
    
    UIPickerView * listPick;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.storyThought.delegate = self;
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.chapterAssignment = 0;
        self.characterAssignment = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor whiteColor];
    addNewBackground = [[UIView alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 60)];
    addNewBackground.backgroundColor = [UIColor blueColor];
    
    self.editNumber = -1;
    
    addItemButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70 , 10, 40, 40)];
    addItemButton.backgroundColor = [UIColor redColor];
    addItemButton.layer.cornerRadius = 20;
    [addItemButton addTarget:self action:@selector(addNewItemToArray) forControlEvents:UIControlEventTouchUpInside];
    [addNewBackground addSubview:addItemButton];
    
    self.storyThought = [[UITextView alloc]initWithFrame:CGRectMake(20, 80, SCREEN_WIDTH-40, SCREEN_HEIGHT - 300)];
    self.storyThought.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.storyThought];
    
    newChapterButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, SCREEN_HEIGHT-162, 40, 40)];
    newChapterButton.layer.cornerRadius = newChapterButton.frame.size.height/2;
    newChapterButton.backgroundColor = [UIColor redColor];
    [newChapterButton setTitle:@"+" forState:UIControlStateNormal];
    [newChapterButton addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newChapterButton];
    
    selectChapter = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT-162, SCREEN_WIDTH - 90, 40)];
    selectChapter.backgroundColor = [UIColor blueColor];
    selectChapter.tag = 0;
    [selectChapter addTarget:self action:@selector(openList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectChapter];
    
    newCharacterButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-60, SCREEN_HEIGHT-112, 40, 40)];
    newCharacterButton.layer.cornerRadius = newCharacterButton.frame.size.height/2;
    newCharacterButton.backgroundColor = [UIColor redColor];
    [newCharacterButton setTitle:@"+" forState:UIControlStateNormal];
    [newCharacterButton addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newCharacterButton];
    
    selectCharacter = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT-112, SCREEN_WIDTH-90, 40)];
    selectCharacter.tag = 0;
    selectCharacter.backgroundColor = [UIColor blueColor];
    [selectCharacter addTarget:self action:@selector(openList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectCharacter];
    
    addPlotPoint = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 62, SCREEN_WIDTH - 40, 40)];
    addPlotPoint.layer.cornerRadius = 20;
    addPlotPoint.backgroundColor = [UIColor yellowColor];
    [addPlotPoint addTarget:self action:@selector(addNewPlotPoint) forControlEvents:UIControlEventTouchUpInside];
    [addPlotPoint setTitle:@"Add To Story" forState:UIControlStateNormal];
    [self.view addSubview:addPlotPoint];
    
}

-(void)buttonLabels
{
    if ([[SYBData mainData].chapters count] != 0)
    {
        [selectChapter setTitle:[NSString stringWithFormat:@"%@",[SYBData mainData].chapters[0][@"heading"]] forState:UIControlStateNormal];
    }else{
        [selectChapter setTitle:@"chapter/scene" forState:UIControlStateNormal];
    }
    
    if (self.chapterAssignment > 0)
    {
        [selectChapter setTitle:[NSString stringWithFormat:@"%@",[SYBData mainData].chapters[self.chapterAssignment][@"heading"]] forState:UIControlStateNormal];
    }
    
    if ([[SYBData mainData].characters count] != 0)
    {
        [selectCharacter setTitle:[NSString stringWithFormat:@"%@", [[[SYBData mainData].characters allKeys] objectAtIndex:0]] forState:UIControlStateNormal];
    }else{
        [selectCharacter setTitle:@"character" forState:UIControlStateNormal];
    }
    
    if (self.characterAssignment > 0)
    {
        [selectCharacter setTitle:[NSString stringWithFormat:@"%@", [[[SYBData mainData].characters allKeys] objectAtIndex:self.characterAssignment]] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)openList:(UIButton *)sender
{
    scrollArray = [@[]mutableCopy];
    if (sender == selectChapter)
    {
        for (NSDictionary * chapter in [SYBData mainData].chapters)
        {
            [scrollArray addObject:chapter[@"heading"]];
        }
    }else{
        NSArray * aBC = [[[[SYBData mainData].characters allKeys] copy] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        
        for (NSString * character in aBC)
        {
            [scrollArray addObject:character];
        }
    }
    
    listPick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-162, SCREEN_WIDTH - SCREEN_WIDTH, 162)];
    listPick.backgroundColor = [UIColor redColor];
    listPick.delegate = self;
    chosen = sender;
    
    [self.view addSubview:listPick];
    
    if (sender.tag)
    {
        [listPick selectRow:sender.tag inComponent:0 animated:YES];
    }
}

-(void)addNewPlotPoint
{
    NSLog(@"edit %ld",(long)self.editNumber);
    NSLog(@"count %@",[SYBData mainData].chapters);
    
    if ([self.storyThought.text length] > 0)
    {
        NSDictionary * plotPoint = @{@"plotpoint":self.storyThought.text,
                                     @"character":@(self.characterAssignment)};
        
        if (self.editNumber < 0) {
            [[SYBData mainData] addNewPlotPoint:plotPoint atIndex:self.chapterAssignment];
        }else{
            [[SYBData mainData].chapters[self.chapterAssignment][@"info"] removeObjectAtIndex:self.editNumber];
            NSLog(@"1");
//            if (self.editNumber != [[SYBData mainData].chapters[self.chapterAssignment][@"info"] count])
//            {
//                NSLog(@"1");
//                [[SYBData mainData] addNewPlotPoint:plotPoint atIndex:self.editNumber];
//            }
            NSLog(@"1");
            [[SYBData mainData] addNewPlotPoint:plotPoint atIndex:self.chapterAssignment];
        }
    }
        
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)addItem:(UIButton *)sender
{
    if (sender == newChapterButton) {
        button = 1;
    } else {
        button = 2;
    }
    [self.storyThought removeFromSuperview];
    
    newItemName = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 90, 40)];
    newItemName.backgroundColor = [UIColor lightGrayColor];
    [addNewBackground addSubview:newItemName];
    
    [self.view addSubview:addNewBackground];
}

-(void)addNewItemToArray
{
    NSDictionary * newItem;
    
    if ([newItemName.text length] > 0) {
        if (button == 1)
        {
            [selectChapter setTitle:newItemName.text forState:UIControlStateNormal];
            newItem = [@{@"heading":newItemName.text,
                        @"info":[@[]mutableCopy]} mutableCopy];
            [[SYBData mainData] addNewChapter:newItem];
            self.chapterAssignment = [[SYBData mainData].chapters count] - 1;
            
        }else
        {
            [selectCharacter setTitle:newItemName.text forState:UIControlStateNormal];
            [[SYBData mainData] addNewCharacter:newItemName.text withNumber:[[SYBData mainData].characters count]];
            self.characterAssignment = [[SYBData mainData].characters count];
        }
    }
    
    
    [newItemName removeFromSuperview];
    [addNewBackground removeFromSuperview];
    [self.view addSubview:self.storyThought];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [listPick removeFromSuperview];
    [self.storyThought resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [chosen setTitle:[NSString stringWithFormat:@"%@",scrollArray[row]] forState:UIControlStateNormal];
    
    chosen.tag = row;
    self.chapterAssignment = selectChapter.tag;
    self.characterAssignment = selectCharacter.tag;
    
    [pickerView removeFromSuperview];
}

-(void)textViewDidChange:(UITextView *)textView
{
    [addItemButton setTitle:@"Add To Story" forState:UIControlStateNormal];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return scrollArray[row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [scrollArray count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {return 1;}

- (BOOL)automaticallyAdjustsScrollViewInsets { return NO; }

@end
