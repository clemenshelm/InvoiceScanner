#import "PerspectiveCorrection.h"
#import "UIImage+OpenCV.h"

@interface PerspectiveCorrection ()

@property cv::Mat distortedMat;
@property cv::Point2f* documentCorners;
@property int resultWidth;
@property int resultHeight;

@end

@implementation PerspectiveCorrection

- (PerspectiveCorrection*)initWithImage:(UIImage*)distortedImage
{
    self = [super init];
    if (self) {
        self.distortedMat = [distortedImage CVMat];
        self.resultWidth = self.distortedMat.cols;
        self.resultHeight = self.resultWidth * sqrt(2);
        // TODO: Use A4 format instead
        self.documentCorners = new cv::Point2f[4];
        self.documentCorners[0].x = 0;                      self.documentCorners[0].y = 0;
        self.documentCorners[1].x = self.resultWidth;       self.documentCorners[1].y = 0;
        self.documentCorners[2].x = self.resultWidth;       self.documentCorners[2].y = self.resultHeight;
        self.documentCorners[3].x = 0;                      self.documentCorners[3].y = self.resultHeight;
    }
    return self;
}

- (UIImage*)correctFromCorners:(NSArray*)points
{
    int numPoints = [points count];
    cv::Point2f *distortedCorners = new cv::Point2f[numPoints];

    for (int i = 0; i < numPoints; i++) {
        NSValue* pointValue = points[i];
        CGPoint point = [pointValue CGPointValue];
        distortedCorners[i].x = point.x;
        distortedCorners[i].y = point.y;
    }

    NSLog(@"A4 width: %i, height: %i", self.resultWidth, self.resultHeight);
    cv::Mat perspectiveMat = cv::getPerspectiveTransform(distortedCorners, self.documentCorners);
    cv::Mat resultImageMat;
    cv::warpPerspective(self.distortedMat, resultImageMat, perspectiveMat, self.distortedMat.size());
    cv::Rect roi = cv::Rect(0, 0, self.resultWidth, self.resultHeight);
    cv::Mat(resultImageMat, roi); // crop result to A4 format
    return [UIImage imageWithCVMat:resultImageMat];
}

@end
