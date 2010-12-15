#
#  Task::BeLike::HMA - Makefile.PL
#
#  Copyright (c) 2010 Henning Manske. All rights reserved.
#
#  This program is free software. You can redistribute it and/or modify it
#  under the terms of either: the GNU General Public License as published
#  by the Free Software Foundation; or the Artistic License.
#
#  See http://dev.perl.org/licenses/
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#

use strict;
use warnings;

BEGIN {
  # hack: load Module::CPANTS::Analyse before AutoInstall is loaded
  # TODO: bug report
  eval { require Module::CPANTS::Analyse };

  # Test::Tester warns on load if not loaded before Test::Builder
  eval { require Test::Tester };

  # prevent Carp::Always from installing its signal handlers
  eval { require Carp::Always };

  # force Module::AutoInstall to use CPAN.pm
  $ENV{PERL_AUTOINSTALL_PREFER_CPAN} = 1;
}

use inc::Module::Install;

# hack: install Module::Install from a Module::Install based Makefile.PL
# also, $VERSION of bundled inc/Module/Install.pm must be hacked to a lower
# version than required from the 'requires' command

use Module::AutoInstall;
shift @INC;



#
#  preliminary special setup for this Task
#

# check for recent versions of toolchain modules

unless ($ENV{PERL5_CPAN_IS_RUNNING}) {
  require CPAN;
  delete $ENV{PERL5_CPAN_IS_RUNNING};
  delete $ENV{PERL5_CPANPLUS_IS_RUNNING};
}

my $cpan = eval { CPAN->VERSION } || 0;
my $mb   = eval { require Module::Build; Module::Build->VERSION } || 0;

my $WANT_CPAN = '1.9301';   # version in Perl 5.8.9 core
my $WANT_MB   = '0.340201'; # 5.10.1 core

my $task = 'Task::BeLike::HMA::Toolchain 0.03';
my $url  = 'https://github.com/hma/Task-BeLike-HMA-Toolchain';

if ($cpan < $WANT_CPAN || $mb < $WANT_MB) {
  print "*** Toolchain too old.\n"
    . "    Consider installing $task first.\n"
    . "    See: $url\n";
  exit;
}

# suggest installation of Toolchain task

eval "use $task";
if ($@) {
  no warnings 'once';
  *MY::postamble = sub {
    print "\n*** Consider installing $task as well.\n"
      . "    See: $url\n\n";
    return "all ::\n"
      . "\t\$(NOECHO) \$(ECHO)\n"
      . "\t\$(NOECHO) \$(ECHO) \"*** Consider installing $task as well.\"\n"
      . "\t\$(NOECHO) \$(ECHO) \"    See: $url\"\n"
      . "\t\$(NOECHO) \$(ECHO)\n";
  }
}



#
#  module metadata
#

my $NAME = 'Task::BeLike::HMA';

(my $dist = $NAME) =~ s|::|-|g;
(my $path = $NAME) =~ s|::|/|g;

name       $dist;
license    'perl';
all_from   "lib/$path.pm";

bugtracker "https://github.com/hma/$dist/issues";
repository "https://github.com/hma/$dist";

#
#  notes
#
#  * autodie 2.10 t/caller.t fails if Perl < 5.8.4
#  * Module::Version requires autodie
#  * Perl::Critic 1.109 fails with '":color_severity" is not exported by
#    the Perl::Critic::Utils::Constants module' if Perl < 5.8.4
#  * Perl::MinimumVersion requires Perl::Critic
#  * Test::MinimumVersion requires Perl::MinimumVersion
#  * Test::CheckChanges 0.14 causes
#      1..1
#      # No tests run!
#    further on "make"
#      make: *** [installdeps] Error 255
#    TODO: bug report
#  * Module::Version 0.12 t/app.t fails if Getopt::Long < 2.36
#    TODO: bug report
#

# Perl 5.10.1 core pragmas

