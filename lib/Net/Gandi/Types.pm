package Net::Gandi::Types;

use MooseX::Types::Moose qw/Str ArrayRef HashRef/;
use MooseX::Types -declare => [qw(Client)];

class_type Client, { class => 'Net::Gandi::Client' };

1;

=head1 SEE ALSO
L<Moose::Util::TypeConstraints>

=head1 AUTHOR

Natal Ngétal
