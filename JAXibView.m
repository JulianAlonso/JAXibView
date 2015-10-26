//
//  JAXibView.m
//  KinoApp
//
//  Created by Julian Alonso on 30/7/15.
//  Copyright (c) 2015 Julian. All rights reserved.
//

#import "JAXibView.h"

@interface JAXibView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *customConstraints;

@end

@implementation JAXibView

#pragma mark - Init methods.
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    
    if (self)
    {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    _customConstraints = [NSMutableArray new];
    UIView *view = nil;
    NSArray *objects = [[NSBundle bundleForClass:[self class]] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    
    self.backgroundColor = [UIColor clearColor];
    
    for (id object in objects)
    {
        if ([object isKindOfClass:[UIView class]])
        {
            view = object;
            break;
        }
    }
    
    if (view)
    {
        _containerView = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self setNeedsUpdateConstraints];
    }
}

#pragma mark - Update methods.
- (void)updateConstraints
{
    [self removeConstraints:self.customConstraints];
    [self.customConstraints removeAllObjects];
    
    if (self.containerView)
    {
        UIView *view = self.containerView;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(view);
        
        [self.customConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:views]];
        [self.customConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
        
        [self addConstraints:self.customConstraints];
    }
    
    [super updateConstraints];
}

@end
