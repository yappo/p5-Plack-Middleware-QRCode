use inc::Module::Install;
name 'Plack-Middleware-QRCode';
all_from 'lib/Plack/Middleware/QRCode.pm';
readme_from 'lib/Plack/Middleware/QRCode.pm';
readme_markdown_from 'lib/Plack/Middleware/QRCode.pm';
githubmeta;

requires 'parent';
requires 'Plack::Middleware';
requires 'Plack::MIME';
requires 'Plack::Request';
requires 'Imager::QRCode';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
