#!/usr/bin/perl
use Module::Build;
my $build = Module::Build->new(
	module_name        => 'Haver',
	dist_name          => 'haver-common',
	dist_version_from  => 'lib/Haver.pm',
	dist_author        => 'Dylan William Hardison <dylanwh@tampabay.rr.com>',
	dist_abstract      => 'Common modules for Haver::Server and Haver::Client',
	license            => 'gpl',
	requires           => {
		'perl' => '5.6.1',
		POE    => 0.27,
	},
	recommends  => {
		'Haver::Server' => 0.05,
		'Haver::Client' => 0.05,
	},
	create_makefile_pl => 'passthrough',
);

$build->create_build_script;
