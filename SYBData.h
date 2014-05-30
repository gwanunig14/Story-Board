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
-(void)addNewCharacter:(NSString *)character withNumber:(NSInteger)number;
-(void)addNewPlotPoint:(NSDictionary *)plotPoint atIndex:(NSInteger)index;

-(void)saveData;


-(NSArray *)allProjects;
-(NSMutableDictionary *)characters;
-(NSMutableArray *)chapters;
-(NSDictionary *)currentProject;
-(NSDictionary *)currentChapter;

@property (nonatomic) int selectedProject;
@property (nonatomic) int selectedChapter;
// selectedChapter

@property (nonatomic) NSArray * colors;

// - method to return selected project
// - method to return selected chapter

@end
