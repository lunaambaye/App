//
//  Note.h
//  Template
//
//  Created by R on 13/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject
@property(nonatomic, assign)int ID;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)NSString *detail;
@end
