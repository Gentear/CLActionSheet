//
//  ViewController.m
//  弹出视图
//
//  Created by zyyt on 15/12/23.
//  Copyright © 2015年 zyyt. All rights reserved.
//

#import "ViewController.h"
#import "CLActionSheet.h"
@interface ViewController ()<CLActionSheetDelegte>
@property (nonatomic,weak)CLActionSheet *cl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (CLActionSheet *)cl{
    if (_cl == nil) {
        
        CLActionSheet *cl = [CLActionSheet actionSheet];
//        [cl show];
        cl.delegate = self;
        _cl = cl;
    }
    return _cl;
}
- (IBAction)buttonClick:(id)sender {
    
    [self.cl show];

}
- (void)cellNumberWithInteger:(NSInteger)number{
    NSLog(@"%ld",(long)number);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
