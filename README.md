Task::BeLike::HMA
=================

Task::BeLike::HMA is HMA's personal [Task] [1] to install the Perl
modules he likes to have available.

See "Makefile.PL" for details.

  [1]: http://search.cpan.org/perldoc?Task


# SYNOPSIS / INSTALLATION

    perl Makefile.PL
    make

    # re-run Makefile.PL to see if all modules got installed
    perl Makefile.PL

    # make test and install if you want (not required)
    make test
    make install


# DEPENDENCIES

This Task checks if recent versions of Perl toolchain modules are available.
If not, installation of [Task::BeLike::HMA::Toolchain] [2] is suggested and
nothing is installed.

  [2]: https://github.com/hma/Task-BeLike-HMA-Toolchain

The required minimum versions of toolchain modules are:

* [CPAN] [3] 1.9301 (in Perl 5.8.9 core)
* [Module::Build] [4] 0.3603 (in 5.12.0)

  [3]: http://search.cpan.org/dist/CPAN/
  [4]: http://search.cpan.org/dist/Module-Build/


# COPYRIGHT AND LICENSE

Copyright (c) 2010-2011 Henning Manske. All rights reserved.

This module is free software. You can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/

This module is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
