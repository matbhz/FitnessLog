//
// Created by Matheus Felipe on 20/02/14.
// Copyright (c) 2014 matbhz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Exercise : NSObject

@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *sets;
@property(strong, nonatomic) NSString *reps;
@property(strong, nonatomic) NSString *weight;
@property(strong, nonatomic) NSString *unity;

- (id)initWithName:(NSString *)name sets:(NSString *)sets reps:(NSString *)reps weight:(NSString *)weight unity:(NSString *)unity;

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

@end