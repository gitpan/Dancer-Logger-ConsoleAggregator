use strict;
use warnings;
package Dancer::Logger::ConsoleAggregator;
{
  $Dancer::Logger::ConsoleAggregator::VERSION = '0.001';
}
use Dancer::Hook;
use JSON qw(to_json);

use base 'Dancer::Logger::Abstract';

# ABSTRACT: Dancer Console Logger that aggregates each requests logs to 1 line.

my $log_message = [];

sub _log {
    my ($self, $level, $message) = @_;
    push (@$log_message => {$level => $message});
}

sub flush {
    print STDERR to_json($log_message) ."\n";
    $log_message = [];
}

sub init {
    Dancer::Hook->new( 'after', sub { flush } );
}

1;


__END__
=pod

=head1 NAME

Dancer::Logger::ConsoleAggregator - Dancer Console Logger that aggregates each requests logs to 1 line.

=head1 VERSION

version 0.001

=head1 SYNOPSIS

This module will aggregate all logging done for each request into one line
in the output.  It does this by queueing everything up and adding an
C<after> hook that calls the C<flush> function, which causes the logger
to output the log line for the current request.

=head1 AUTHORS

=over 4

=item *

Khaled Hussein <khaled.hussein@gmail.com>

=item *

William Wolf <throughnothing@gmail.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Khaled Hussein.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

