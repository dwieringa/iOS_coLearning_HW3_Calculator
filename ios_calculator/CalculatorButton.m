//
//  CalculatorButton.m
//  ios_calculator
//
//  Created by David Wieringa on 5/19/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "CalculatorButton.h"

@implementation CalculatorButton

- (void)setup
{
    self.layer.cornerRadius = 8;
    self.layer.borderWidth = 1;
    self.layer.borderColor = self.tintColor.CGColor;
}

- (void)awakeFromNib { [self setup]; }

- (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    [self setup];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
