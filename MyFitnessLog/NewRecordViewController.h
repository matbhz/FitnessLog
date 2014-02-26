//
//  NewRecordViewController.h
//  MyFitnessLog
//
//  Created by Matheus Felipe on 18/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewRecordViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *theNewRecordField;
@property(weak, nonatomic) IBOutlet UILabel *warningMessage;

@end
