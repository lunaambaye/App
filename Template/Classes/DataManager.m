#import "DataManager.h"
#import <sqlite3.h>
#import "UNIRest.h"
#import "Utility.h"
#import "RecipeModel.h"
@implementation DataManager

static sqlite3 *database;

-(void)openDatabase
{
    [Utility copyDatabaseIfNeeded];
    sqlite3_open([[Utility getDBPath] UTF8String], &database);
}
#pragma mark get all data

+(void)getAllData:(NSString *)strCategory withCompletion:(DataManagerCompletionHandler)completion
{
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"DCqLFRjlIDmsh5wGpoqEqHRqSvNXp1MK9SkjsnQim1ZCzxwrsH", @"Accept": @"application/json"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=16&tags="];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        
        if (code == 200) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (id recipe in response.body.object[@"recipes"]) {
                RecipeModel *obj = [RecipeModel existingOrNew:recipe];
                obj.id = [recipe[@"id"] stringValue];
                obj.name = recipe[@"title"];
                obj.imageURL = recipe[@"image"];
                [obj loadImage];
                //obj.image = recipe[@"image"];
                //obj.category = recipe[@""];
                
                NSMutableString *ingredients = [[NSMutableString alloc] init];
                for (id ingredient in recipe[@"extendedIngredients"]) {
                    [ingredients appendFormat:@"%@\n",ingredient[@"originalString"]];
                }
                
                obj.ingredients = ingredients;
                
                obj.detail = recipe[@"instructions"];
                obj.time = [recipe[@"readyInMinutes"] stringValue];
                obj.person = [recipe[@"servings"] stringValue];
                //obj.video = nil;
                obj.favorite = @(NO);
                [array addObject:obj];
            }
            //completion(array,nil);
        }else{
            NSError *err = [NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey:@"There was an error wihle loading recipes."}];
            completion(nil, err);
        }
        
    }];
    [asyncConnection start];
}

+(void)getAllDataWithCompletion:(DataManagerCompletionHandler)completion
{
    // These code snippets use an open-source library. http://unirest.io/objective-c
    NSDictionary *headers = @{@"X-Mashape-Key": @"DCqLFRjlIDmsh5wGpoqEqHRqSvNXp1MK9SkjsnQim1ZCzxwrsH", @"Accept": @"application/json"};
    UNIUrlConnection *asyncConnection = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:@"https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/random?limitLicense=false&number=16&tags="];
        [request setHeaders:headers];
    }] asJsonAsync:^(UNIHTTPJsonResponse *response, NSError *error) {
        NSInteger code = response.code;
        
        if (code == 200) {
            for (id recipe in response.body.object[@"recipes"]) {
                RecipeModel *obj = [RecipeModel existingOrNew:recipe];
                obj.id = [recipe[@"id"] stringValue];
                obj.name = recipe[@"title"];
                obj.imageURL = recipe[@"image"];
                [obj loadImage];
                
                NSMutableString *ingredients = [[NSMutableString alloc] init];
                for (id ingredient in recipe[@"extendedIngredients"]) {
                    [ingredients appendFormat:@"%@\n",ingredient[@"originalString"]];
                }
                
                obj.ingredients = ingredients;
                
                obj.detail = recipe[@"instructions"];
                obj.time = [recipe[@"readyInMinutes"] stringValue];
                obj.person = [recipe[@"servings"] stringValue];
                obj.favorite = @(NO);
            }
            completion();
        }else{
            NSError *err = [NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey:@"There was an error wihle loading recipes."}];
            completion(nil, err);
        }
        
    }];
    [asyncConnection start];
}

