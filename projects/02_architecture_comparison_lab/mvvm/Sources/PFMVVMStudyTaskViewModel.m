#import "PFMVVMStudyTaskViewModel.h"

@implementation PFMVVMStudyTaskViewModel

- (instancetype)initWithTask:(PFMVVMStudyTask *)task {
    self = [super init];
    if (self) {
        _titleText = [NSString stringWithFormat:@"%@ [%@]",
                      task.title,
                      PFMVVMStudyTaskStateLabel(task.state)];
        _detailText = [NSString stringWithFormat:@"%ld min | %@ | %@",
                       (long)task.estimatedMinutes,
                       [task.tags componentsJoinedByString:@", "],
                       task.notes];
    }
    return self;
}

@end
