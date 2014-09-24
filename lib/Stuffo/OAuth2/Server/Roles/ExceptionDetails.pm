package Stuffo::OAuth2::Server::Roles::ExceptionDetails;

use MooseX::Role::Parameterized;

use String::CamelCase qw( decamelize );

requires 'message';

parameter 'code' => (
		isa => 'Str',
		required => 1
	);

role {
	my $params = shift();

	method 'get_render_data' => sub {
		my $self = shift();

		return {
			json => {
				code => $params->code(),
				error_type => decamelize( pop( @{ [ split( /::/, ref( $self ) ) ] } ) ),
				error_message => $self->message(),
			},

			status => $params->code(),
		}
	};
};

1;