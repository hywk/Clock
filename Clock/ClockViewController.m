//
//  ClockViewController.m
//  Clock
//
//  Created by 早河 優 on 11/11/15.
//  Copyright (c) 2011 東京. All rights reserved.
//

#import "ClockViewController.h"

@implementation ClockViewController
@synthesize alarmHand;
@synthesize hourHand;
@synthesize minuteHand;
@synthesize secondHand;
@synthesize alarmButton;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

//------------------------------------------------------------//
#pragma mark - View lifecycle
//------------------------------------------------------------//
//クラスの初期化
+ (void)initialize
{
    //ユーザ・デフォルトの設定
    
    //初期値の辞書を作成
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary]; //初期値設定
    [defaultValues setValue:[NSNumber numberWithBool:NO] forKey:kAlarmEnableKey];
    [defaultValues setValue:[NSNumber numberWithFloat:0.0] forKey:KAlarmHourKey];
     
    //ユーザ・デフォルトを取得
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //ユーザ・デフォルトに初期値を登録
    [userDefaults registerDefaults:defaultValues];

}

//------------------------------------------------------------//

//------------------------------------------------------------//
//アラームのビュー・アイテムを設定
- (void)setAlarmItems{
    
    alarmButton.selected = alarmEnabled;
    
    //アラーム針を設定
    alarmHand.transform = CGAffineTransformMakeRotation(M_PI * 2 * alarmHour / 12.0);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.autoresizesSubviews = NO; //avoid squashed imgView
    
	// タイマーの作成（動作開始）
    [NSTimer scheduledTimerWithTimeInterval:1.0 //間隔
                                     target:self //呼び出すオブジェクト    
                                   selector:@selector(driveClock:) //呼び出すメソッド
                                   userInfo:nil //ユーザ利用の情報オブジェクト
                                    repeats:YES];
    
	// アラーム音の設定
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"alarm" ofType:@"caf"];
    NSURL *url = [NSURL fileURLWithPath:path];

    // アラーム音の再生
    alarmPlayer = [[AVAudioPlayer alloc]
                   initWithContentsOfURL:url error:nil];
    alarmPlayer.numberOfLoops = -1; //ループ再生
    
    //自動ロックの禁止
    UIApplication *application = [UIApplication sharedApplication];
    application.idleTimerDisabled = YES;
    
    //ユーザ・デフォルトを取得
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //ユーザ・デフォルトから設定値を取得
    alarmEnabled = [userDefaults boolForKey:kAlarmEnableKey];
    alarmHour = [userDefaults floatForKey:KAlarmHourKey];
    
    //ユーザ・デフォルトによる設定
    [self setAlarmItems];
}

- (void)viewDidUnload
{
    [self setAlarmHand:nil];
    [self setHourHand:nil];
    [self setMinuteHand:nil];
    [self setSecondHand:nil];
    [self setAlarmButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

//------------------------------------------------------------//

//------------------------------------------------------------//
//デバイスの向き制御
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //    return (interfaceOrientation == UIInterfaceOrientationPortrait == UIInterfaceOrientationPortraitUpsideDown);
    if (interfaceOrientation == UIInterfaceOrientationPortrait)
        return YES;
    if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        return YES;
    else return NO;
}

- (void)dealloc {
    [alarmHand release];
    [hourHand release];
    [minuteHand release];
    [secondHand release];
    [alarmButton release];
    [super dealloc];
}

//------------------------------------------------------------//

//------------------------------------------------------------//
- (void)saveUserDefaults{
    //ユーザ・デフォルトを取得
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //ユーザ・デフォルトに現在の値を設定
    [userDefaults setBool:alarmEnabled forKey:kAlarmEnableKey];
    [userDefaults setFloat:alarmHour forKey:KAlarmHourKey];
    
    //ユーザ・デフォルトの保存
    [userDefaults synchronize];
}

//------------------------------------------------------------//

//------------------------------------------------------------//
//タイマーから呼び出されるメソッド
- (void)driveClock:(NSTimer *)timer{
    //タイマー動作時の処理

    //現在時間の取得
    NSDate *today = [NSDate date];

    //現在時刻のミリ秒取得
    //float fltMsec = floor(([today timeIntervalSince1970] - floor([today timeIntervalSince1970]))*1000);
    
    //現在時刻の時、分、秒を取得
    NSCalendar *calender = [NSCalendar currentCalendar];
    unsigned flags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *todayComponents = [calender components:flags fromDate:today];
    
    int hour = [todayComponents hour];
    int min = [todayComponents minute];
    int sec = [todayComponents second];
    float fineHour = (hour % 12) + min / 60.0;
    
    //float sec = [todayComponents second] + (fltMsec / 1000); //ミリ秒
    
    //針の回転
    hourHand.transform = CGAffineTransformMakeRotation(M_PI * 2 * fineHour / 12.0); //時
    minuteHand.transform = CGAffineTransformMakeRotation(M_PI * 2 * min / 60.0); //分
    secondHand.transform = CGAffineTransformMakeRotation(M_PI * 2 * sec / 60.0); //秒

    // @"出力したい内容を記述"
    NSLog(@"sec: %d ", sec);  //秒
    NSLog(@"angle: %d ", sec * 6); //角度
    //アラームの処理
    if (alarmEnabled) {
        float difference = fineHour - alarmHour;
        if (difference >= 0.0 && difference < 0.1) {
            if (!alarmPlayer.playing)
                [alarmPlayer play];
        }
        else
        {
            if (alarmPlayer.playing) {
                [alarmPlayer stop];
            }
        }
    }
}

//------------------------------------------------------------//

//------------------------------------------------------------//
//アラームボタンがタップされた時に呼び出されるメソッド
- (IBAction)toggleAlarmButton{

    alarmEnabled = !alarmEnabled;

    [self setAlarmItems];
    
    //アラーム状態がオフであれば、アラームを停止
    if (alarmEnabled == NO)
        [alarmPlayer stop];
}

//------------------------------------------------------------//

//------------------------------------------------------------//
//盤面の透明ボタンがタップやドラッグされた時に呼び出されるメソッド
- (IBAction)moveAlarmHand:(id)sender forEvent:(UIEvent *)event {

    //タップされた座標を取得
    NSSet *touches = [event touchesForView:sender];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:sender];
    
    //タップされた座標に対応するアラーム時刻を算定
    float angle = atan2(150 - touchPoint.y, touchPoint.x - 150);
    alarmHour = (M_PI * 0.5 -angle) * 12.0 / (M_PI * 2);
    if (alarmHour < 0.0)
        alarmHour +=12.0;
    
    //アラームのビュー・アイテムを設定
    [self setAlarmItems];
}
@end
