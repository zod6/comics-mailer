#!/usr/bin/perl
package plugin::cyanide;

use HTML::TreeBuilder;

use plugin;
push(@ISA, 'plugin');
my $package = __PACKAGE__;
$plugin::plugins{$package}++;

my $baseurl = "http://www.explosm.net/comics/";

sub get_url {
	my $this = shift;

	my $content = $this->fetch_url($baseurl) or return;
	my $root = new HTML::TreeBuilder;
	$root->parse($content);

	my $p = $root->look_down( _tag => 'img', alt => 'Cyanide and Happiness, a daily webcomic');
	if ($p) {
		$this->add_comic($p->attr('src'), $p->attr('alt'));
	}
}

1;