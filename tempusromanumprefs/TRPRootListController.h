#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>
#include <spawn.h>

@interface TRPRootListController : PSListController

@property (nonatomic, retain) UIBarButtonItem *respringButton;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UIImageView *iconView;

- (void)respring:(id)sender;

@end

@interface TRPTwitterCell : PSTableCell

@property (nonatomic, retain, readonly) UIView *avatarView;
@property (nonatomic, retain, readonly) UIImageView *avatarImageView;
@property (nonatomic, retain) UIImage *avatarImage;

@end

