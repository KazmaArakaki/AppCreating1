<?php
declare(strict_types=1);

namespace App\Controller\Api;

use Cake\Controller\Controller;

class HealthcheckController extends Controller {
  public function initialize(): void {
    parent::initialize();

    $this->loadComponent('RequestHandler');
  }

  public function index() {
    $responseData = [
      'success' => true,
    ];

    $this->set($responseData);

    $this->viewBuilder()
        ->setOption('serialize', array_keys($responseData));
  }
}

