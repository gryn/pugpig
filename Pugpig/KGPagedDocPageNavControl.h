//
//  KGPagedDocPageNavControl.h
//  BLS Tour
//
//  Created by Adam Luter on 8/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGPagedDocControlNavigator.h"
#import "KGPagedDocControlImageStore.h"

@interface KGPagedDocPageNavControl : UIControl<KGPagedDocControlNavigator> {
}
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

@property (nonatomic, assign, getter = isActive) BOOL active;
@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, assign) NSUInteger pageNumber;
@property (nonatomic, assign) CGFloat fractionalPageNumber;
@property (nonatomic, assign) KGOrientation pageOrientation;
@property (nonatomic, assign) id<KGPagedDocControlImageStore> dataSource;

@property (nonatomic, assign) CGSize portraitSize, landscapeSize;

- (void)newImageForPageNumber:(NSUInteger)pageNumber orientation:(KGOrientation)orientation;

@end
