//
//  KGPagedDocPageNavControl.m
//  BLS Tour
//
//  Created by Adam Luter on 8/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "KGPagedDocPageNavControl.h"
#import "KGPagedDocPageNavControlImplementation.h"

@implementation KGPagedDocPageNavControl

@dynamic active;
@dynamic numberOfPages;
@dynamic pageNumber;
@dynamic fractionalPageNumber;
@dynamic pageOrientation;
@dynamic dataSource;
@dynamic pageControl;

@dynamic portraitSize, landscapeSize;

+ (id)alloc {
    return (id)[KGPagedDocPageNavControlImplementation alloc];  
}

- (void)newImageForPageNumber:(NSUInteger)pageNumber orientation:(KGOrientation)orientation {
    // not needed for this kind of navigation
}

@end
