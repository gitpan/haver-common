# Haver::Config - Configuration Manager.
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
package Haver::Config;
use strict;
#use warnings;
use base 'Haver::Base';
use YAML ();
use Fatal qw(:void open close);
use File::stat;
use File::Basename qw(basename);

use Haver::Preprocessor;

our $VERSION = '0.02';
our $RELOAD = 1;

sub initialize {
	my ($me) = @_;
	my $file = delete $me->{'file'};
	


	if (exists $me->{auto_save}) {
		$me->{_auto_save} = delete $me->{auto_save};
	} else {
		$me->{_auto_save} = 1;
	}

	if (defined $file) {
		$me->load($file);
	}
}


sub load {
	my ($me, $file) = @_;
	ASSERT: @_ == 2;
	ASSERT: defined $file;

	if (-f $file) {
		my $fh;
		open $fh, "<$file";
		local $/ = undef;
		my $conf = YAML::Load(readline($fh));
		close $fh;
		$me->{_mtime} = stat($file)->mtime;
		foreach my $key (grep(!/^_/, keys %$conf)) {
			$me->{$key} = $conf->{$key};
		}
	
	}

	$me->{_file} = $file;
}

sub auto_save {
	my ($me, $val) = @_;
	$me->{_auto_save} = $val;
}

sub reload {
	my ($me) = @_;
	ASSERT: $me->{_file};
	$me->load($me->{_file});
}

sub save {
	my ($me) = @_;
	my $file  = $me->{'_file'};
	my $mtime = $me->{'_mtime'};
	my $t = -f $file ? stat($file)->mtime : $mtime;

	ASSERT: defined $me->{'_file'};
	
	if ($mtime == $t) {
		my %copy;
		foreach my $key (grep(!/^_/, keys %$me)) {
			$copy{$key} = $me->{$key};
		}
		my $fh;
		open $fh, 0600, ">$file";
		print $fh YAML::Dump(\%copy);
		close $fh;
	} else {
		warn "Cowardly refusing to overwrite $file...";
	}

	$me->{_mtime} = stat($file)->mtime;
}


sub finalize {
	my ($me) = @_;

	$me->save if $me->{_auto_save};
}


1;

__END__

=head1 NAME

Haver::Config - Configuration manager..

=head1 SYNOPSIS

  use Haver::Config;
  my $config = new Haver::Config(file => 'some-file.yaml');
  

=head1 DESCRIPTION

FIXME

=head1 SEE ALSO

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
