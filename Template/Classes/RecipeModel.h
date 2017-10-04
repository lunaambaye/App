//
//  RecipeModel.h
//  Template
//
//  Created by Karim on 18/4/17.
//  Copyright © 2017 ExpressTemplate. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecipeModel : NSManagedObject

@property (nullable, nonatomic, retain) NSString *detail;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSString *ingredients;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *person;
@property (nullable, nonatomic, retain) NSString *time;
@property (nullable, nonatomic, retain) NSNumber *favorite;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSString *imageURL;

@property (nonatomic, assign) NSInteger foundCount;

+ (void)loadRecipes;
+ (NSArray *)allRecipes;
+ (NSArray *)allFavoriteRecipes;

+ (instancetype)existingOrNew:(NSDictionary *)dict;
+ (instancetype)createNew:(NSDictionary *)dict;

- (void)loadImage;

@end

NS_ASSUME_NONNULL_END
