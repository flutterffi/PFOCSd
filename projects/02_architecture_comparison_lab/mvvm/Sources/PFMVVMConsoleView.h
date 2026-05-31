#import <Foundation/Foundation.h>
#import "PFMVVMStudyTaskViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PFMVVMConsoleView : NSObject
- (void)renderViewModels:(NSArray<PFMVVMStudyTaskViewModel *> *)viewModels title:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
