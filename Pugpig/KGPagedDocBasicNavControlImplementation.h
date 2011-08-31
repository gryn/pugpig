//
//  KGPagedDocBasicNavControlImplementation.h
//  BLS Tour
//
//  Created by Adam Luter on 8/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGPagedDocControlNavigator.h"

@interface KGPagedDocBasicNavControlImplementation : UIControl<UIScrollViewDelegate,KGPagedDocControlNavigator> {
@private 
    CGSize lastLayoutSize;
    CGFloat retinaScale;
}
- (IBAction)pageLeft:(id)sender;
- (IBAction)pageRight:(id)sender;
@property (nonatomic, retain) IBOutlet UILabel *pageLabel;
@property (nonatomic, retain) IBOutlet UIToolbar *pageToolbar;

@property (nonatomic, assign, getter = isActive) BOOL active;
@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, assign) NSUInteger pageNumber;
@property (nonatomic, assign) CGFloat fractionalPageNumber;
@property (nonatomic, assign) KGOrientation pageOrientation;
@property (nonatomic, assign) id<KGPagedDocControlImageStore> dataSource;

@property (nonatomic, assign) CGSize portraitSize, landscapeSize;
@property (nonatomic, assign) CGSize pageSize;

- (void)newImageForPageNumber:(NSUInteger)pageNumber orientation:(KGOrientation)orientation;

@end

