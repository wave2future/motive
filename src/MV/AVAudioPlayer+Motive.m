#import "AVAudioPlayer+Motive.h"

@implementation AVAudioPlayer (AVAudioPlayerMotive)

+ (AVAudioPlayer *)audioPlayerForResource:(NSString *)resource {
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:resource ofType:nil]];
	return [[[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL] autorelease];
}

@end
