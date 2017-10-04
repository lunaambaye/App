//
//  RecipeCell.m
//  Template
//
//  Created by Karim on 19/4/17.
//  Copyright © 2017 ExpressTemplate. All rights reserved.
//

#import "RecipeCell.h"

@implementation RecipeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recipesImageLoaded) name:@"RecipesImageLoaded" object:_recipe];
}

- (void)recipesImageLoaded {
    UIImageView *imageRecipe=(UIImageView*) [self.contentView viewWithTag:100];
    imageRecipe.image = [UIImage imageWithData:_recipe.image];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
