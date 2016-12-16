//
//  ShoppingCartView.m
//  FFShopCart
//
//  Created by andy on 16/12/17.
//  Copyright © 2016年 FFZ. All rights reserved.
//

#import "ShoppingCartView.h"
#import "BadgeView.h"
#define SECTION_HEIGHT 30.0
#define ROW_HEIGHT 50.0


@interface ShoppingCartView ()

@end

@implementation ShoppingCartView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      [self layoutUI];
    }
    return self;
}


-(void)layoutUI{
    //购物车
    _shoppingCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shoppingCartBtn.userInteractionEnabled = NO;
    _shoppingCartBtn.backgroundColor = [self getColor:@"#61DB6D"];
    _shoppingCartBtn.layer.cornerRadius = 10;
    _shoppingCartBtn.frame = CGRectMake(15, -25, 54,54);
    [self addSubview:_shoppingCartBtn];
    
    if (!_badge) {
        _badge = [[BadgeView alloc] initWithFrame:CGRectMake(_shoppingCartBtn.frame.size.width - 10, 5, 17, 17) withString:@"wwwww"];
        [_shoppingCartBtn addSubview:_badge];
    }
    self.backgroundColor = [self getColor:@"#157EFB"];
}


- (UIColor *)getColor:(NSString*)hexColor{
    
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
}







@end
