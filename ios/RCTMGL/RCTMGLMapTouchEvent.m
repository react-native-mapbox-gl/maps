//
//  RCTMGLTouchEvent.m
//  RCTMGL
//
//  Created by Nick Italiano on 8/25/17.
//  Copyright © 2017 Mapbox Inc. All rights reserved.
//

#import "RCTMGLMapTouchEvent.h"
#import "RCTMGLEventTypes.h"
#import "RCTMGLPointAnnotation.h"
@import Mapbox;

@implementation RCTMGLMapTouchEvent

- (NSDictionary*)payload
{
    MGLPointFeature *feature = [[MGLPointFeature alloc] init];
    feature.coordinate = _coordinate;
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setValue:[NSNumber numberWithDouble:_screenPoint.x] forKey:@"screenPointX"];
    [attributes setValue:[NSNumber numberWithDouble:_screenPoint.y] forKey:@"screenPointY"];
    if (_id) {
        [attributes setValue:_id forKey:@"id"];
    }
    feature.attributes = attributes;
    return [feature geoJSONDictionary];
}

+ (RCTMGLMapTouchEvent*)makeTapEvent:(MGLMapView*)mapView withPoint:(CGPoint)point
{
    return [RCTMGLMapTouchEvent _fromPoint:point withMapView:mapView andEventType:RCT_MAPBOX_EVENT_TAP];
}

+ (RCTMGLMapTouchEvent*)makeLongPressEvent:(MGLMapView*)mapView withPoint:(CGPoint)point
{
    return [RCTMGLMapTouchEvent _fromPoint:point withMapView:mapView andEventType:RCT_MAPBOX_EVENT_LONGPRESS];
}

+ (RCTMGLMapTouchEvent *)makeAnnotationTapEvent:(RCTMGLPointAnnotation *)pointAnnotation
{
    RCTMGLMapTouchEvent *event = [[RCTMGLMapTouchEvent alloc] init];
    event.type = RCT_MAPBOX_ANNOTATION_TAP;
    event.id = pointAnnotation.id;
    event.coordinate = pointAnnotation.coordinate;
    event.screenPoint = [pointAnnotation.superview convertPoint:pointAnnotation.frame.origin toView:nil];
    return event;
}

+ (RCTMGLMapTouchEvent*)_fromPoint:(CGPoint)point withMapView:(MGLMapView *)mapView andEventType:(NSString*)eventType
{
    RCTMGLMapTouchEvent *event = [[RCTMGLMapTouchEvent alloc] init];
    event.type = eventType;
    event.coordinate =[mapView convertPoint:point toCoordinateFromView:mapView];
    event.screenPoint = point;
    return event;
}

@end
