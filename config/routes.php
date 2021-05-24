<?php
use Cake\Routing\Route\DashedRoute;
use Cake\Routing\RouteBuilder;

$routes->setRouteClass(DashedRoute::class);

$routes->scope('/', function (RouteBuilder $builder) {
  $builder->connect('/', [
    'controller' => 'Home',
    'action' => 'index',
  ]);

  $builder->connect('/pages/*', 'Pages::display');

  $builder->fallbacks();
});

$routes->prefix('Api', function (RouteBuilder $builder) {
  $builder->setExtensions(['json']);

  $builder->fallbacks();
});

