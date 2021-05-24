<?php
declare(strict_types=1);

namespace App\Controller;

use Cake\Event\EventInterface;
use Cake\Http\Exception\ForbiddenException;
use Cake\I18n\Time;
use Cake\Log\Log;

class ErrorController extends AppController {
  public function initialize(): void {
    parent::initialize();
  }

  public function beforeFilter(EventInterface $event) {
  }

  public function beforeRender(EventInterface $event) {
    parent::beforeRender($event);

    $this->viewBuilder()->setTemplatePath('Error');
  }

  public function afterFilter(EventInterface $event) {
  }
}

