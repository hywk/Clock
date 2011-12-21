//
//  ClockViewController.h
//  Clock
//
//  Created by 早河 優 on 11/11/15.
//  Copyright (c) 2011 東京. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <CoreLocation/CoreLocation.h>

#define kAlarmEnableKey @"alarmEnabled"
#define KAlarmHourKey @"alarmHour"

AVAudioPlayer *alarmPlayer; //アラーム音の再生プレーヤ

@interface ClockViewController : UIViewController {
    BOOL alarmEnabled; //アラームオン・オフ
    float alarmHour; //アラーム時刻
    UIImageView *alarmHand;
    UIImageView *hourHand;
    UIImageView *minuteHand;
    UIImageView *secondHand;
    UIButton *alarmButton;
    UIButton *startButton;
    UIButton *stopButton;
    UILabel *locationLabel;
    CLLocationManager *maneger;
}

@property (retain, nonatomic) IBOutlet UIImageView *alarmHand;
@property (retain, nonatomic) IBOutlet UIImageView *hourHand;
@property (retain, nonatomic) IBOutlet UIImageView *minuteHand;
@property (retain, nonatomic) IBOutlet UIImageView *secondHand;
@property (retain, nonatomic) IBOutlet UIButton *alarmButton;
@property (retain, nonatomic) IBOutlet UIButton *startButton;
@property (retain, nonatomic) IBOutlet UIButton *stopButton;

@property (retain, nonatomic) IBOutlet UILabel *locationLabel;



- (IBAction)toggleAlarmButton;

- (void)driveClock:(NSTimer *)timer; //タイマーから呼び出される

- (void)saveUserDefaults;

- (IBAction)moveAlarmHand:(id)sender forEvent:(UIEvent *)event;

- (IBAction) start : (id) sender;

- (IBAction) stop : (id) sender;

@end
