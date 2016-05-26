//
//  DCChatViewAdditonView.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCChatViewAdditonViewCell.h"
@class DCChatViewAdditonViewCell;

@implementation DCChatViewAdditonViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)additonViewCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cc";
    DCChatViewAdditonViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DCChatViewAdditonViewCell" owner:nil options:nil]lastObject];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textView.textColor = [UIColor whiteColor];
        cell.textView.font = [UIFont systemFontOfSize:12];
        
    }
    
    return cell;
}

@end
