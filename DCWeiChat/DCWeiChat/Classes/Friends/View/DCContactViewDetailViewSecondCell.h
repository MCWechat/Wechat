//
//  DCContactViewDetailViewSecondCell.h
//  NewWeChat
//
//  Created by MornChan on 16/2/20.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCContactViewDetailViewSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *textView;


+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
