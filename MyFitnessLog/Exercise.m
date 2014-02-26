//
// Created by Matheus Felipe on 20/02/14.
// Copyright (c) 2014 matbhz. All rights reserved.
//

#import "Exercise.h"


@implementation Exercise {

}
- (id)initWithName:(NSString *)name sets:(NSString *)sets reps:(NSString *)reps weight:(NSString *)weight unity:(NSString *)unity {
    if (self == [super init]) {
        self.name = name;
        self.sets = sets;
        self.reps = reps;
        self.weight = weight;
        self.unity = unity;
    }
    return self;
}


// Deserializaton
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.sets = [decoder decodeObjectForKey:@"sets"];
        self.reps = [decoder decodeObjectForKey:@"reps"];
        self.weight = [decoder decodeObjectForKey:@"weight"];
        self.unity = [decoder decodeObjectForKey:@"unity"];
    }
    return self;
}

// Serializaton
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.sets forKey:@"sets"];
    [encoder encodeObject:self.reps forKey:@"reps"];
    [encoder encodeObject:self.weight forKey:@"weight"];
    [encoder encodeObject:self.unity forKey:@"unity"];
}

@end