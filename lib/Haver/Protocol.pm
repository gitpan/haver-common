# Haver::Protocol, Right now this
# just loads Haver::Protocol::* modules.
# 
# Copyright (C) 2003 Dylan William Hardison
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

package Haver::Protocol;
use strict;
use warnings;

our $VERSION = "0.02";

use Haver::Protocol::Filter;


1;

1;
__END__

=head1 NAME

Haver::Protocol - Loads all protocol-related modules.

=head1 SYNOPSIS

  use Haver::Protocol;

=head1 DESCRIPTION

Currently this just loads Haver::Protocol::Filter. In the future,
when/if there are more protocol-related modules, it'll load them too.

=head2 EXPORT

Nothing to export.

=head1 SEE ALSO

L<Haver::Protocol::Filter>

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
