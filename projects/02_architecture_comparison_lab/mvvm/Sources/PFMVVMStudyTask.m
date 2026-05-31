#import "PFMVVMStudyTask.h"

NSString *PFMVVMStudyTaskStateLabel(PFMVVMStudyTaskState state) {
    switch (state) {
        case PFMVVMStudyTaskStateTodo:
            return @"todo";
        case PFMVVMStudyTaskStateDone:
            return @"done";
    }
}

@implementation PFMVVMStudyTask

- (instancetype)initWithTitle:(NSString *)title
                        notes:(NSString *)notes
                         tags:(NSArray<NSString *> *)tags
             estimatedMinutes:(NSInteger)estimatedMinutes
                        state:(PFMVVMStudyTaskState)state {
    self = [super init];
    if (self) {
        _title = [title copy];
        _notes = [notes copy];
        _tags = [tags copy];
        _estimatedMinutes = estimatedMinutes;
        _state = state;
    }
    return self;
}

- (NSDictionary<NSString *, id> *)dictionaryRepresentation {
    return @{
        @"title": self.title,
        @"notes": self.notes,
        @"tags": self.tags,
        @"estimatedMinutes": @(self.estimatedMinutes),
        @"state": PFMVVMStudyTaskStateLabel(self.state)
    };
}

@end
