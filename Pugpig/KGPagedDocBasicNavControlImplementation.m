//
//  KGPagedDocBasicNavControlImplementation.m
//  BLS Tour
//
//  Created by Adam Luter on 8/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "KGPagedDocBasicNavControlImplementation.h"

//==============================================================================
// MARK: - Private interface

@interface KGPagedDocBasicNavControlImplementation()
- (void)initControl;
- (void)redrawContent;
- (void)redrawContentIfNeeded;
- (void)repositionContent;
- (void)selectPage:(UIGestureRecognizer*)gesture;
- (void)updatePageLabel;

@end

//==============================================================================
// MARK: - Main implementation

@implementation KGPagedDocBasicNavControlImplementation

@dynamic active;
@synthesize numberOfPages;
@synthesize pageNumber;
@synthesize fractionalPageNumber;
@synthesize pageOrientation;
@synthesize dataSource;
@synthesize pageLabel=_pageLabel;
@synthesize pageToolbar;

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
    [_pageLabel release];
  [pageToolbar release];
}

- (void)didAddSubview:(UIView *)subview {
  if([subview isKindOfClass:[UIToolbar class]]) {
    [(UIToolbar *)subview setTintColor:[UIColor colorWithWhite:0 alpha:0.8]];
  }
}

- (void)viewDidUnload {
    [self setPageLabel:nil];
  [self setPageToolbar:nil];
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
    pageNumber = newPageNumber;
    self.fractionalPageNumber = pageNumber;
    [self updatePageLabel];
}

- (void)setFractionalPageNumber:(CGFloat)newFractionalPageNumber {
    if (newFractionalPageNumber != fractionalPageNumber) {
        fractionalPageNumber = newFractionalPageNumber;
        [self repositionContent];
        [self updatePageLabel];
    }
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
    [self updatePageLabel];
}

- (void)redrawContentIfNeeded {
    [self redrawContent];
}

- (void)repositionContent {

}

- (void)selectPage:(UIGestureRecognizer*)gesture {
    /*
    CGPoint tapPoint = [gesture locationInView:scrollView];
    CGFloat padding = self.horizontalPadding;
    NSInteger page = floor((tapPoint.x - padding + pageSeparation/2) / (pageSize.width + pageSeparation));
    if (page >= 0 && page < numberOfPages) {
        pageNumber = page;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    */
}
- (IBAction)pageLeft:(id)sender {
    if(self.pageNumber <= 0) return;
    self.pageNumber -= 1;
    [self updatePageLabel];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (IBAction)pageRight:(id)sender {
    if(self.pageNumber >= self.numberOfPages-1) return;
    self.pageNumber += 1;
    [self updatePageLabel];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)updatePageLabel {
    if(self.pageLabel == nil) return;
    NSString* newValue = [NSString stringWithFormat:@"Page %d of %d", pageNumber+1, numberOfPages];
    [self.pageLabel setText:newValue];
}

- (void)newImageForPageNumber:(NSUInteger)pageNumber orientation:(KGOrientation)orientation {
    // not needed for this kind of navigation
}

/* don't need this, it lets you have touch-through areas of a view.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView * view in [self subviews])
    {
        if (!view.hidden && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
        {
            return YES;
        }
    }
    return NO;
}*/

@end
