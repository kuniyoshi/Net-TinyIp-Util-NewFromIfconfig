use inc::Module::Install;
name 'Net-TinyIp-Util-NewFromIfconfig';
all_from 'lib/Net/TinyIp/Util/NewFromIfconfig.pm';
readme_from "lib/Net/TinyIp/Util/NewFromIfconfig.pm";

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
