//
//  DCChatViewCell.m
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//
#import "DCChatViewCell.h"
#import "DCContactDate.h"


@class DCChatViewCell;

@interface DCChatViewCell()



@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *detailView;
@property (weak, nonatomic) IBOutlet UILabel *timeView;


@end

@implementation DCChatViewCell

-(void)setDate:(DCContactDate *)date
{
    _date = date;
    
    self.nameView.text = date.name;
    
    self.iconView.image = [UIImage imageNamed:date.icon];
    
    DCMessageDate * messageDate = [date.messageDate lastObject];
    
    self.detailView.text = messageDate.message;
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (instancetype)chatViewCellWithTableView:(UITableView *)tableView
{
    
    static NSString *ID = @"cc";
    DCChatViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DCChatViewCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
    
    
    
}




@end
