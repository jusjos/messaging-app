//
//  ViewController.h
//  CheckingParse
//
//  Created by JUSTIN on 13/11/16.
//  Copyright © 2016 JUSTIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) NSString *currentUser;
//@property (nonatomic, strong) NSString *recipient;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end

