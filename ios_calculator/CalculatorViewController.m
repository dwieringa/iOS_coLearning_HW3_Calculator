//
//  CalculatorViewController.m
//  ios_calculator
//
//  Created by David Wieringa on 5/17/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (weak, nonatomic) IBOutlet UITextField *operand1;
@property (weak, nonatomic) IBOutlet UITextField *operator;
@property (weak, nonatomic) IBOutlet UITextField *operand2;
@property (nonatomic) BOOL operand2IsResult;
@end

@implementation CalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

NSString *valueAsString(double value)
{
    return [NSString stringWithFormat:@"%.9g",value];
}

- (IBAction)numberPress:(UIButton *)sender
{
    // if operand2 is showing the result of the last operation, don't allow it to be appended...replace it
    if (self.operand2IsResult) {
        self.operand2.text = @"";
        self.operand2IsResult = NO;
    }
    
    // if operand2 is initial 0, replace it (don't let numbers start with one or more 0's
    if ([self.operand2.text isEqualToString:@"0"]) {
        self.operand2.text = @"";
    }
    
    // append digit to operand
    self.operand2.text = [self.operand2.text stringByAppendingString:sender.currentTitle];
}

- (IBAction)decimalPress:(UIButton *)sender
{
    if ([self.operand2.text rangeOfString:@"."].location == NSNotFound) {
        self.operand2.text = [self.operand2.text stringByAppendingString:sender.currentTitle];
    }
}

- (IBAction)plusMinusPress:(id)sender
{
    if (![self.operand2.text isEqualToString:@""]) {
        NSString *firstChar = [self.operand2.text substringToIndex:1];
        if ([firstChar isEqualToString:@"-"]) {
            self.operand2.text = [self.operand2.text substringFromIndex:1];
        } else {
            self.operand2.text = [@"-" stringByAppendingString:self.operand2.text];
        }
    }
}

- (IBAction)percentPress:(UIButton *)sender {
    double value = [self.operand2.text doubleValue];
    self.operand2.text = valueAsString(value/100);

}

- (IBAction)operatorPress:(UIButton *)sender
{
    // compute result using previous operator (if any)
    double val1 = [self.operand1.text doubleValue];
    double val2 = [self.operand2.text doubleValue];
    double result = 0;
    NSString *prevOperator = self.operator.text;
    if ([prevOperator isEqualToString:@"+"]) { // NOTE: special character from Ctrl-Cmd-SpaceBar to match button
        result = val1 + val2;
    } else if ([prevOperator isEqualToString:@"−"]) {
        result = val1 - val2;
    } else if ([prevOperator isEqualToString:@"×"]) {
        result = val1 * val2;
    } else if ([prevOperator isEqualToString:@"÷"]) {
        result = val1 / val2;
    } else if ([prevOperator isEqualToString:@""]) {
        result = val2;
    }
    
    // update display
    if ([sender.currentTitle isEqualToString:@"="]) {
        self.operand1.text = @"";
        self.operator.text = @"";
        self.operand2.text = valueAsString(result);
        self.operand2IsResult = YES;
    } else {
        self.operand1.text = valueAsString(result);
        self.operator.text = sender.currentTitle;
        self.operand2.text = @"";
    }
}

- (IBAction)clearPress:(UIButton *)sender
{
    if ([self.operand2.text length]) {
        self.operand2.text = @"";
    } else if ([self.operator.text length]) {
        self.operand2.text = self.operand1.text;
        self.operand1.text = @"";
        self.operator.text = @"";
    } else {
        self.operand1.text = @"";
    }
        
}

@end
