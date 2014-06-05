//
//  SYBData.h
//  Story Board
//
//  Created by T.J. Mercer on 5/16/14.
//  Copyright (c) 2014 T.J. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYBData : NSObject

+(SYBData *)mainData;

-(void)addNewProject:(NSDictionary *)project atKey:(NSString *)key;
-(void)addNewChapter:(NSDictionary *)chapter;
-(void)moveChapter:(NSArray *)chapter fromIndex:(NSInteger)from toIndex:(NSInteger)to;
-(void)addNewCharacter:(NSString *)character withNumber:(NSInteger)number;
-(void)addNewPlotPoint:(NSDictionary *)plotPoint atIndex:(NSInteger)index;

-(void)saveData;


-(NSMutableDictionary *)allProjects;
-(NSMutableDictionary *)characters;
-(NSMutableArray *)chapters;
-(NSString *)currentTitle;
-(NSMutableDictionary *)currentProject;
-(NSDictionary *)currentChapter;

// move chapter from and to
// remove object at index (from)
// add object at index (to)


@property (nonatomic) NSMutableDictionary * projects;
@property (nonatomic) NSInteger selectedProject;
@property (nonatomic) NSInteger selectedChapter;

@property (nonatomic) NSArray * colors;

@end
