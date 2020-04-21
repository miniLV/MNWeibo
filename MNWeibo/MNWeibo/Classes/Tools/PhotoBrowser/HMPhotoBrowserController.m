//
//  HMPhotoBrowserController.m
//  HMPhotoBrowser
//
//  Created by 刘凡 on 16/3/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "HMPhotoBrowserController.h"
#import "HMPhotoBrowserPhotos.h"
#import "HMPhotoViewerController.h"
#import "HMPhotoBrowserAnimator.h"

@interface HMPhotoBrowserController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation HMPhotoBrowserController {
    HMPhotoBrowserPhotos *_photos;
    BOOL _statusBarHidden;
    HMPhotoBrowserAnimator *_animator;
    
    HMPhotoViewerController *_currentViewer;
    UIButton *_pageCountButton;
    UILabel *_messageLabel;
}

#pragma mark - 构造函数
+ (instancetype)photoBrowserWithSelectedIndex:(NSInteger)selectedIndex urls:(NSArray<NSString *> *)urls parentImageViews:(NSArray<UIImageView *> *)parentImageViews {
    return [[self alloc] initWithSelectedIndex:selectedIndex
                                          urls:urls
                              parentImageViews:parentImageViews];
}

- (instancetype)initWithSelectedIndex:(NSInteger)selectedIndex urls:(NSArray<NSString *> *)urls parentImageViews:(NSArray<UIImageView *> *)parentImageViews {
    
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _photos = [[HMPhotoBrowserPhotos alloc] init];
        
        _photos.selectedIndex = selectedIndex;
        _photos.urls = urls;
        _photos.parentImageViews = parentImageViews;
        
        _statusBarHidden = NO;
        
        self.modalPresentationStyle = UIModalPresentationCustom;
        _animator = [HMPhotoBrowserAnimator animatorWithPhotos:_photos];
        self.transitioningDelegate = _animator;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _statusBarHidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    _statusBarHidden = NO;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)prefersStatusBarHidden {
    return _statusBarHidden;
}

#pragma mark - 监听方法
- (void)tapGesture {
    _animator.fromImageView = _currentViewer.imageView;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)interactiveGesture:(UIGestureRecognizer *)recognizer {
    
    _statusBarHidden = (_currentViewer.scrollView.zoomScale > 1.0);
    [self setNeedsStatusBarAppearanceUpdate];
    
    if (_statusBarHidden) {
        self.view.backgroundColor = [UIColor blackColor];
        self.view.transform = CGAffineTransformIdentity;
        self.view.alpha = 1.0;
        _pageCountButton.hidden = (_photos.urls.count == 1);
        
        return;
    }
    
    CGAffineTransform transfrom = self.view.transform;
    
    if ([recognizer isKindOfClass:[UIPinchGestureRecognizer class]]) {
        UIPinchGestureRecognizer *pinch = (UIPinchGestureRecognizer *)recognizer;
        
        CGFloat scale = pinch.scale;
        transfrom = CGAffineTransformScale(transfrom, scale, scale);
        
        pinch.scale = 1.0;
    } else if ([recognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
        UIRotationGestureRecognizer *rotate = (UIRotationGestureRecognizer *)recognizer;
        
        CGFloat rotation = rotate.rotation;
        transfrom = CGAffineTransformRotate(transfrom, rotation);
        
        rotate.rotation = 0;
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            _pageCountButton.hidden = YES;
            self.view.backgroundColor = [UIColor clearColor];
            self.view.transform = transfrom;
            self.view.alpha = transfrom.a;
            
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateEnded:
            [self tapGesture];
            break;
        default:
            break;
    }
}

- (void)longPressGesture:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    if (_currentViewer.imageView.image == nil) {
        return;
    }
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"保存至相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(_currentViewer.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    NSString *message = (error == nil) ? @"保存成功" : @"保存失败";
    
    _messageLabel.text = message;
    
    [UIView
     animateWithDuration:0.7
     delay:0
     usingSpringWithDamping:0.8
     initialSpringVelocity:10
     options:0
     animations:^{
         _messageLabel.transform = CGAffineTransformIdentity;
     } completion:^(BOOL finished) {
         [UIView animateWithDuration:0.5 animations:^{
             _messageLabel.transform = CGAffineTransformMakeScale(0, 0);
         }];
     }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(HMPhotoViewerController *)viewController {
    
    NSInteger index = viewController.photoIndex;
    
    if (index-- <= 0) {
        return nil;
    }
    
    return [self viewerWithIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(HMPhotoViewerController *)viewController {
    
    NSInteger index = viewController.photoIndex;
    
    if (++index >= _photos.urls.count) {
        return nil;
    }
    
    return [self viewerWithIndex:index];
}

- (HMPhotoViewerController *)viewerWithIndex:(NSInteger)index {
    return [HMPhotoViewerController viewerWithURLString:_photos.urls[index] photoIndex:index placeholder:_photos.parentImageViews[index].image];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    HMPhotoViewerController *viewer = pageViewController.viewControllers[0];
    
    _photos.selectedIndex = viewer.photoIndex;
    _currentViewer = viewer;
    
    [self setPageButtonIndex:viewer.photoIndex];
}

- (void)setPageButtonIndex:(NSInteger)index {
    _pageCountButton.hidden = (_photos.urls.count == 1);
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc]
                                                initWithString:[NSString stringWithFormat:@"%zd", index + 1]
                                                attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                                             NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [attributeText appendAttributedString:[[NSAttributedString alloc]
                                           initWithString:[NSString stringWithFormat:@" / %zd", _photos.urls.count]
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14],
                                                        NSForegroundColorAttributeName: [UIColor whiteColor]}]];
    [_pageCountButton setAttributedTitle:attributeText forState:UIControlStateNormal];
}

#pragma mark - 设置界面
- (void)prepareUI {
    self.view.backgroundColor = [UIColor blackColor];
    
    // 分页控制器
    UIPageViewController *pageController = [[UIPageViewController alloc]
                                            initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                            navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                            options:@{UIPageViewControllerOptionInterPageSpacingKey: @20}];
    pageController.dataSource = self;
    pageController.delegate = self;
    
    HMPhotoViewerController *viewer = [self viewerWithIndex:_photos.selectedIndex];
    [pageController setViewControllers:@[viewer]
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:YES
                            completion:nil];
    
    [self.view addSubview:pageController.view];
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    
    _currentViewer = viewer;
    
    // 手势识别
    self.view.gestureRecognizers = pageController.gestureRecognizers;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.view addGestureRecognizer:tap];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveGesture:)];
    [self.view addGestureRecognizer:pinch];
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(interactiveGesture:)];
    [self.view addGestureRecognizer:rotate];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    [self.view addGestureRecognizer:longPress];
    
    pinch.delegate = self;
    rotate.delegate = self;
    
    // 分页按钮
    _pageCountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    CGPoint center = self.view.center;
    center.y = _pageCountButton.bounds.size.height;
    _pageCountButton.center = center;
    
    _pageCountButton.layer.cornerRadius = 6;
    _pageCountButton.layer.masksToBounds = YES;
    
    _pageCountButton.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.6];
    [self setPageButtonIndex:_photos.selectedIndex];
    [self.view addSubview:_pageCountButton];
    
    // 提示标签
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 60)];
    _messageLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.layer.cornerRadius = 6;
    _messageLabel.layer.masksToBounds = YES;
    _messageLabel.transform = CGAffineTransformMakeScale(0, 0);
    
    _messageLabel.center = self.view.center;
    [self.view addSubview:_messageLabel];
}

@end
