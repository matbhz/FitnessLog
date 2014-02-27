//
//  MasterViewController.m
//  MyFitnessLog
//
//  Created by Matheus Felipe on 18/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import "MasterViewController.h"

#import "ExercisesListViewController.h"
#import "NewLogViewController.h"
#import "TrainingLog.h"

@interface MasterViewController () {
    NSMutableArray *_trainingLogs;
}
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Add .plist path to _path
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    _path = [rootPath stringByAppendingPathComponent:@"trainingLogs.plist"];
    // Loading file into _trainingLogs
    _trainingLogs = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    // Adding add button to the navigation bar
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObjectModal)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObjectModal {
    // Create the NewLogViewController for presentation
    NewLogViewController *newRecordViewController = [self createNewRecordViewController];
    // Add a navigation controller so we have the navigation bar control buttons on the top of the display
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newRecordViewController];
    // Finally, presents (not push!) the Navigation Controller
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (NewLogViewController *)createNewRecordViewController {
    // Get the storyboard, so we can access the views designed through the XCode interface
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Add an ID for this controller in the story board, then retrieve it programmatically
    NewLogViewController *newRecordViewController = [storyboard instantiateViewControllerWithIdentifier:@"NewLogViewController"];
    // Create a CANCEL and DONE button for the Navigation bar with their respective actions
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneCreatingNewObject)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelCreatingNewObject)];
    newRecordViewController.navigationItem.rightBarButtonItem = doneButton;
    newRecordViewController.navigationItem.leftBarButtonItem = cancelButton;
    newRecordViewController.navigationItem.title = NSLocalizedString(@"newRecord", nil);
    return newRecordViewController;
}

- (void)doneCreatingNewObject {
    // FIXME: I'm sure there is a better way to retrieve the ViewController (not the NavigationController that I passed on insertNewObjectModal)
    NewLogViewController *newRecordViewController = (NewLogViewController *) self.presentedViewController.childViewControllers[0];
    NSString *newLogName = newRecordViewController.theNewRecordField.text;

    if ([newLogName isEqualToString:@""]) {
        newRecordViewController.warningMessage.hidden = FALSE;
    } else {
        if (!_trainingLogs) {
            _trainingLogs = [[NSMutableArray alloc] init];
        }
        TrainingLog *trainingLog = [[TrainingLog alloc] initWithName:newLogName];
        // Add TrainingLog to the _trainingLogs array
        [_trainingLogs insertObject:trainingLog atIndex:0];
        // Save new log the file
        [self save];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)cancelCreatingNewObject {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:_trainingLogs toFile:_path];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _trainingLogs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    TrainingLog *trainingLogCell = _trainingLogs[indexPath.row];
    cell.textLabel.text = trainingLogCell.name;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_trainingLogs removeObjectAtIndex:indexPath.row];
        [NSKeyedArchiver archiveRootObject:_trainingLogs toFile:_path];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showExercises"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TrainingLog *object = _trainingLogs[indexPath.row];
        [[segue destinationViewController] setTrainingLogs:object];
    }
}

@end
