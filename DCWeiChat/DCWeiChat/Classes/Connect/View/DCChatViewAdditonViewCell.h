//
//  DCChatViewAdditonView.h
//  NewWeChat
//
//  Created by MornChan on 16/2/14.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCChatViewAdditonViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *textView;


+(instancetype)additonViewCellWithTableView:(UITableView *)tableView;



@end
