//
//  XLFormContent.h
//  Pods
//
//  Created by vlad gorbenko on 10/7/15.
//
//

#import <Foundation/Foundation.h>

#import "XLFormRowNavigationDirections.h"

#import "XLFormRowNavigationAccessoryViewProtocol.h"

#import "XLCollectionViewProtocol.h"

#import "XLTextInput.h"
#import "XLFormTextInputDelegate.h"

@protocol XLFormDescriptorCell;

@class XLFormDescriptor;
@class XLFormRowDescriptor;

@interface XLFormContent : NSObject <XLFormTextInputDelegate>

@property (nonatomic, weak) XLFormDescriptor *formDescriptor;
@property (nonatomic, weak) UIScrollView<XLCollectionViewProtocol> *formView;
@property (nonatomic, strong) UIView<XLFormRowNavigationAccessoryViewProtocol> *navigationAccessoryView;

@property (nonatomic, weak) UIViewController *formController;

- (instancetype)initWithView:(UIView *)view;

- (void)navigateToDirection:(XLFormRowNavigationDirection)direction;

- (void)didSelectFormRow:(XLFormRowDescriptor *)formRow;
- (void)deselectFormRow:(XLFormRowDescriptor *)formRow;
- (void)reloadFormRow:(XLFormRowDescriptor *)formRow;
- (void)reload;
- (id<XLFormDescriptorCell>)updateFormRow:(XLFormRowDescriptor *)formRow;

- (UIView *)inputAccessoryViewForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor;

- (void)ensureRowIsVisible:(XLFormRowDescriptor *)inlineRowDescriptor;

- (UIView *)dequeueItemWithCellClass:(NSString *)cellClass identifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath style:(NSInteger)style;
- (NSIndexPath *)indexPathWithProxy:(NSIndexPath *)indexPath;

@end
