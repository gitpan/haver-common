# Haver::Base - Base class for most objects in Haver.
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
package Haver::Base;
use strict;
use warnings;

our $VERSION = "0.01";

use constant DEBUG => 1;

sub new {
	my $this = shift;
	my $me   = @_ == 1 && ref($_[0]) ?  shift : { @_ };
	my $type = ref $me;
	bless $me, ref($this) || $this;

	delete $me->{$_} foreach (grep(/^_/, keys %$me));

	if ($type eq 'HASH') {
		if (!@_ and exists $me->{'-initargs'}) {
			@_ = @{ delete $me->{'-initargs'} };
		}
	}
	
	if (DEBUG) {
		_debug("Creating object: ", $me);
	}

	$me->initialize(@_);

	return $me;
}

sub initialize {undef}
sub finalize   {undef}

sub DESTROY {
	my $me = shift;
	$me->finalize();
	
	if (DEBUG) {
		_debug("Destroying object: ", $me);
	}
}

sub _debug {
	print "DEBUG: ", join('', @_), "\n";
}


1;

__END__

=head1 NAME

Haver::Base - Useful base class for most objects in Haver server and clients.

=head1 SYNOPSIS

   BEGIN { 
   package Foobar;
   use base 'Haver::Base';

   sub initialize {
       my ($me, @args) = @_;
       print "init args: join(', ', @args), "\n";
   }

   sub finalize {
      my ($me) = @_;
      # do stuff here that you would do in DESTROY.
   }
   } # BEGIN

   my $foo = new Foobar({name => "Foobar"}, 1, 2, 3);
   # or: my $foo = new Foobar(name => "Foobar", -initargs => [1, 2, 3])
   # "init args: 1, 2, 3" was printed.
   $foo->{name} eq "Foobar";

   

=head1 DESCRIPTION

This is a base class for nearly every class in the Haver server,
and it is encouraged to be used for any class in the client, too.

The main advantage it brings is not having to write redundant
constructors, and also it prints debugging messages on object creation and destruction.

When a new object is instantiated, initialize() is called.
Don't overload DESTROY in child classes, use finalize() instead.

TODO Describe methods.

=head1 SEE ALSO

L<Haver::Singleton>

L<https://savannah.nongnu.org/projects/haver/>



=head1 AUTHOR

Dylan William Hardison, E<lt>dylanwh@tampabay.rr.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by Dylan William Hardison

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
