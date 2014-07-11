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
    
    UITextView * warning;
    UITextView * done;
    
    UIView * addNewBackground;
    UITextField * newItemName;
    UIButton * addItemButton;
    
    UIView * color;
    UIView * bar;
    
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
    UIImageView * background = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    background.image = [UIImage imageNamed:@"background"];
    [self.view insertSubview:background atIndex:0];
    
    addNewBackground = [[UIView alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 60)];
    
    bar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 47)];
    bar.backgroundColor = TOP_COLOR;
    [self.view addSubview:bar];
    
    self.editNumber = -1;
    
    addItemButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 70 , 10, 40, 40)];
    addItemButton.layer.cornerRadius = 20;
    [addItemButton setImage:[UIImage imageNamed:@"plus_dark"] forState:UIControlStateNormal];
    addItemButton.layer.masksToBounds = YES;
    [addItemButton addTarget:self action:@selector(addNewItemToArray) forControlEvents:UIControlEventTouchUpInside];
    [addNewBackground addSubview:addItemButton];
    
    self.storyThought = [[UITextView alloc]init];
    NSLog(@"%f",SCREEN_HEIGHT);
    if(SCREEN_HEIGHT == 480)
    {
        NSLog(@"short");
        self.storyThought.frame = CGRectMake(-10, 64, 315, SCREEN_HEIGHT/2-60);
    }else{
        self.storyThought.frame = CGRectMake(-10, 64, 315, SCREEN_HEIGHT/2);
    }
    self.storyThought.textContainerInset = UIEdgeInsetsMake(10, 20, 20, 20);
    self.storyThought.backgroundColor = TEXTBOX_COLOR;
    self.storyThought.layer.cornerRadius = 5;
    self.storyThought.textAlignment = NSTextAlignmentLeft;
    self.storyThought.textColor = BACKGROUND_COLOR;
    self.storyThought.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    [self.view addSubview:self.storyThought];
    self.storyThought.delegate = self;
    
    newChapterButton = [[UIButton alloc]initWithFrame:CGRectMake(285, self.storyThought.frame.origin.y + SCREEN_HEIGHT/2 + 28, 20, 20)];
    newChapterButton.layer.cornerRadius = 10;
    [newChapterButton setImage:[UIImage imageNamed:@"plus_dark"] forState:UIControlStateNormal];
    newChapterButton.layer.masksToBounds = YES;
    [newChapterButton addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newChapterButton];
    
    selectChapter = [[UIButton alloc]initWithFrame:CGRectMake(15, self.storyThought.frame.origin.y + SCREEN_HEIGHT/2 + 20, 200, 40)];
    [selectChapter setTitle:@"This is a chapter" forState:UIControlStateNormal];
    [selectChapter.titleLabel.font fontWithSize:17];
    selectChapter.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [selectChapter addTarget:self action:@selector(openList:) forControlEvents:UIControlEventTouchUpInside];
    [selectChapter setTitleColor:[UIColor colorWithRed:161/255.0 green:151/255.0 blue:110/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self.view addSubview:selectChapter];
    
    newCharacterButton = [[UIButton alloc]initWithFrame:CGRectMake(285, selectChapter.frame.origin.y + 58, 20, 20)];
    newCharacterButton.layer.cornerRadius = 10;
    [newCharacterButton setImage:[UIImage imageNamed:@"plus_dark"] forState:UIControlStateNormal];
    newCharacterButton.layer.masksToBounds = YES;
    [newCharacterButton addTarget:self action:@selector(addItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newCharacterButton];
    
    selectCharacter = [[UIButton alloc]initWithFrame:CGRectMake(15, selectChapter.frame.origin.y + 50, 200, 40)];
    [selectCharacter setTitleColor:[UIColor colorWithRed:161/255.0 green:151/255.0 blue:110/255.0 alpha:1] forState:UIControlStateNormal];
    [selectCharacter.titleLabel.font fontWithSize:17];
    selectCharacter.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [selectCharacter addTarget:self action:@selector(openList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectCharacter];
    
    color = [[UIButton alloc]initWithFrame:CGRectMake(220, selectChapter.frame.origin.y + 56, 24, 24)];
    color.layer.cornerRadius = 12;
    [self.view addSubview:color];
    
    addPlotPoint = [[UIButton alloc]initWithFrame:CGRectMake(15, SCREEN_HEIGHT - 58, SCREEN_WIDTH -30, 40)];
    addPlotPoint.layer.cornerRadius = 5;
    [addPlotPoint setTitle:@"Add to Story" forState:UIControlStateNormal];
    addPlotPoint.backgroundColor = ONE_BUTTON;
    addPlotPoint.titleLabel.textColor = TEXTBOX_COLOR;
    [addPlotPoint addTarget:self action:@selector(addNewPlotPoint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPlotPoint];
    
    UIView * line1 = [[UIView alloc]initWithFrame:CGRectMake(15, selectChapter.frame.origin.y + 40, 290, 0.5)];
    line1.backgroundColor = TEXTBOX_COLOR;
    [self.view addSubview:line1];
    
    UIView * line2 = [[UIView alloc]initWithFrame:CGRectMake(15, selectCharacter.frame.origin.y + 40, 290, 0.5)];
    line2.backgroundColor = TEXTBOX_COLOR;
    [self.view addSubview:line2];
    
    UISwipeGestureRecognizer * swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(dismissed)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
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
        selectChapter.tag = self.chapterAssignment;
    }
    
    if ([[SYBData mainData].characters count] != 0)
    {
        if (self.characterAssignment) {
            [selectCharacter setTitle:self.characterAssignment forState:UIControlStateNormal];
            color.backgroundColor = [SYBData mainData].characters[self.characterAssignment];
        }else {
            self.characterAssignment = [[SYBData mainData].characters allKeys][0];
            color.backgroundColor = [SYBData mainData].characters[self.characterAssignment];
            [selectCharacter setTitle:self.characterAssignment forState:UIControlStateNormal];
        }
 
    }else{
        [selectCharacter setTitle:@"character" forState:UIControlStateNormal];
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
    
    NSLog(@"%@",scrollArray);
    
    if ([scrollArray count] == 0) {
        return;
    }
    listPick = [[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 162)];
    listPick.backgroundColor = TOP_COLOR;
    listPick.delegate = self;
    chosen = sender;
    
    [self.view addSubview:listPick];
    
    if (sender.tag)
    {
        [listPick selectRow:sender.tag inComponent:0 animated:YES];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        listPick.frame = CGRectMake(0, SCREEN_HEIGHT-180, SCREEN_WIDTH, 162);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)addNewPlotPoint
{
    if ([self.storyThought.text length] > 0)
    {
        NSMutableDictionary * plotPoint = [@{@"plotpoint":self.storyThought.text,
                                             @"character":selectCharacter.titleLabel.text}mutableCopy];
        
        if (self.editNumber < 0) {
            [[SYBData mainData] addNewPlotPoint:plotPoint atIndex:self.chapterAssignment];
        }else{
            
            [[SYBData mainData].chapters[[SYBData mainData].selectedChapter][@"info"] removeObjectAtIndex:self.editNumber];
//            if (self.editNumber != [[SYBData mainData].chapters[self.chapterAssignment][@"info"] count])
//            {
//                [[SYBData mainData] addNewPlotPoint:plotPoint atIndex:self.editNumber];
//            }
            [[SYBData mainData] addNewPlotPoint:plotPoint atIndex:self.chapterAssignment];
        }
    }
        
    [self dismissed];
}

-(void)addItem:(UIButton *)sender
{
    if (sender == newChapterButton) {
        button = 1;
    } else {
        button = 2;
    }
    
    newItemName = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 90, 40)];
    newItemName.backgroundColor = TEXTBOX_COLOR;
    newItemName.layer.cornerRadius = 5;
    [addNewBackground addSubview:newItemName];
    [self.view insertSubview:addNewBackground belowSubview:self.storyThought];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.storyThought.alpha = 0;
    } completion:^(BOOL finished) {
        [self.storyThought removeFromSuperview];
    }];
    
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
            if ([[SYBData mainData].characters count] == [[SYBData mainData].colors count])
            {
                warning = [[UITextView alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH-20, 200)];
                warning.editable = NO;
                warning.font = [UIFont fontWithName:@"HelveticaNeue" size:24];
                warning.text = @"You have too many characters. \nThere are no more colors to be assigned";
                warning.backgroundColor = TOP_COLOR;
                [self.view addSubview:warning];
                
            }else{
                [selectCharacter setTitle:newItemName.text forState:UIControlStateNormal];
                [[SYBData mainData] addNewCharacter:newItemName.text withNumber:[[SYBData mainData].characters count]];
                color.backgroundColor = [SYBData mainData].characters[selectCharacter.titleLabel.text];
                NSLog(@"%@",[SYBData mainData].characters);
            }
        }
    }
    
    [self.view addSubview:self.storyThought];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.storyThought.alpha = 1;
    } completion:^(BOOL finished) {
        [newItemName removeFromSuperview];
        [addNewBackground removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
        listPick.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 162);
    } completion:^(BOOL finished) {
        [listPick removeFromSuperview];
    }];
    [warning removeFromSuperview];
    [self.storyThought resignFirstResponder];
    [done removeFromSuperview];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [chosen setTitle:[NSString stringWithFormat:@"%@",scrollArray[row]] forState:UIControlStateNormal];
    
    if (chosen == selectChapter)
    {
    chosen.tag = row;
    }
    
    self.chapterAssignment = selectChapter.tag;
    color.backgroundColor = [SYBData mainData].characters[selectCharacter.titleLabel.text];
    
    [UIView animateWithDuration:0.5 animations:^{
        listPick.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 162);
    } completion:^(BOOL finished) {
        [pickerView removeFromSuperview];
        [selectCharacter removeFromSuperview];
        [self.view addSubview:selectCharacter];

    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    done = [[UITextView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/2)-30, 5, 60, 37)];
    done.backgroundColor = [UIColor clearColor];
    done.text = @"Done";
    done.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    done.textColor = BACKGROUND_COLOR;
    [bar addSubview:done];
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

-(void)dismissed
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [selectCharacter removeFromSuperview];
        [selectChapter removeFromSuperview];
        [self.storyThought removeFromSuperview];
    }];
}

- (BOOL)automaticallyAdjustsScrollViewInsets { return NO; }

-(BOOL)prefersStatusBarHidden {return YES;}

@end
