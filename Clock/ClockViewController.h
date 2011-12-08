//
//  ClockViewController.h
//  Clock
//
//  Created by 早河 優 on 11/11/15.
//  Copyright (c) 2011 東京. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

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
}

@property (retain, nonatomic) IBOutlet UIImageView *alarmHand;
@property (retain, nonatomic) IBOutlet UIImageView *hourHand;
@property (retain, nonatomic) IBOutlet UIImageView *minuteHand;
@property (retain, nonatomic) IBOutlet UIImageView *secondHand;
@property (retain, nonatomic) IBOutlet UIButton *alarmButton;

- (IBAction)toggleAlarmButton;

- (void)driveClock:(NSTimer *)timer; //タイマーから呼び出される

- (void)saveUserDefaults;

- (IBAction)moveAlarmHand:(id)sender forEvent:(UIEvent *)event;

@end
