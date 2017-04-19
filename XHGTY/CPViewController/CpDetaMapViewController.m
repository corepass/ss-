//
//  CpDetaMapViewController.m
//  +
//
//  Created by shensu on 17/4/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "CpDetaMapViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
typedef NS_ENUM(NSInteger, MANaviAnnotationType)
{
    MANaviAnnotationTypeDrive = 0,
    MANaviAnnotationTypeWalking = 1,
    MANaviAnnotationTypeBus = 2,
    MANaviAnnotationTypeRailway = 3,
    MANaviAnnotationTypeRiding = 4
};
@interface CpDetaMapViewController ()<AMapSearchDelegate,MAMapViewDelegate>
@property(strong,nonatomic) AMapSearchAPI * seacher;
@property (nonatomic, strong) NSArray *lines;
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) NSMutableArray *annotations;
@end

@implementation CpDetaMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当前位置";
    self.seacher = [[AMapSearchAPI alloc] init];
    self.seacher.delegate = self;
    [self initAnnotations];

    
    AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
    
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:self.location.coordinate.latitude
                                           longitude:self.location.coordinate.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:self.poi.location.latitude
                                                longitude:self.poi.location.longitude];
    
    [self.seacher AMapWalkingRouteSearch:navi];
    
    
    self.lines = [[NSArray alloc] init];
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.zoomLevel = 15;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.view addSubview:self.mapView];
        [self.mapView showAnnotations:self.annotations edgePadding:UIEdgeInsetsMake(0, 0, 0, 0) animated:YES];
    [self.mapView addAnnotations:self.annotations];
    // Do any additional setup after loading the view.
}
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = YES;
        annotationView.rightCalloutAccessoryView    = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.pinColor                     = [self.annotations indexOfObject:annotation] % 3;
        
        return annotationView;
    }
    
    return nil;
}

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.strokeColor = [UIColor blueColor];
        polylineRenderer.lineWidth   = 5.f;
        
        NSInteger index = [self.lines indexOfObject:overlay];
        if(index == 0) {
            polylineRenderer.lineCapType = kCGLineCapSquare;
            polylineRenderer.lineDash = YES;
        } else {
            polylineRenderer.lineDash = NO;
        }
        
        
        return polylineRenderer;
    }
    
    return nil;
}
- (void)initAnnotations
{
    self.annotations = [NSMutableArray array];
    
    CLLocationCoordinate2D coordinates[1] = {
        {self.poi.location.latitude, self.poi.location.longitude},
      };
    
    for (int i = 0; i < 1; ++i)
    {
        MAPointAnnotation *a1 = [[MAPointAnnotation alloc] init];
        a1.coordinate = coordinates[i];
        a1.title      = [NSString stringWithFormat:@"%@", self.poi.name];
        [self.annotations addObject:a1];
    }
}

- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
//    if (response.route == nil)
//    {
//        return;
//    }
//    NSUInteger  count = 0;
//  
//    CLLocationCoordinate2D  locarray[10000];
//    for (AMapPath  * path in response.route.paths) {
//        @autoreleasepool {
//            for (AMapStep * step in path.steps) {
//               NSArray * array = [step.polyline componentsSeparatedByString:@";"];
//                for (NSString * str  in array) {
//                    NSArray * clocarray = [str componentsSeparatedByString:@","];
//                    CLLocationCoordinate2D loc ;
//                    loc.latitude = [clocarray.firstObject doubleValue];
//                    loc.longitude = [clocarray.lastObject doubleValue];
//                    locarray[count] = loc;
//                }
//                NSLog(@"%@",step.polyline);
//                
//            }
//        }
//     
//    }
//      MAPolyline *line2 = [MAPolyline polylineWithCoordinates:locarray count:count];
//  //   MAPolyline *line2 = [MAPolyline polylineWithCoordinates:line2Points count:5];
//  //  self.lines = response.route.paths.firstObject
//    self.lines = [NSArray arrayWithObject:line2];
//     [self.mapView addOverlays:self.lines];
    //解析response获取路径信息，具体解析见 Demo
}


- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"路径规划失败"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
