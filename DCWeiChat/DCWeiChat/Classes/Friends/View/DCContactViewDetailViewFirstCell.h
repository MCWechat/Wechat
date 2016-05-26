//
//  DCContactViewDetailViewFirstCell.h
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCContactViewDetailViewFirstCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *idname;


+ (instancetype) cellWithTableView:(UITableView *)tableView;

@end
