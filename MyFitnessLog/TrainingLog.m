//
//  TrainingLog.m
//  MyFitnessLog
//
//  Created by Matheus Felipe on 19/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import "TrainingLog.h"

@implementation TrainingLog

- (id)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.name = name;

        // Set the creation date of this new TrainingLog
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"]; // TODO: Check location for US-like date format
        self.date = [dateFormatter stringFromDate:[NSDate date]];

        self.excercises = [[NSMutableArray alloc] init];
    }
    return self;
}

// Deserializaton
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.excercises = [decoder decodeObjectForKey:@"excercises"];
    }
    return self;
}

// Serializaton
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.excercises forKey:@"excercises"];
}

@end
