#!/usr/bin/perl
use Module::Build;
my $build = Module::Build->new(
	module_name   => 'Haver',
	dist_name     => 'haver-common',
	dist_version  => '0.043',
	dist_author   => 'Dylan William Hardison <dylanwh@tampabay.rr.com>',
	dist_abstract => 'Common modules for Haver::Server and Haver::Client',
	license       => 'gpl',
	requires      => {
		'perl'           => '5.6.1',
		POE              => 0.26,
	},
	recommends  => {
		'Haver::Server' => 0.043,
		'Haver::Client' => 0.043,
	},
	create_makefile_pl => 'passthrough',
);

$build->create_build_script;
