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

-(void)addNewProject:(NSDictionary *)project;
-(void)addNewChapter:(NSDictionary *)chapter;
-(void)moveChapter:(NSDictionary *)chapter fromIndex:(NSInteger)from toIndex:(NSInteger)to;
-(void)addNewCharacter:(NSString *)character withNumber:(NSInteger)number;
-(void)addNewPlotPoint:(NSDictionary *)plotPoint atIndex:(NSInteger)index;

-(void)saveData;


-(NSMutableArray *)allProjects;
-(NSMutableDictionary *)characters;
-(NSMutableArray *)chapters;
-(NSDictionary *)currentProject;
-(NSDictionary *)currentChapter;

// move chapter from and to
// remove object at index (from)
// add object at index (to)


@property (nonatomic) int selectedProject;
@property (nonatomic) int selectedChapter;

@property (nonatomic) NSArray * colors;

@end
