//
//  DCContactViewCell.m
//  NewWeChat
//
//  Created by MornChan on 16/2/19.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCContactViewCell.h"


@interface DCContactViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;


@end
@implementation DCContactViewCell


-(void)setContactDetailDate:(DCContactDetailDate *)contactDetailDate
{
    _contactDetailDate = contactDetailDate;
    
    self.icon.image = [UIImage imageNamed:contactDetailDate.icon];
    
    self.name.text = contactDetailDate.name;
    
    
}


+ (instancetype)contactViewCellWithTableView:(UITableView *)tableView
{
    
    static NSString *ID = @"cc";
    DCContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DCContactViewCell" owner:nil options:nil]lastObject];

    }
    
    return cell;

}





@end
