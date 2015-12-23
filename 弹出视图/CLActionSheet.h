//
//  CLActionSheet.h
//  弹出视图
//
//  Created by zyyt on 15/12/23.
//  Copyright © 2015年 zyyt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLActionSheet;

@protocol CLActionSheetDelegte <NSObject>

- (void)cellNumberWithInteger:(NSInteger)number;

@end

@interface CLActionSheet : UIView

@property (weak,nonatomic) id<CLActionSheetDelegte>delegate;

+ (id)actionSheet;

- (void)show;

@end
