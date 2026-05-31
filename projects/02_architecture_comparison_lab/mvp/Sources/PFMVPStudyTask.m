#import "PFMVPStudyTask.h"

NSString *PFMVPStudyTaskStateLabel(PFMVPStudyTaskState state) {
    switch (state) {
        case PFMVPStudyTaskStateTodo:
            return @"todo";
        case PFMVPStudyTaskStateBlocked:
            return @"blocked";
        case PFMVPStudyTaskStateDone:
            return @"done";
    }
}

@implementation PFMVPStudyTask

- (instancetype)initWithTitle:(NSString *)title
                        notes:(NSString *)notes
                         tags:(NSArray<NSString *> *)tags
                     priority:(NSInteger)priority
             estimatedMinutes:(NSInteger)estimatedMinutes
                        state:(PFMVPStudyTaskState)state {
    self = [super init];
    if (self) {
        _title = [title copy];
        _notes = [notes copy];
        _tags = [tags copy];
        _priority = priority;
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
        @"priority": @(self.priority),
        @"estimatedMinutes": @(self.estimatedMinutes),
        @"state": PFMVPStudyTaskStateLabel(self.state)
    };
}

@end
