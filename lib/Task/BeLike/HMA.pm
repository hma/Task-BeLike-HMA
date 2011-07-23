package Task::BeLike::HMA;

use 5.006001;

use strict;
use warnings;

our $VERSION = '0.09';

$VERSION = eval $VERSION;

__END__

=head1 NAME

Task::BeLike::HMA - Install modules HMA uses

=head1 VERSION

This is version 0.09 of Task::BeLike::HMA as of Jul 23, 2011.

=head1 SYNOPSIS

  perl Makefile.PL
  make

  # re-run Makefile.PL to see if all modules got installed
  perl Makefile.PL

  # make test and install if you want (not required)
  make test
  make install

=head1 DESCRIPTION

Task::BeLike::HMA is HMA's personal L<Task> to install the Perl
modules he likes to have available.

See C<Makefile.PL> for details.

=head1 DEPENDENCIES

This Task checks if recent versions of Perl toolchain modules are
available. If not, installation of C<Task::BeLike::HMA::Toolchain> is
suggested and nothing is installed.

The required minimum versions of toolchain modules are:

=over 4

=item * L<CPAN> 1.9301 (in Perl 5.8.9 core)

=item * L<Module::Build> 0.340201 (in 5.10.1 core)

=back

=head1 SEE ALSO

=over 4

=item * L<Task|http://search.cpan.org/perldoc?Task>

=item * L<Task::BeLike::HMA::Toolchain|https://github.com/hma/Task-BeLike-HMA-Toolchain>

=back

=head1 AUTHOR

Henning Manske <hma@cpan.org>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2010-2011 Henning Manske. All rights reserved.

This module is free software. You can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See L<http://dev.perl.org/licenses/>.

This module is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut
