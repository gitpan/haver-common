# Haver::Preprocessor - simple preprocessor for Haver scripts.
# 
# Copyright (C) 2004 Dylan William Hardison
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
package Haver::Preprocessor;
use strict;
use warnings;
use Carp;

use Filter::Simple;

if ($::DEBUG) {
	FILTER {
		s/^\s*ASSERT:\s*(.+?);$/unless ($1) { Carp::confess q(Assertion failed: ($1)) }/mg;
		s/^\s*DUMP:\s*(.+?);$/dumper($1)/meg;
		s/^\s*DEBUG:\s*(.+?);$/print STDERR $1;/mg;
	};
} else {
	FILTER {
		s/^\s*ASSERT:/# ASSERT:/mg;
		s/^\s*DUMP:/# DUMP:/mg;
		s/^\s*DEBUG:/# DEBUG:/mg;
	};
}

sub dumper {
	my $expr = shift;
	require Data::Dumper;
	return "warn Data::Dumper::Dumper($expr);";
}


1;
