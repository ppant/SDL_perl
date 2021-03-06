#!/usr/bin/perl -w
use strict;
use SDL;
use SDL::Config;
use SDL::Mixer;
use Test::More;
use Data::Dumper;

use lib 't/lib';
use SDL::TestTool;

if ( !SDL::TestTool->init(SDL_INIT_AUDIO) ) {
    plan( skip_all => 'Failed to init sound' );
}
elsif( !SDL::Config->has('SDL_mixer') )
{
    plan( skip_all => 'SDL_mixer support not compiled' );
}
my @done = qw/
linked_version	  	
open_audio	  	
close_audio	  	
/;

my $v = SDL::Mixer::linked_version();

isa_ok($v, 'SDL::Version', '[linked_version] returns a SDL::verion object');

is( SDL::Mixer::open_audio( 44100, SDL::Constants::AUDIO_S16, 2, 4096 ), 0, '[open_audio] ran');

my $data = SDL::Mixer::query_spec();

my( $status, $freq, $format, $chan ) = @{$data};

isnt ($status, 0,  '[query_spec] ran' );
isnt ($freq, 0,  '[query_spec] got frequency '. $freq );
isnt ($format, 0,  '[query_spec] got format ');
isnt ($chan, 0, '[query_spec] got channels '.$chan);

SDL::Mixer::close_audio();

pass '[close_audio]  ran';



my @left = qw/
init	  	
quit	  	
seterror	  	
geterror	  	
queryspec	  	
/	
;

my $why
    = '[Percentage Completion] '
    . int( 100 * ( $#done + 1 ) / ( $#done + $#left + 2 ) )
    . "\% implementation. "
    . ( $#done + 1 ) . " / "
    . ( $#done + $#left + 2 );

TODO:
{
    local $TODO = $why;
    fail "Not Implmented SDL::Mixer::*::$_" foreach(@left)
    
}
diag $why;

done_testing();