/*+(NSMutableArray*)getAllData:(NSString *)strCategory
{
    NSString *strSql;
    if (strCategory.length==0) {
        strSql = [NSString stringWithFormat:@"select ID,name,image,category,detail,ingredient,time,person,video,is_favourite from tblRecipe"];
    }
    else{
        strSql = [NSString stringWithFormat:@"select ID,name,image,category,detail,ingredient,time,person,video,is_favourite from tblRecipe where category='%@'",strCategory];
    }
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    NSMutableArray *arrData;
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        arrData = [[NSMutableArray alloc] init];
        while(sqlite3_step(selectstmt) == SQLITE_ROW) {
            Recipe *obj = [[Recipe alloc] init];
            obj.ID = sqlite3_column_int(selectstmt, 0);
            obj.name =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)?(char *)sqlite3_column_text(selectstmt, 1):""];
            obj.image =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)?(char *)sqlite3_column_text(selectstmt, 2):""];
            obj.category = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)?(char *)sqlite3_column_text(selectstmt, 3):""];
            obj.detail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)?(char *)sqlite3_column_text(selectstmt, 4):""];
            obj.ingredient = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)?(char *)sqlite3_column_text(selectstmt, 5):""];
            obj.time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 6)?(char *)sqlite3_column_text(selectstmt, 6):""];
            obj.person = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 7)?(char *)sqlite3_column_text(selectstmt, 7):""];
            obj.video = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)?(char *)sqlite3_column_text(selectstmt, 8):""];
            obj.is_favourite = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 9)?(char *)sqlite3_column_text(selectstmt, 9):""];
            [arrData addObject:obj];
        }
    }
    return arrData;
}
#pragma mark get all data
+(NSMutableArray*)getAllCategories
{
    NSString *strSql = [NSString stringWithFormat:@"SELECT DISTINCT category from tblRecipe"];
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    NSMutableArray *arrData;
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        arrData = [[NSMutableArray alloc] init];
        while(sqlite3_step(selectstmt) == SQLITE_ROW) {
            Recipe *obj = [[Recipe alloc] init];
            obj.category = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)?(char *)sqlite3_column_text(selectstmt, 0):""];
            [arrData addObject:obj];
        }
    }
    return arrData;
}*/
#pragma mark get all fevourite data
/*+(NSMutableArray*)getFevouriteAllData
{
    NSString *strSql = [NSString stringWithFormat:@"select ID,name,image,category,detail,ingredient,time,person,video,is_favourite from tblRecipe where is_favourite='y'"];
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    NSMutableArray *arrData;
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        arrData = [[NSMutableArray alloc] init];
        while(sqlite3_step(selectstmt) == SQLITE_ROW) {
            Recipe *obj = [[Recipe alloc] init];
            obj.ID = sqlite3_column_int(selectstmt, 0);
            obj.name =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)?(char *)sqlite3_column_text(selectstmt, 1):""];
            obj.image =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)?(char *)sqlite3_column_text(selectstmt, 2):""];
            obj.category = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)?(char *)sqlite3_column_text(selectstmt, 3):""];
            obj.detail = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)?(char *)sqlite3_column_text(selectstmt, 4):""];
            obj.ingredient = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)?(char *)sqlite3_column_text(selectstmt, 5):""];
            obj.time = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 6)?(char *)sqlite3_column_text(selectstmt, 6):""];
            obj.person = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 7)?(char *)sqlite3_column_text(selectstmt, 7):""];
            obj.video = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)?(char *)sqlite3_column_text(selectstmt, 8):""];
            obj.is_favourite = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 9)?(char *)sqlite3_column_text(selectstmt, 9):""];
            [arrData addObject:obj];
        }
    }
    return arrData;
}
+(void)updateFevoriteData:(Recipe *)obj{
    const char *sql="update tblRecipe set is_favourite = ? where id = ?";
    sqlite3_stmt *insertStmt;
    if(sqlite3_prepare_v2(database, sql, -1, &insertStmt, NULL)==SQLITE_OK){
        sqlite3_bind_int(insertStmt, 2, obj.ID);
        sqlite3_bind_text(insertStmt, 1,[obj.is_favourite UTF8String] , -1, SQLITE_TRANSIENT);
    }
    if(sqlite3_step(insertStmt)!=SQLITE_DONE){
        NSLog(@"%s",sqlite3_errmsg(database));
    }
}*/
+(NSMutableArray*)getAllNote
{
    NSString *strSql = [NSString stringWithFormat:@"select ID,title,detail from tblNote"];
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    NSMutableArray *arrData;
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        arrData = [[NSMutableArray alloc] init];
        while(sqlite3_step(selectstmt) == SQLITE_ROW) {
            Note *obj = [[Note alloc] init];
            obj.ID = sqlite3_column_int(selectstmt, 0);
            obj.title =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)?(char *)sqlite3_column_text(selectstmt, 1):""];
            obj.detail =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)?(char *)sqlite3_column_text(selectstmt, 2):""];
            [arrData addObject:obj];
        }
    }
    return arrData;
}
+(void)insertNoteData:(Note*)obj
{
    const char *sql = "INSERT OR REPLACE INTO tblNote (title,detail) VALUES( ?, ?)";
    sqlite3_stmt *insertStmt;
    if (sqlite3_prepare_v2(database, sql, -1, &insertStmt, NULL)==SQLITE_OK) {
        sqlite3_bind_text(insertStmt, 1, [obj.title UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 2, [obj.detail UTF8String], -1, SQLITE_TRANSIENT);
    }
    if (sqlite3_step(insertStmt)!=SQLITE_DONE) {
        NSLog(@"%s",sqlite3_errmsg(database));
    }
}
+(void)deleteAllNote
{
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM tblNote"];
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        if(sqlite3_step(selectstmt) != SQLITE_DONE) {
            NSLog(@"%s",sqlite3_errmsg(database));
        }
    }
}
+(void)deleteNoteFromID:(int)ID
{
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM tblNote where ID=%d",ID];
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        if(sqlite3_step(selectstmt) != SQLITE_DONE) {
            NSLog(@"%s",sqlite3_errmsg(database));
        }
    }
}
+(void)insertShoppingList:(Item *)obj
{
    const char *sql = "INSERT OR REPLACE INTO tblShoppingList (item,measure) VALUES( ?, ?)";
    sqlite3_stmt *insertStmt;
    if (sqlite3_prepare_v2(database, sql, -1, &insertStmt, NULL)==SQLITE_OK) {
        sqlite3_bind_text(insertStmt, 1, [obj.item UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStmt, 2, [obj.measure UTF8String], -1, SQLITE_TRANSIENT);
    }
    if (sqlite3_step(insertStmt)!=SQLITE_DONE) {
        NSLog(@"%s",sqlite3_errmsg(database));
    }
}
+(NSMutableArray*)getAllShoppingList
{
    NSString *strSql = [NSString stringWithFormat:@"select ID,item,measure,is_mark from tblShoppingList"];
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    NSMutableArray *arrData;
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        arrData = [[NSMutableArray alloc] init];
        while(sqlite3_step(selectstmt) == SQLITE_ROW) {
            Item *obj = [[Item alloc] init];
            obj.ID = sqlite3_column_int(selectstmt, 0);
            obj.item =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)?(char *)sqlite3_column_text(selectstmt, 1):""];
            obj.measure =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)?(char *)sqlite3_column_text(selectstmt, 2):""];
            obj.is_mark =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)?(char *)sqlite3_column_text(selectstmt, 3):""];
            [arrData addObject:obj];
        }
    }
    return arrData;
}
+(void)deleteAllShoppingList
{
    NSString *strSql = [NSString stringWithFormat:@"DELETE FROM tblShoppingList"];
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        if(sqlite3_step(selectstmt) != SQLITE_DONE) {
            NSLog(@"%s",sqlite3_errmsg(database));
        }
    }
}
+(void)updateMarkAsPurchased:(Item *)obj{
    const char *sql="update tblShoppingList set is_mark = ? where id = ?";
    sqlite3_stmt *insertStmt;
    if(sqlite3_prepare_v2(database, sql, -1, &insertStmt, NULL)==SQLITE_OK){
        sqlite3_bind_int(insertStmt, 2, obj.ID);
        sqlite3_bind_text(insertStmt, 1,[obj.is_mark UTF8String] , -1, SQLITE_TRANSIENT);
    }
    if(sqlite3_step(insertStmt)!=SQLITE_DONE){
        NSLog(@"%s",sqlite3_errmsg(database));
    }
}
+(Item*)checkIsPurchased:(int)ID
{
    NSString *strSql = [NSString stringWithFormat:@"select ID,item,measure,is_mark from tblShoppingList where Id=%d",ID];
    const char *sql = [strSql UTF8String];
    sqlite3_stmt *selectstmt;
    Item *obj=[[Item alloc]init];
    if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
        while(sqlite3_step(selectstmt) == SQLITE_ROW) {
            obj.ID = sqlite3_column_int(selectstmt, 0);
            obj.item =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)?(char *)sqlite3_column_text(selectstmt, 1):""];
            obj.measure =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)?(char *)sqlite3_column_text(selectstmt, 2):""];
            obj.is_mark =[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)?(char *)sqlite3_column_text(selectstmt, 3):""];
        }
    }
    return obj;
}
@end
