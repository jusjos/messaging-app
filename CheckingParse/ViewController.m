//
//  ViewController.m
//  CheckingParse
//
//  Created by JUSTIN on 13/11/16.
//  Copyright © 2016 JUSTIN. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "CustomCell.h"

//#define CURRENTUSER @"Jesu"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    //conversation
    NSMutableArray<NSDictionary *> *messagesArray;
    BOOL isMyOwnMessage;
    UITapGestureRecognizer *tapGestureRecognizer;
    
    
    //chats list
    NSArray *usersList;
    NSMutableArray *allOtherUserslist;
    NSString *recipient;
    
}
- (IBAction)refreshButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)sendButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *refreshBtn;
@property (weak, nonatomic) IBOutlet UIView *sendingContainerView;
@property (weak, nonatomic) IBOutlet UIView *emptyStateView;
@property (weak, nonatomic) IBOutlet UIView *viewOfUsers;
@property (weak, nonatomic) IBOutlet UIView *viewOfConversation;

@end

@implementation ViewController

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"touched textfield");
    [self.sendButton setBackgroundImage:[UIImage imageNamed:@"sendButtonBlue"] forState:UIControlStateNormal];
    
    //set a tap gesture recognizer
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
    
    //move it up
    [UIView animateWithDuration:0.2 animations:^{
        self.sendingContainerView.frame = CGRectMake(self.sendingContainerView.frame.origin.x, self.sendingContainerView.frame.origin.y - 253, self.sendingContainerView.frame.size.width, self.sendingContainerView.frame.size.height);
        //self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y - 253, self.tableView.frame.size.width, self.tableView.frame.size.height);
    }];
    
}

- (void)dismissKeyboard {
    [self.textField resignFirstResponder];
    [self.tableView removeGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer = nil;
    [self.sendButton setBackgroundImage:[UIImage imageNamed:@"sendButtonGrey"] forState:UIControlStateNormal];

    
    //move it back down
    self.sendingContainerView.frame = CGRectMake(self.sendingContainerView.frame.origin.x, self.sendingContainerView.frame.origin.y + 253, self.sendingContainerView.frame.size.width, self.sendingContainerView.frame.size.height);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //code for chat conversation
    NSLog(@"currentUser: %@ and recipient: %@", self.currentUser, recipient);
    messagesArray = [[NSMutableArray alloc] init];
    //self.usernameLabel.text = self.currentUser;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 12;
    isMyOwnMessage = NO;
    self.textField.delegate = self;
    //[self.view bringSubviewToFront:self.emptyStateView];
    [self.view bringSubviewToFront:self.refreshBtn];
    
    
    
    //code for chats list
    usersList = @[@"jesu", @"unni"];
    allOtherUserslist = [[NSMutableArray alloc] init];
    for (NSString *user in usersList) {
        if (![user isEqualToString:self.currentUser]) {
            [allOtherUserslist addObject:user];
        }
    }
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return @"FRIENDS";
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1) {
        return allOtherUserslist.count;
    } else {
        return messagesArray.count;

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 2) {
        if ([[messagesArray[indexPath.row] valueForKey:@"sender"] isEqualToString:self.currentUser]) {
            isMyOwnMessage = YES;
        } else {
            isMyOwnMessage = NO;
        }
        
        CustomCell *cell;
        //if not my own message - cell1
        if (isMyOwnMessage == NO) {
            cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.messageLabel.text = [messagesArray[indexPath.row] valueForKey:@"message"];
        } else {
            //myown cell - cell2
            cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.messageLabel.text = [messagesArray[indexPath.row] valueForKey:@"message"];
            
        }
        return cell;

    } else {
        //for the chats list, tag =1
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
        cell.textLabel.text = allOtherUserslist[indexPath.row];
        return cell;
    }
    
    
    
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 1) {
        //get the string from the cell that was selected
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.textLabel.text != nil) {
            recipient = cell.textLabel.text;
            self.usernameLabel.text = recipient;
            //NSLog(@"XXX");
            //show the conversation view
            //[self.viewOfConversation setHidden:NO];
            //[self.view bringSubviewToFront:self.viewOfConversation];
            //[self.viewOfUsers setHidden:YES];
            [UIView animateWithDuration:0.3 animations:^{
                self.viewOfConversation.frame = CGRectMake(self.viewOfConversation.frame.origin.x - 320, self.viewOfConversation.frame.origin.y, self.viewOfConversation.frame.size.width, self.viewOfConversation.frame.size.height);
                self.viewOfUsers.frame = CGRectMake(self.viewOfUsers.frame.origin.x - 320, self.viewOfUsers.frame.origin.y, self.viewOfUsers.frame.size.width, self.viewOfUsers.frame.size.height);
            }];
            
            

            
        }
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
}



- (IBAction)refreshButton:(id)sender {
    
    //change the tick to green
    //UIButton *thisButton = (UIButton *)sender;
    [self.refreshBtn setBackgroundImage:[UIImage imageNamed:@"tickGreen.png"] forState:UIControlStateNormal];
    
    //get all messages
    [self getAllMessages];
    
    
    
    
}


- (void)getAllMessages {
    //clear the messagesArray
    [messagesArray removeAllObjects];
    
    //query the messages
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error) {
            NSLog(@"there was an error during download");
        } else {
            if (objects) {
                NSDictionary *dict;
                for (PFObject *message in objects) {
                    //add the message to the array.
                    //creating a dict for the message and for the sender
                    dict = @{@"message":[message valueForKey:@"contents"],
                             @"sender":[message valueForKey:@"sender"]};
                    [messagesArray addObject:dict] ;
                    //NSLog(@"DICT: %@", dict);
                    [self.tableView reloadData];
                    [self.emptyStateView setHidden:YES];
                    [self.refreshBtn setBackgroundImage:[UIImage imageNamed:@"tickGrey.png"] forState:UIControlStateNormal];
                    
                }
            }
        }
    }];
}









- (IBAction)sendButtonPressed:(id)sender {
    
    if (self.textField.text.length == 0) {
        NSLog(@"no text to send");
    } else {
        NSLog(@"%@", self.textField.text);
        //we have some text and now we have to upload it
        
        PFObject *messageObject = [PFObject objectWithClassName:@"Messages"];
        [messageObject setValue:self.textField.text forKey:@"contents"];
        [messageObject setValue:self.currentUser forKey:@"sender"];
        [messageObject setValue:recipient forKey:@"recipient"];

        
        [messageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                NSLog(@"there was an error during saving");
            } else {
                if (succeeded) {
                    NSLog(@"message sent successfully");
                    self.textField.text = @"";
                    [self getAllMessages];
                }
            }
        }];
        
        
    }
    
}


- (IBAction)showFriendsPressed:(id)sender {
    //[self.viewOfUsers setHidden:NO];
    //[self.view bringSubviewToFront:self.viewOfUsers];
    //[self.viewOfConversation setHidden:YES];
    [UIView animateWithDuration:0.3 animations:^{
        self.viewOfConversation.frame = CGRectMake(self.viewOfConversation.frame.origin.x + 320, self.viewOfConversation.frame.origin.y, self.viewOfConversation.frame.size.width, self.viewOfConversation.frame.size.height);
        self.viewOfUsers.frame = CGRectMake(self.viewOfUsers.frame.origin.x + 320, self.viewOfUsers.frame.origin.y, self.viewOfUsers.frame.size.width, self.viewOfUsers.frame.size.height);
    }];
}
- (IBAction)signOutPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
