//
//  MasterViewController.m
//  MyFitnessLog
//
//  Created by Matheus Felipe on 18/02/14.
//  Copyright (c) 2014 matbhz. All rights reserved.
//

#import "MasterViewController.h"

#import "ExercisesListViewController.h"
#import "NewRecordViewController.h"
#import "TrainingLog.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
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
    NSLog(@"Using file from: %@", _path);

    // Loading file into _objects
    _objects = [NSKeyedUnarchiver unarchiveObjectWithFile:_path];
    // Adding add button to the navigation bar
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObjectModal)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObjectModal {
    // TODO: Create a initWithSomething to encapsulate the creation and presentation of the NewRecordViewController
    // Get the storyboard, so we can access the views designed through the XCode interface
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Add an ID for this controller in the story board, then retrieve it programmatically
    NewRecordViewController *newRecordViewController = [storyboard instantiateViewControllerWithIdentifier:@"NewRecordViewController"];
    // Create a CANCEL and DONE button for the Navigation bar
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneCreatingNewObject)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelCreatingNewObject)];
    newRecordViewController.navigationItem.rightBarButtonItem = doneButton;
    newRecordViewController.navigationItem.leftBarButtonItem = cancelButton;
    newRecordViewController.navigationItem.title = @"Nova ficha";
    // Add a navigation controller so we have the navigation bar control buttons on the top of the display
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newRecordViewController];
    // Finally, presents (not push!) the Navigation Controller
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)doneCreatingNewObject {
    // FIXME: I'm sure there is a better way to retrieve the ViewController (not the NavigationController that I passed on isertNewObjectModal)
    NewRecordViewController *newRecordViewController = (NewRecordViewController *) self.presentedViewController.childViewControllers[0];
    NSString *text = newRecordViewController.theNewRecordField.text;
    bool isRecordNameEmpty = [text isEqualToString:@""];

    if (isRecordNameEmpty) {
        newRecordViewController.warningMessage.hidden = FALSE;
    } else {
        if (!_objects) {
            _objects = [[NSMutableArray alloc] init];
        }

        //TODO: Do not allow TrainingLogs with already existing name
        TrainingLog *trainingLog = [[TrainingLog alloc] initWithName:text];
        // Add TrainingLog to the TableView
        [_objects insertObject:trainingLog atIndex:0];

        [NSKeyedArchiver archiveRootObject:_objects toFile:_path];


        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)cancelCreatingNewObject {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {

    [NSKeyedArchiver archiveRootObject:_objects toFile:_path];

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    TrainingLog *trainingLogCell = _objects[indexPath.row];
    cell.textLabel.text = trainingLogCell.name;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [NSKeyedArchiver archiveRootObject:_objects toFile:_path];
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
        TrainingLog *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}


@end