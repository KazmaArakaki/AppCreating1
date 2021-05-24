<?php
declare(strict_types=1);

namespace App;

use Cake\Core\Configure;
use Cake\Core\Exception\MissingPluginException;
use Cake\Error\Middleware\ErrorHandlerMiddleware;
use Cake\Http\BaseApplication;
use Cake\Http\MiddlewareQueue;
use Cake\Http\Middleware\BodyParserMiddleware;
use Cake\Http\Middleware\CsrfProtectionMiddleware;
use Cake\I18n\Middleware\LocaleSelectorMiddleware;
use Cake\Routing\Middleware\AssetMiddleware;
use Cake\Routing\Middleware\RoutingMiddleware;

class Application extends BaseApplication {
  public function bootstrap(): void {
    parent::bootstrap();

    if (PHP_SAPI === 'cli') {
      $this->bootstrapCli();
    }

    if (Configure::read('debug')) {
      $this->addPlugin('DebugKit');
    }
  }

  public function middleware(MiddlewareQueue $middlewareQueue): MiddlewareQueue {
    $middlewareQueue
      ->add(new ErrorHandlerMiddleware(Configure::read('Error')))
      ->add(new AssetMiddleware([
        'cacheTime' => Configure::read('Asset.cacheTime'),
      ]))
      ->add(new RoutingMiddleware($this))
      ->add(new BodyParserMiddleware())
      // ->add(new CsrfProtectionMiddleware([
      //   'httponly' => true,
      // ]))
      ->add(new LocaleSelectorMiddleware([
        'ja',
      ]));

    return $middlewareQueue;
  }

  protected function bootstrapCli(): void {
    try {
      $this->addPlugin('Bake');
    } catch (MissingPluginException $e) {
    }

    $this->addPlugin('Migrations');
  }
}

