#import <Foundation/Foundation.h>
#import "PFMVVMStudyTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVVMStudyTaskViewModel : NSObject
@property (nonatomic, copy, readonly) NSString *titleText;
@property (nonatomic, copy, readonly) NSString *detailText;
- (instancetype)initWithTask:(PFMVVMStudyTask *)task;
@end

NS_ASSUME_NONNULL_END
