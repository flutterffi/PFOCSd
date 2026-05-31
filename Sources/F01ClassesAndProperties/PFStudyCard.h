#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PFStudyCard : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger difficulty;
- (instancetype)initWithTitle:(NSString *)title difficulty:(NSInteger)difficulty;
- (NSString *)summary;
@end

NS_ASSUME_NONNULL_END
