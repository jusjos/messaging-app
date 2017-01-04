//
//  CustomCell.m
//  CheckingParse
//
//  Created by JUSTIN on 26/12/16.
//  Copyright © 2016 JUSTIN. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.chatBubble.layer.cornerRadius = 5.0f;
    
    self.chatBubble.layer.shadowRadius = 1.5f;
    self.chatBubble.layer.shadowOpacity = 0.5f;
    self.chatBubble.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    //self.chatBubble.layer.shadowColor = [UIColor blackColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