requires 'autodie'             => '2.06_01' if $] >= 5.008_004; # 5.10.1 core
requires 'parent'              => '0.221';                      # 5.10.1 core

# common

requires 'Clone'               => '0.30';
requires 'Crypt::SSLeay'       => '0.58';
requires 'List::Util'          => '1.21';  # 5.10.1 core
requires 'List::MoreUtils'     => '0.21';
requires 'Module::Pluggable'   => '3.9';   # 5.10.1 core
requires 'Readonly'            => '1.03';
requires 'Readonly::XS'        => '1.05';
requires 'Task::Weaken'        => '1.02';

# personal favourites

requires 'Exception::Class'    => '1.26';
requires 'Package::Generator'  => '0.102';
requires 'Sub::Exporter'       => '0.981';
requires 'Try::Tiny'           => '0.04';

# testing

requires 'Test::Tester'        => '0.107';
requires 'Test::NoWarnings'    => '1.02';
requires 'Test::Deep'          => '0.106';
requires 'Test::Output'        => '0.16';
requires 'Test::Exception'     => '0.29';
requires 'Test::Memory::Cycle' => '1.04';
requires 'Test::Requires'      => '0.04';
requires 'Test::Script'        => '1.07';
requires 'Test::Warn'          => '0.20';

# personal favourites

requires 'aliased'             => '0.30';
requires 'Archive::Zip'        => '1.30';
requires 'Carp::Always'        => '0.06';
requires 'Carp::Clan'          => '6.02';
requires 'Config::General'     => '2.49';
requires 'Data::Dump'          => '1.19';
requires 'Data::Hexify'        => '1.00';
requires 'Data::Record';
requires 'File::Next'          => '1.06';
requires 'JSON'                => '2.22';
requires 'JSON::XS'            => '2.3';
requires 'Parse::RecDescent'   => '1.964';
requires 'Path::Class'         => '0.19';
requires 'Text::CSV_XS'        => '0.73';

# author / release testing

requires 'Pod::Simple'              => '3.11';
requires 'Test::Pod'                => '1.42';
requires 'Pod::Coverage'            => '0.19';
requires 'Test::Pod::Coverage'      => '1.08';
requires 'Test::CheckChanges'       => '0.14';
requires 'Test::CPAN::Meta'         => '0.17';
requires 'Test::DistManifest'       => '1.009';
requires 'Test::EOL'                => '0.9'      if $] >= 5.008;
requires 'Test::HasVersion'         => '0.012';
requires 'Module::CPANTS::Analyse'  => '0.85';
requires 'Test::Kwalitee'           => '1.01';
requires 'Perl::Critic'             => '1.109'    if $] >= 5.008_004;
requires 'Perl::MinimumVersion'     => '1.25'     if $] >= 5.008_004;
requires 'Test::MinimumVersion'     => '0.101080' if $] >= 5.008_004;
requires 'Test::Module::Used'       => '0.1.9'    if $] >= 5.008_003;
requires 'Test::NoTabs'             => '1.0';
requires 'Test::Pod::No404s'        => '0.01'     if $] >= 5.008;
requires 'Test::Portability::Files' => '0.05';
requires 'Test::Spelling'           => '0.11';
requires 'Devel::Cover'             => '0.70';
requires 'Test::Strict'             => '0.14';
requires 'Test::Synopsis'           => '0.05'     if $] >= 5.008_001;

# admin

requires 'Module::CoreList' => '2.38';
requires 'Getopt::Long'     => '2.36';  # 5.9.5 core
requires 'Module::Version'  => '0.10' if $] >= 5.008_004;
requires 'App::perlbrew'    => '0.10' if $] >= 5.008 && index( $^X, 'perlbrew' ) == -1;
requires 'Module::Install'  => '1.00';

build_requires 'Test::More';

clean_files "$dist-* Debian_CPANTS.txt";
makemaker_args dist => { COMPRESS => 'gzip -9f' };

auto_install;

WriteAll;
