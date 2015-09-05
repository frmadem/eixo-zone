use Test::More;
use Eixo::Zone;

ok(1);

my $zone = Eixo::Zone->init(

	entry=>sub {

	},

	network=>{

		type=>"veth",

		internal_net=>"10.1.1.2/24",

		external_net=>"10.1.1.1/24"

	},

	volumes=>{

		self_tmp=>1,

		self_proc=>1
	},

);

done_testing();
