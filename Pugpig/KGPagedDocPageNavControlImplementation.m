//
//  KGPagedDocPageNavControlImplementation.m
//  BLS Tour
//
//  Created by Adam Luter on 8/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "KGPagedDocPageNavControlImplementation.h"

//==============================================================================
// MARK: - Private interface

@interface KGPagedDocPageNavControlImplementation()
- (void)initControl;
- (void)redrawContent;
- (void)redrawContentIfNeeded;
- (void)repositionContent;
- (void)updatePageControl;

@end

//==============================================================================
// MARK: - Main implementation

@implementation KGPagedDocPageNavControlImplementation

@dynamic active;
@synthesize numberOfPages;
@synthesize pageNumber;
@synthesize fractionalPageNumber;
@synthesize pageOrientation;
@synthesize dataSource;
@synthesize pageControl=_pageControl;

@synthesize portraitSize, landscapeSize;
@synthesize pageSize;

//------------------------------------------------------------------------------
// MARK: NSObject/UIView messages

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
    if (self) {
        [self initControl];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initControl];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    [_pageControl release];
}

- (void)didAddSubview:(UIView *)subview {
  if([subview isKindOfClass:[UIPageControl class]]) {
    [(UIPageControl *)subview addTarget:self action:@selector(pageControlValueChanged) forControlEvents:UIControlEventValueChanged];
    ((UIPageControl *)subview).currentPage = 0;
    ((UIPageControl *)subview).numberOfPages = 3;
  }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGSizeEqualToSize(lastLayoutSize, self.bounds.size)) {
        lastLayoutSize = self.bounds.size;
        [self redrawContent];
    }
}

//------------------------------------------------------------------------------
// MARK: Public properties

- (BOOL)isActive {
    return self.alpha > 0.0;
}

- (void)setActive:(BOOL)active {
    // always active
}

- (void)setNumberOfPages:(NSUInteger)newNumberOfPages {
    if (newNumberOfPages != numberOfPages) {
        numberOfPages = newNumberOfPages;
        pageNumber = 0;
        fractionalPageNumber = 0;
        [self repositionContent];
    }
}

- (void)setPageNumber:(NSUInteger)newPageNumber {
  if(pageNumber == newPageNumber) return;
  
  pageNumber = newPageNumber;
  self.fractionalPageNumber = pageNumber;
  [self repositionContent];
}

- (void)setPageOrientation:(KGOrientation)newPageOrientation {
    pageOrientation = newPageOrientation;
    pageSize = (pageOrientation == KGPortraitOrientation ? portraitSize : landscapeSize);
    [self repositionContent];
}

- (void)setDataSource:(id<KGPagedDocControlImageStore>)newDataSource {
    if (newDataSource != dataSource) {
        dataSource = newDataSource;
        [self redrawContent];
    }
}

//------------------------------------------------------------------------------
// MARK: Public messages


//------------------------------------------------------------------------------
// MARK: UIScrollView delegate messages

- (void)scrollViewWillBeginDragging:(UIScrollView *)sender
{
    [self redrawContentIfNeeded];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    [self redrawContentIfNeeded];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
    [self redrawContentIfNeeded];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)sender {
    [self redrawContentIfNeeded];
}

//------------------------------------------------------------------------------
// MARK: Private messages

- (void)initControl {
  self.alpha = 1.0;
  retinaScale = [UIScreen mainScreen].scale;
}

- (void)redrawContent {
    [self updatePageControl];
}

- (void)redrawContentIfNeeded {
    [self redrawContent];
}

- (void)repositionContent {
  [self updatePageControl];
}

- (void)updatePageControl {
  if( [self pageControl].currentPage == pageNumber && [self pageControl].numberOfPages == numberOfPages ) return;
  // page control freaks out a bit if you set number of pages to zero
  [self pageControl].numberOfPages = MAX(numberOfPages, 1);
  [self pageControl].currentPage = pageNumber;
}

- (void)pageControlValueChanged {
  if(pageNumber != [self pageControl].currentPage) {
    pageNumber = [self pageControl].currentPage;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
}

- (void)newImageForPageNumber:(NSUInteger)pageNumber orientation:(KGOrientation)orientation {
    // not needed for this kind of navigation
}

@end
