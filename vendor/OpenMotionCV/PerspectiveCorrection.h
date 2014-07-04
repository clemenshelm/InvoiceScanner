#include <opencv2/opencv.hpp>
#import <Foundation/Foundation.h>

@interface PerspectiveCorrection : NSObject

- (PerspectiveCorrection*)initWithImage:(UIImage*)distortedImage;
- (UIImage*)correctFromCorners:(NSArray*)distortedCorners;

@end
