//
//  UIActionSheet+Blocks.m
//  Shibui
//
//  Created by Jiva DeVoe on 1/5/11.
//  Copyright 2011 Random Ideas, LLC. All rights reserved.
//

#import "MASTUIActionSheet+Blocks.h"
#import <objc/runtime.h>

static NSString *RI_BUTTON_ASS_KEY = @"com.random-ideas.BUTTONS";


void useCatagory6(){
    NSLog(@"do nothing, just for make catagory linked");
}


@implementation UIActionSheet (Blocks)

-(id)initWithTitle:(NSString *)inTitle cancelButtonItem:(MASTRIButtonItem *)inCancelButtonItem destructiveButtonItem:(MASTRIButtonItem *)inDestructiveItem otherButtonItems:(MASTRIButtonItem *)inOtherButtonItems, ...
{
    if((self = [self initWithTitle:inTitle delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray array];
        
        MASTRIButtonItem *eachItem;
        va_list argumentList;
        if (inOtherButtonItems)
        {
            [buttonsArray addObject: inOtherButtonItems];
            va_start(argumentList, inOtherButtonItems);
            while((eachItem = va_arg(argumentList, MASTRIButtonItem *)))
            {
                [buttonsArray addObject: eachItem];
            }
            va_end(argumentList);
        }
        
        for(MASTRIButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }
        
        if(inDestructiveItem)
        {
            [buttonsArray addObject:inDestructiveItem];
            NSInteger destIndex = [self addButtonWithTitle:inDestructiveItem.label];
            [self setDestructiveButtonIndex:destIndex];
        }
        if(inCancelButtonItem)
        {
            [buttonsArray addObject:inCancelButtonItem];
            NSInteger cancelIndex = [self addButtonWithTitle:inCancelButtonItem.label];
            [self setCancelButtonIndex:cancelIndex];
        }
        
        objc_setAssociatedObject(self, RI_BUTTON_ASS_KEY, buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [self retain]; // keep yourself around!
    }
    return self;
}

- (void)addButtonItem:(MASTRIButtonItem *)item
{	
    NSMutableArray *buttonsArray = objc_getAssociatedObject(self, RI_BUTTON_ASS_KEY);	

	[self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSArray *buttonsArray = objc_getAssociatedObject(self, RI_BUTTON_ASS_KEY);
    MASTRIButtonItem *item = [buttonsArray objectAtIndex:buttonIndex];
    if(item.action)
        item.action();
    objc_setAssociatedObject(self, RI_BUTTON_ASS_KEY, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self release]; // and release yourself!
}


@end
