//
//  FoodCell.h
//  FFShopCart
//
//  Created by andy on 16/12/17.
//  Copyright © 2016年 FFZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *plus;

@property (weak, nonatomic) IBOutlet UILabel *orderCount;

@property (assign, nonatomic) NSUInteger amount;

@property (copy, nonatomic) void (^plusBlock)(NSInteger count,BOOL animated);

@end
