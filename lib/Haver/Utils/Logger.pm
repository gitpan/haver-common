# Haver::Utils::Logger, implements a logging POE session.
# 
# Copyright (C) 2003 Dylan William Hardison.
#
# This module is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This module is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this module; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# TODO, write POD. Soon.
# XXX The API for this should be made cleaner. XXX
package Haver::Utils::Logger;
use strict;
use warnings;
use Carp;
use POE;

BEGIN {
	no strict 'refs';

	foreach my $c (qw(error raw note debug)) {
		*{$c} = sub {
			$poe_kernel->post('Logger', $c, join('',@_));
		};
	}
}

use Exporter;
use base 'Exporter';

our @EXPORT    = qw(error raw note debug);
our @EXPORT_OK = @EXPORT;

sub create {
	my ($class, %opts) = @_;
	POE::Session->create(
		package_states => 
		[
			$class => {
				_start => '_start',
				_stop  => '_stop',
				map { ( $_ => "on_$_" ) } qw(
					error
					raw
					note
					debug
					shutdown
				),
			},
		],
		heap => {
			file => $opts{logfile},
		},
	);
}

sub _start {
	my ($kernel, $heap) = @_[KERNEL, HEAP];
	my $fh;
	
	if ($heap->{file} eq '-') {
		$fh  = \*STDERR;
	} else {
		open $fh, ">$heap->{file}" or die "Can't open logfile $heap->{file}: $!";
	}
	$heap->{fh} = $fh;
	print "Logger starts.\n";
	print "    Logging to ``$heap->{file}''.\n";
	$kernel->alias_set('Logger');
}

sub _stop {
	my ($kernel, $heap) = @_[KERNEL, HEAP];
	unless ($heap->{file} eq '-') {
		my $fh = $heap->{fh};
		close $fh;
	}
	print STDERR "Logger stops.\n";
}

sub on_shutdown {
	$_[KERNEL]->alias_remove('Logger');
}
	
sub on_error {
	my ($kernel, $heap, $msg) = @_[KERNEL, HEAP, ARG0];
	my $fh = $heap->{fh};
	print $fh "ERROR: $msg\n";
}

sub on_raw {
	my ($kernel, $heap, $msg) = @_[KERNEL, HEAP, ARG0];
	my $fh = $heap->{fh};
	print $fh "RAW: $msg\n";
}
sub on_note {
	my ($kernel, $heap, $msg) = @_[KERNEL, HEAP, ARG0];
	my $fh = $heap->{fh};
	print $fh "NOTE: $msg\n";
}

sub on_debug {
	my ($kernel, $heap, $msg) = @_[KERNEL, HEAP, ARG0];
	my $fh = $heap->{fh};
	print $fh "DEBUG: $msg\n";
}

1;
