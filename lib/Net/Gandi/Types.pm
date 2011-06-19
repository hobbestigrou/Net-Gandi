package Net::Gandi::Types;

use Moose::Util::TypeConstraints;
use URI;

=head1 NAME

=encoding utf-8

Net::Gandi::Types - Type definition for L<Net::Gandi>

=head1 SYNOPSIS
    use Net::Gandi::Types

=head1 DESCRIPTION

Moose type definitions for L<Net::Gandi>

=cut

=head1 Net::Gandi::Types::URI

Subtype of L<URI>. Can be coerced from a string representing the URL.

=cut

subtype 'Net::Gandi::Types::URI' => as 'URI';

coerce 'Net::Gandi::Types::URI' => from 'Str' => via {
    URI->new($_);
};

1;

=head1 SEE ALSO
L<Moose::Util::TypeConstraints>

=head1 AUTHOR

Natal Ngétal
