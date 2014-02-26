//
//  TrainingLog.h
//  MyFitnessLog
//
//  Created by Matheus Felipe on 19/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrainingLog : NSObject <NSCoding>

// TODO 1: Edge Case #1
// TODO 2: Edge Case #2
// Happy Case properties
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSMutableArray *excercises;
@property(strong, nonatomic) NSString *date;

- (id)initWithName:(NSString *)name;

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end
