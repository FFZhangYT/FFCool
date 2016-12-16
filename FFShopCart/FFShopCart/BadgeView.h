//
//  BadgeView.h
//  FFShopCart
//
//  Created by andy on 16/12/17.
//  Copyright © 2016年 FFZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView

-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string;

-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string withTextColor:(UIColor *)textColor;

@property (nonatomic,strong) NSString *badgeValue;

@end
