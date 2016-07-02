//
//  XLTextViewCollectionViewCell.m
//  Pods
//
//  Created by Alex Zdorovets on 2/7/16.
//
//

#import "XLTextViewCollectionViewCell.h"

#import "XLForm.h"

#import "UIView+XLFormAdditions.h"

#import <UITextView+Placeholder/UITextView+Placeholder.h>

#import "XLFormContent.h"

@interface XLTextViewCollectionViewCell () <UITextViewDelegate>

@end

@implementation XLTextViewCollectionViewCell

#pragma mark - Lifecycle

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textView.delegate = self;
}

#pragma mark - UIResponderer

- (BOOL)becomeFirstResponder {
    return [self.textView becomeFirstResponder];
}

- (BOOL)resignFirstResponder {
    return [self.textView resignFirstResponder];
}

#pragma mark -

- (void)update {
    [super update];
    id value = self.rowDescriptor.value;
    NSString *text = self.rowDescriptor.formatter ? [self.rowDescriptor.formatter stringForObjectValue:value] : value;
    self.textView.text = text;
    self.textView.placeholder = self.rowDescriptor.placeholder; // need to fix NSTextAlignment for localization
    self.titleLabel.text = self.rowDescriptor.title;
    self.textView.editable = !self.rowDescriptor.isDisabled;
    // TODO: make colors configurable
    self.textView.textColor  = self.rowDescriptor.isDisabled ? [UIColor grayColor] : [UIColor blackColor];
    [self updateBehavior];
}

#pragma mark - Setup

- (void)updateBehavior {
    XLTextBehavior *behavior = [self behavior];
    self.textView.autocorrectionType = behavior.autocorrectionType;
    self.textView.autocapitalizationType = behavior.autocapitalizationType;
    self.textView.secureTextEntry = behavior.isSecureTextEntry;
    self.textView.spellCheckingType = behavior.spellCheckingType;
    self.textView.returnKeyType = behavior.returnKeyType;
    self.textView.keyboardType = behavior.keyboardType;
    self.textView.keyboardAppearance = behavior.keyboardAppearance;
    self.textView.textAlignment = self.textView.textAlignment;
}

#pragma mark -

- (BOOL)formDescriptorCellCanBecomeFirstResponder {
    return YES;
}

- (BOOL)formDescriptorCellBecomeFirstResponder {
    return [self.textView becomeFirstResponder];
}

#pragma mark - Accessors

- (XLTextBehavior *)behavior {
    if(!self.rowDescriptor.behavior) {
        XLTextBehavior *behavior = [[XLTextBehavior alloc] init];
        behavior.length = 150;
        self.rowDescriptor.behavior = behavior;
    }
    return (XLTextBehavior *)self.rowDescriptor.behavior;
}

#pragma mark - UITextView delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return [self.formViewController.formContent textInputShouldBeginEditing:textView formRow:self.rowDescriptor];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    return [self.formViewController.formContent textInputShouldEndEditing:textView formRow:self.rowDescriptor];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    BOOL shouldChange = [self.formViewController.formContent textInputView:textView shouldChangeCharactersInRange:range replacementString:text formRow:self.rowDescriptor];
    //    BOOL shouldReturn = [self.formViewController.formContent textInputViewShouldReturn:textView formRow:self.rowDescriptor];
    //    if(shouldReturn) {
    //        [textView resignFirstResponder];
    //        return NO;
    //    }
    return shouldChange;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self.formViewController.formContent textInputViewDidBeginEditing:textView formRow:self.rowDescriptor];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.formViewController.formContent textInputViewDidEndEditing:textView formRow:self.rowDescriptor];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self.formViewController.formContent textInputDidChange:textView formRow:self.rowDescriptor];
}

@end