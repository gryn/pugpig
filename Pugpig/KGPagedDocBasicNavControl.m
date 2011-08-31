//
//  KGPagedDocBasicNavControl.m
//  BLS Tour
//
//  Created by Adam Luter on 8/8/11.
//  Copyright 2011 N/A. All rights reserved.
//

#import "KGPagedDocBasicNavControl.h"
#import "KGPagedDocBasicNavControlImplementation.h"

@implementation KGPagedDocBasicNavControl

@dynamic active;
@dynamic numberOfPages;
@dynamic pageNumber;
@dynamic fractionalPageNumber;
@dynamic pageOrientation;
@dynamic dataSource;
@dynamic pageLabel;
@dynamic pageToolbar;

@dynamic portraitSize, landscapeSize;

+ (id)alloc {
    return [KGPagedDocBasicNavControlImplementation alloc];  
}

- (void)newImageForPageNumber:(NSUInteger)pageNumber orientation:(KGOrientation)orientation {
    // not needed for this kind of navigation
}
- (IBAction)pageLeft:(id)sender {
    // implemented later
}

- (IBAction)pageRight:(id)sender {
    // implemented later
}

@end
