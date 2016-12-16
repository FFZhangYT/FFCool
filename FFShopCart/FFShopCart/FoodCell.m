//
//  FoodCell.m
//  FFShopCart
//
//  Created by andy on 16/12/17.
//  Copyright © 2016年 FFZ. All rights reserved.
//

#import "FoodCell.h"

@implementation FoodCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.amount = 0;
}



- (IBAction)plus:(id)sender {
    
    self.amount += 1;
    self.plusBlock(self.amount,YES);
    self.orderCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.amount];
}

@end
