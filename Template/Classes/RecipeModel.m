//
//  RecipeModel.m
//  Template
//
//  Created by Karim on 18/4/17.
//  Copyright © 2017 ExpressTemplate. All rights reserved.
//

#import "RecipeModel.h"
#import "ContextManager.h"
#import "DataManager.h"

@implementation RecipeModel

@dynamic detail;
@dynamic id;
@dynamic ingredients;
@dynamic name;
@dynamic person;
@dynamic time;
@dynamic favorite;
@dynamic image;
@dynamic imageURL;

@synthesize foundCount = _foundCount;

dispatch_queue_t backgroundQueue;

+ (void)initialize {
    [super initialize];
    backgroundQueue = dispatch_queue_create("backgroundqueue", NULL);
}

+ (void)loadRecipes {
    dispatch_async(backgroundQueue,^(void) {
        [DataManager getAllDataWithCompletion:^{
            dispatch_async(dispatch_get_main_queue(),^(void) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RecipesLoaded" object:nil];
            });
        }];
        [[ContextManager sharedManager] saveContext:nil];
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
        [request setPredicate:[NSPredicate predicateWithFormat:@"(image == nil)"]];
        NSArray *response =	[[ContextManager sharedManager] executeFetchRequest:request error:nil];
        
        for (RecipeModel *recipe in response) {
            [recipe loadImage];
        }
    });
}

+ (NSArray *)allRecipes {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];

    NSError *error;
    NSArray *response =	[[ContextManager sharedManager] executeFetchRequest:request error:&error];
    
    if(error)
        return @[];

    return response;
}

+ (NSArray *)allFavoriteRecipes {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(favorite == true)"]];
    
    NSError *error;
    NSArray *response =	[[ContextManager sharedManager] executeFetchRequest:request error:&error];
    
    for (RecipeModel *recipe in response) {
        NSLog(@"F %d",recipe.favorite.boolValue);
    }
    
    if(error)
        return @[];
    
    return response;
}

+ (instancetype)existingOrNew:(NSDictionary *)dict {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(id == %@)",[dict[@"id"] stringValue]]];
    request.fetchLimit = 1;
    
    NSError *error;
    NSArray *response =	[[ContextManager sharedManager] executeFetchRequest:request error:&error];
    
    if(error)
        return nil;
    
    if (response.count) {
        return response[0];
    }else{
        return [self createNew:dict];
    }
}

+ (instancetype)createNew:(NSDictionary *)dict {
    RecipeModel *recipe = [ContextManager insertNewObjectForEntityForName:@"Recipe"];
    recipe.id = [dict[@"id"] stringValue];
    
    [[ContextManager sharedManager] saveContext:nil];
    return recipe;
    
}

- (void)loadImage {
    
    dispatch_async(backgroundQueue,^(void) {
        self.image = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.imageURL]];
        dispatch_async(dispatch_get_main_queue(),^(void) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RecipesImageLoaded" object:self];
        });
        [[ContextManager sharedManager] saveContext:nil];
    });
}

@end
