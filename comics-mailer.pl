#!/usr/bin/perl -s
use strict;
use warnings;
use File::BaseDir qw/config_home cache_home/;

use lib '.';
use comic;
use plugin::postimees;
use plugin::cyanide;
use plugin::xkcd;
#use plugin::simonscat;
use plugin::wulffmorgenthaler;
use plugin::geekandpoke;
#use plugin::pandyland;
use plugin::garfield;
use plugin::deathbulge;
use plugin::depressedalien;
use plugin::oglaf;
use plugin::cuek;
use plugin::catversushuman;
use plugin::nsfw;
use plugin::bpf;
use plugin::mrlovenstein;
use plugin::thingsinsquares;

our ($debug, $date);
$debug = 1 if -t STDIN;

my $p = comic->new();

$p->set_date($date) if $date;
# use config_home, as config_files returns only existing files
my $history_file = config_home('comics-mailer.hist');
# use history file only if not debugging
$p->set_history_file($history_file) if !$debug;
# do not use cache file if ran from cron
$p->set_http_cache(cache_home("comics-mailer-http.cache")) if $debug;

$p->fetch_data;
$p->compose_mail;

if (@ARGV) {
	$p->mail_attach(@ARGV);
}
