package Net::Gandi::Hosting::Operation;

use Moose;
use utf8;

extends 'Net::Gandi';

=head1 NAME

=encoding utf-8 

Net::Gandi::Hosting::Operation - Interface to manage operation. 

=head1 DESCRIPTION

Informations about the operation

=cut

has 'id' => ( is => 'rw', isa => 'Int' );

=head1 list 

Perform a operation.info
Returns informations about the operation

=cut

sub info {
    my ( $self ) = @_;

    return $self->call_rpc( 'operation.info', $self->id );
}

1;

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>
