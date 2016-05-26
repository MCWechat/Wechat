//
//  DCFriendCircleCell.m
//  NewWeChat
//
//  Created by MornChan on 16/2/22.
//  Copyright © 2016年 MornChan. All rights reserved.
//

#import "DCFriendCircleCell.h"
#import "DCFriendCircleDateFrame.h"
#import "DCFriendCircleDate.h"
#import "DCUsers.h"
#import "DCStatuses.h"
#import "UIImageView+WebCache.h"
#import "DCImageView.h"
#import "DCDiscoverViewFriendCircleController.h"

#define commentBtnWH 50
#define padding 10

@class DCUsers;
@interface DCFriendCircleCell()<DCDiscoverViewFriendCircleDelegate>

@property(weak,nonatomic) UILabel * name;
@property(weak,nonatomic) UILabel * message;
@property(weak,nonatomic) UIImageView * icon;
@property(weak,nonatomic) DCImageView * imagesView;
@property(weak,nonatomic) UIButton * commentBtn;
@property(strong,nonatomic) UIView * commentView;


@end



@implementation DCFriendCircleCell




-(void)setDateFrame:(DCFriendCircleDateFrame *)dateFrame
{
    _dateFrame = dateFrame;
    
    DCStatuses * statuses = dateFrame.statuses;
    DCUsers * users = statuses.user;
    
    NSURL * url = [[NSURL alloc]initWithString:users.profile_image_url];
    
    
    [self.icon sd_setImageWithURL:url];
    self.icon.frame = dateFrame.iconFrame;
    
    self.name.text = users.name;
    self.name.frame = dateFrame.nameFrame;
    
    self.message.text = statuses.text;
    self.message.frame = dateFrame.messageFrame;
    

    if (statuses.pic_urls.count) {
        
        self.imagesView.hidden = NO;
        self.imagesView.photos = statuses.pic_urls;
        self.imagesView.frame = dateFrame.imageViewFrame;
        
    }
    else
    {self.imagesView.hidden = YES;}
    
    
    self.commentBtn.frame = CGRectMake(self.frame.size.width - padding - commentBtnWH, dateFrame.cellHeight - padding , commentBtnWH, commentBtnWH);

    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        DCDiscoverViewFriendCircleController * vfcc = [[DCDiscoverViewFriendCircleController alloc]init];
        
        vfcc.delegate = self;
        
        self.userInteractionEnabled = YES;
        
        UIImageView * icon = [[UIImageView alloc]init];
        self.icon = icon;
        
        UILabel * name = [[UILabel alloc]init];
        name.font = [UIFont systemFontOfSize:13];
        name.textColor = [UIColor colorWithRed:0 green:0 blue:50 alpha:1];
        self.name = name;
        
        UILabel * message = [[UILabel alloc]init];
        message.font = [UIFont systemFontOfSize:13];
        message.numberOfLines = 0;
        self.message = message;
        
        DCImageView * imagesView = [[DCImageView alloc]init];
        self.imagesView = imagesView;
        
        UIButton * commetnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commetnBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [commetnBtn setImage:[UIImage imageNamed:@"chats"] forState:UIControlStateNormal];
        commetnBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        self.commentBtn = commetnBtn;
        
        
        
        [self.contentView addSubview:icon];
        [self.contentView addSubview:name];
        [self.contentView addSubview:message];
        [self.contentView addSubview:imagesView];
        [self.contentView addSubview:commetnBtn];
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}


-(void)friendCircleDidScrollWithController:(DCDiscoverViewFriendCircleController *)controller
{
    [self hideCommentView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

+ (instancetype)circleCellWithTableView:(UITableView *)tableView
{
    DCFriendCircleCell *cell = [[DCFriendCircleCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    return cell;

}



- (void)hideCommentView
{
    [self.contentView insertSubview:self.commentView belowSubview:self.commentBtn];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.commentView.transform = CGAffineTransformMakeTranslation(-111, 0);
        self.commentView.hidden = NO;
        
        
    } completion:^(BOOL finished) {
        
        
    }];

}


-(void)commentBtnClick
{
    
    if (self.commentView.hidden == YES) {
        
        [self hideCommentView];
        
        
    }
    else
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.commentView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            self.commentView.hidden = YES;
            
//            [self.commentView removeFromSuperview];

        }];

        
        
    }
    

    
    
}

- (UIView *)commentView
{
    if (!_commentView) {
        
        CGFloat commentViewW = 111;
        CGFloat commentViewH = 30;
        
        _commentView = [[UIView alloc]initWithFrame:CGRectMake(self.commentBtn.frame.origin.x , self.commentBtn.frame.origin.y + (commentBtnWH - commentViewH) /2, commentViewW, commentViewH)];

        [self.contentView addSubview:_commentView];
        
        UIButton * comBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton * goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [comBtn setBackgroundColor:[UIColor grayColor]];
        [comBtn setTitle:@"评论" forState:UIControlStateNormal];
        
        [goodBtn setBackgroundColor:[UIColor grayColor]];
        [goodBtn setTitle:@"赞" forState:UIControlStateNormal];
        
        comBtn.frame = CGRectMake(0, 0, (commentViewW-1) / 2, commentViewH);
        goodBtn.frame = CGRectMake(CGRectGetMaxX(comBtn.frame) + 1, 0, comBtn.frame.size.width, commentViewH);
        
        [_commentView addSubview:comBtn];
        [_commentView addSubview:goodBtn];
        
        _commentView.hidden = YES;
        
    }
    return _commentView;
    
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    if ([keyPath  isEqual: @"change"]) {
//        
//        NSLog(@"____");
//    }
//    
//}
@end
