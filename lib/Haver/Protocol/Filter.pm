# Haver::Protocol::Filter
# This is a POE filter for the Haver protocol.
# It subclasses POE::Filter::Line.
# 
# Copyright (C) 2003-2004 Bryan Donlan
# Modifications and docs Copyright (C) 2004 Dylan William Hardison
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
package Haver::Protocol::Filter;
use warnings;
use strict;

use POE;
use base qw(POE::Filter::Line);

our $VERSION = "0.02";

sub new {
	my ($this) = @_;
	
	return $this->SUPER::new(Literal => "\x0D\x0A");
}

sub get {
	my ( $self, @args ) = @_;
	my $res = $self->SUPER::get(@args);
	for ( @{$res} ) {
		$_ = [ split "\t", $_ ];
		if ( exists $_->[0] ) {
			$_->[0] =~ s/\W//g;
		}
	}
	return $res;
}

sub get_one {
	my ( $self, @args ) = @_;
	my $res = $self->SUPER::get_one(@args);
	for ( @{$res} ) {
		$_ = [ split "\t", $_ ];
		if ( exists $_->[0] ) {
			$_->[0] =~ s/\W//g;
		}
	}
	return $res;
}

sub put {
	my ( $self, $arg ) = @_;
	$arg = [ @{$arg} ];
	for ( @{$arg} ) {
		if ( exists $_->[0] ) {
			$_->[0] =~ s/\W//g;
		}
		$_ = join "\t", @{$_};
	}
	return $self->SUPER::put($arg);
}

1;


1;
__END__

=head1 NAME

Haver::Protocol::Filter - POE::Filter for the Haver protocol.

=head1 SYNOPSIS

  use Haver::Protocol::Filter;
  my $filter = new Haver::Protocol::Filter; # takes no arguments.
  
  # See POE::Filter. This is just a standard filter.
  # it inherits from POE::Filter::Line.

=head1 DESCRIPTION

This POE::Filter translates strings like "MSG\tdylan\tbunnies\xD\xA"
to and from arrays like ['MSG', 'dylan', 'bunnies'].

=head1 SEE ALSO

L<POE::Filter>, L<POE::Filter::Line>.

L<https://savannah.nongnu.org/projects/haver/>, L<http://wiki.chani3.com/wiki/ProjectHaver/Protocol>,
L<http://wiki.chani3.com/wiki/ProjectHaver/ProtocolSyntax>.

=head1 AUTHOR

Bryan Donlan, E<lt>:bdonlan@bd-home-comp.no-ip.orgE<gt>
with small modifications and documentation by
Dylan William Hardison, E<lt>dylanwh@tampabay.rr.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2003-2004 by Bryan Donlan.
Modifications and docs Copyright (C) 2004 Dylan William Hardison.

This library is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this module; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

=cut
