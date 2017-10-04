//
//  AppDelegate.h
//  Recipe
//
//  Created by R on 06/04/2016.
//  Copyright (c) 2016 ExpressTemplate. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "Static.h"
#import "AppDelegate.h"
#import "Note.h"
#import "Item.h"
#import "RecipeModel.h"

typedef void (^DataManagerCompletionHandler)();

@interface DataManager : NSObject

-(void)openDatabase;
+(void)getAllData:(NSString *)strCategory withCompletion:(DataManagerCompletionHandler)completion;
+(void)getAllDataWithCompletion:(DataManagerCompletionHandler)completion;
//+(NSMutableArray*)getAllData:(NSString *)strCategory;
//+(NSMutableArray*)getFevouriteAllData;
//+(void)updateFevoriteData:(RecipeModel *)obj;
//+(NSMutableArray*)getAllCategories;
+(NSMutableArray*)getAllNote;
+(void)insertNoteData:(Note*)obj;
+(void) deleteAllNote;
+(void)deleteNoteFromID:(int)ID;
+(NSMutableArray*)getAllShoppingList;
+(void)insertShoppingList:(Item *)obj;
+(void)deleteAllShoppingList;
+(void)updateMarkAsPurchased:(Item *)obj;
+(Item*)checkIsPurchased:(int)ID;
@end
