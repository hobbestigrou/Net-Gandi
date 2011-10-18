package Net::Gandi;

use Moose;
use XMLRPC::Lite;
use Carp;
use Class::Date qw( :errors date localdate gmdate now -DateParse );

use Net::Gandi::Types;
use Net::Gandi::Hosting::Datacenter;
use Net::Gandi::Hosting::VM;
use Net::Gandi::Hosting::Disk;
use Net::Gandi::Hosting::Image;
use Net::Gandi::Hosting::Iface;
use Net::Gandi::Hosting::IP;
use Net::Gandi::Hosting::Operation;

=head1 NAME

=encoding utf-8

Net::Gandi - A perl interface to the Gandi XMLRPC API

=head1 new
Creates a new instance of Net::Gandi

Parameters:

=over

=item * apikey

B<(Required)> Api key of your account.

=item * apiurl

Specified a url. The default value is current api version

=item * useragent

Specified a useragent. The default value is Net::Gandi with the version.

=item * date_object

Boolean to transform the string date in a perl date object. Use Class::Date.

=back

=cut

our $VERSION = '0.11';

has 'apikey' => (
    is       => 'rw',
    required => 1,
    isa      => 'Str'
);

has 'apiurl' => (
    is      => 'rw',
    isa     => 'Net::Gandi::Types::URI',
    coerce  => 1,
    default => 'https://rpc.gandi.net/xmlrpc/2.0/',
);

has 'useragent' => (
    is      => 'rw',
    isa     => 'Str',
    default => "Net::Gandi/$VERSION",
);

has 'err' => (
    is      => 'rw',
    isa     => 'Int',
);

has 'errstr' => (
    is      => 'rw',
    isa     => 'Str',
);

has 'date_object' => (
    is      => 'rw',
    default => 0,
    isa     => 'Bool',
);

sub call_rpc {
    my ( $self, $method, @args ) = @_;

    my $url          = $self->apiurl;
    my $proxy        = XMLRPC::Lite->proxy($url);
    my $api_response = $proxy->call($method, $self->apikey, @args);
    $proxy->transport->agent($self->useragent);

    if ( $api_response->faultstring() ) {
        $self->err($api_response->faultcode());
        $self->errstr($api_response->faultstring());
        return undef;
    }

    if ( $self->date_object ) {
        return _date_object($api_response->result());
    }
    else {
        return $api_response->result();
    }
}

sub _date_object {
    my ( $object ) = @_;

   if ( ref($object) eq 'ARRAY' ) {
       foreach my $obj (@{$object}) {
           while ( my ($key, $value) = each %{$obj} ) {
               if ( $key =~ m/date_/ ) {
                   $obj->{$key} = Class::Date->new($value);
               }
           }
       }
   }
   else {
       while ( my ($key, $value) = each %{$object} ) {
           if ( $key =~ m/date_/ ) {
               $object->{$key} = Class::Date->new($value);
           }
       }
   }

  return $object;

}

=head1 err

Returns the numeric code of last error.

    my $err_code = $gandi->err;

=cut

=head1 errstr

Returns the human readable text for last error.

    my $err_description = gandi->errstr

=cut

=head1 cast_value

Force XMLRPC data types, to use before calls when using booleans for example.

=cut

sub cast_value {
    my ( $self, $type, $value ) = @_;

    return XMLRPC::Data->type($type)->value($value);
}

=head1 SYNOPSIS

    use Net::Gandi;

    my $vm = Net::Gandi::Hosting::VM->new(apikey => 'myapikey', id => 42);

    my $vm_info = $vm->info;

=head1 DESCRIPTION

This module provides a Perl interface to the Gandi API. See L<http://rpc.gandi.net>
for a full description of the Gandi API. For the moment, the API is in beta. You can
ask for a key via email. The interface can be changed.

=head1 AUTHOR

Natal Ngétal, C<< <hobbestig@cpan.org> >>

=head1 CONTRIBUTING

This module is developed on Github at:

L<http://github.com/hobbestigrou/Net-Gandi>

Feel free to fork the repo and submit pull requests

=head1 ACKNOWLEDGEMENTS

Franck Cuny and Michael Scherer for fix typo.
Gandi for this API

=head1 BUGS

Please report any bugs or feature requests in github.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Net::Gandi

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Natal Ngétal.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 SEE ALSO

L<Moose>
L<XMLRPC::Lite>
L<http://rpc.gandi.net>

=cut

1;
