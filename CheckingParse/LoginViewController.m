//
//  LoginViewController.m
//  CheckingParse
//
//  Created by JUSTIN on 28/12/16.
//  Copyright © 2016 JUSTIN. All rights reserved.
//

#import "LoginViewController.h"
//#import "ChatListViewController.h"
#import "ViewController.h"



@interface LoginViewController ()
{
    NSArray *usersList;
    BOOL foundUser;
    NSString *currentUser;
}
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end

@implementation LoginViewController

- (IBAction)loginButtonPressed:(id)sender {
    if (self.nameField.text.length > 0) {
        NSString *usernameLower = [self.nameField.text lowercaseString];
        for (NSString *userInList in usersList) {
            if ([usernameLower isEqualToString:userInList]) {
                foundUser = YES;
                currentUser = usernameLower;
                break;
            } else {
                foundUser = NO;
            }
        }
        
        //did we find a user?
        if (foundUser) {
            NSLog(@"found matching user");
            self.nameField.text = @"";
            [self performSegueWithIdentifier:@"showChat" sender:self];
        } else {
            NSLog(@"no matching user");
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showChat"]) {
        ViewController *vc = (ViewController *)[segue destinationViewController];
        vc.currentUser = currentUser;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    usersList = @[@"jesu", @"unni"];
    foundUser = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
