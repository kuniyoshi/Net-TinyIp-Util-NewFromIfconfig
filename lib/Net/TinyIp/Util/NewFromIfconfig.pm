package Net::TinyIp::Util::NewFromIfconfig;
use strict;
use warnings;
use base "Net::TinyIp::Util";

our $VERSION = "0.01";

sub import_methods { qw( new_from_ifconfig ) }

sub new_from_ifconfig {
    my $class = shift;
    my %param = @_;

    if ( my $if = $param{if} ) {
        $param{config} = join q{}, `ifconfig $if`;
    }

    my( $line ) = grep { m{\A \s+ inet[ ] }msx }
                  split m{\n}, $param{config};

    my( $host, $network ) = $line =~ m{\A \s+ inet[ ](.+?) [ ] netmask[ ](.+?) [ ] }msx;

    $host    = Net::TinyIp::Address::v4->from_string( $host );
    $network = Net::TinyIp::Address::v4->from_hex( $network );

    return bless { host => $host, network => $network }, $class;
}

1;
__END__

=head1 NAME

Net::TinyIp::Util::NewFromIfconfig - new IPv4 from ifconfig command

=head1 SYNOPSIS

  use Net::TinyIp qw( new_from_ifconfig );
  my $ip = Net::TinyIp->new_from_ifconfig( if => "en0" );

=head1 DESCRIPTION

Net::TinyIp::Util::NewFromIfconfig is a util module.

=head1 AUTHOR

kuniyoshi E<lt>kuniyoshi@cpan.orgE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

