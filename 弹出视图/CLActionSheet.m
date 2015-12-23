//
//  CLActionSheet.m
//  弹出视图
//
//  Created by zyyt on 15/12/23.
//  Copyright © 2015年 zyyt. All rights reserved.
//

#import "CLActionSheet.h"

@interface CLActionSheet()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak)UIButton *backButton;
@property (nonatomic,weak)UIButton *cancelButton;
@property (nonatomic,weak)UIWindow *currentWindow;
@property (nonatomic,weak)UICollectionView *collection;
@property (nonatomic,weak)UIPageControl *page;
@end

@implementation CLActionSheet

+ (id)actionSheet{
    
    return [[self alloc]init];
    
}
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 260);
        [self collection];
        [self cancelButton];
        [self page];
        [self backButton];
        
        UIWindow * currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:self];

    }
    return self;
}
- (UICollectionView *)collection{
    if (_collection == nil) {
        double size = ([UIScreen mainScreen].bounds.size.width - 50)/4.0;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //item行间距
        flowLayout.minimumLineSpacing = 10;//默认10
        flowLayout.minimumInteritemSpacing = 10;//默认10
        //设置统一大小的item
        flowLayout.itemSize = CGSizeMake(size, 80);//默认50
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);//边距屏幕宽
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width , 80 * 2 + 30)  collectionViewLayout:flowLayout];
        collection.showsHorizontalScrollIndicator = NO;
        collection.pagingEnabled = YES;
        collection.delegate = self;
        collection.dataSource = self;
        [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:collection];
        _collection = collection;
    }
    return _collection;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.page.currentPage = (scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width)==0?0:1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 16;
    
}
#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row % 2== 0) {
        
        cell.backgroundColor = [UIColor redColor];
        
    }else{
        
        
        cell.backgroundColor = [UIColor grayColor];
        
    }
    
    
    return cell;
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(cellNumberWithInteger:)]) {
        
        [self.delegate cellNumberWithInteger:indexPath.row];
    }
}
- (UIPageControl *)page{
    if (_page == nil) {
        
        UIPageControl *page = [[UIPageControl alloc]init];
        page.numberOfPages = 2;
        page.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, self.bounds.size.height-60);
        [self addSubview:page];
        _page = page;
    }
    return _page;
}
- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 60, 44);
        button.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, self.bounds.size.height-30);
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _cancelButton = button;
    }
    return _cancelButton;
}
- (UIButton *)backButton{
    if (_backButton == nil) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = [UIScreen mainScreen].bounds;
        button.backgroundColor = [UIColor grayColor];
        button.alpha = 0.5;
        [button addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
        UIWindow * currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:button];
        _backButton = button;

    }
    return _backButton;
}

- (void)backButton:(UIButton *)button{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 260);
    } completion:^(BOOL finished) {
        [self.backButton removeFromSuperview];
        [self removeFromSuperview];

    }];
}
- (void)show{
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 260, [UIScreen mainScreen].bounds.size.width, 260);
        
    } completion:^(BOOL finished) {
    }];
}

@end
