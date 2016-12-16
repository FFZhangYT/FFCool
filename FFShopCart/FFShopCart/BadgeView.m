//
//  BadgeView.m
//  FFShopCart
//
//  Created by andy on 16/12/17.
//  Copyright © 2016年 FFZ. All rights reserved.
//

#import "BadgeView.h"

@interface BadgeView ()

@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UILabel *textLabel;

@end

@implementation BadgeView

/*
 最简单的数字提示view,没有涉及到字体，边框，内容的自适应等
 */


-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string withTextColor:(UIColor *)textColor{
    
    return [self initWithFrame:frame withString:string];
}

-(instancetype)initWithFrame:(CGRect)frame withString:(NSString *)string{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = frame.size.height /2;
        //NSLog(@"%f,,,%f",frame.size.width, frame.size.height);
        
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        //self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.textLabel.font = [UIFont systemFontOfSize:10.0f];
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.text = string;
        
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addSubview:self.textLabel];
        
        self.backgroundColor = [UIColor blueColor];
        
        self.badgeValue = string;
        
    }
    return self;
}



-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    self.textLabel.text = badgeValue;
    
    if (!badgeValue || [badgeValue isEqualToString:@""] || ![badgeValue integerValue]) {
        self.hidden = YES;
    }
    else{
        self.hidden = NO;
    }
}

-(void)setUI{


}

@end
