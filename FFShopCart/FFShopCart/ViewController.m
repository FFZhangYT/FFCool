//
//  ViewController.m
//  FFShopCart
//
//  Created by andy on 16/12/17.
//  Copyright © 2016年 FFZ. All rights reserved.
//

#import "ViewController.h"
#import "FoodCell.h"

#import "ShoppingCartView.h"
#import "BadgeView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,CAAnimationDelegate>

@property (nonatomic,strong) CALayer *dotLayer;

@property (nonatomic,assign) CGFloat endPointX;

@property (nonatomic,assign) CGFloat endPointY;

@property (nonatomic,strong) UIBezierPath *path;

@property (nonatomic,strong) UITableView *tableView ;

@property (nonatomic,assign) NSUInteger totalOrders;

@property (nonatomic,strong) ShoppingCartView *ShopCartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20 - 50)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
    _ShopCartView = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, CGRectGetWidth(self.view.bounds), 50)];

    [self.view addSubview:_ShopCartView];

    
    CGRect rect = [self.view convertRect:_ShopCartView.shoppingCartBtn.frame fromView:_ShopCartView];
   
    _endPointX = rect.origin.x + 15;
    _endPointY = rect.origin.y + 35;
  
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 10;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        static NSString *cellID = @"FoodCell";
        
        FoodCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:nil options:nil] lastObject];
            
            __weak __typeof(&*cell)weakCell =cell;
            cell.plusBlock = ^(NSInteger nCount,BOOL animated){
                
                CGRect parentRect = [weakCell convertRect:weakCell.plus.frame toView:self.view];
            
                if (animated) {
                    [self JoinCartAnimationWithRect:parentRect];
                    _totalOrders ++;
                }
                _ShopCartView.badge.badgeValue = [NSString stringWithFormat:@"%lu",(unsigned long)_totalOrders];
               
            };
        
    }
    

    return cell;
}

#pragma mark -加入购物车动画
-(void) JoinCartAnimationWithRect:(CGRect)rect
{

    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPointX, _endPointY)
                  controlPoint1:CGPointMake(startX, startY)
                  controlPoint2:CGPointMake(startX - 180, startY - 200)];

    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor blueColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 15, 15);
    _dotLayer.cornerRadius = (15 + 15) /4;
    [self.view.layer addSublayer:_dotLayer];
    [self groupAnimation];
    
}
#pragma mark - 组合动画
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;

    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    //控制动画运行的节奏
    /*
     kCAMediaTimingFunctionLinear
     kCAMediaTimingFunctionEaseOut
     kCAMediaTimingFunctionEaseIn
     kCAMediaTimingFunctionEaseInEaseOut
     */
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.delegate=self;
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    //和下面一行连着用，填充动画的模式
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.8f];
 
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //[[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]同样
    if([anim isKindOfClass:[CAAnimationGroup class]]){
    
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.15f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:1];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1.2];
        shakeAnimation.repeatCount = 0.5;
        shakeAnimation.autoreverses = YES;
        
        [_ShopCartView.shoppingCartBtn.layer addAnimation:shakeAnimation forKey:nil];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


@end
