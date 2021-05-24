<?php
declare(strict_types=1);

namespace App\Controller\Api;

use App\Utility\ApiErrorCode;
use Cake\Controller\Controller;
use Cake\Event\EventInterface;
use stdClass;

class ApiController extends Controller {
  public function initialize(): void {
    parent::initialize();

    $this->loadComponent('RequestHandler');
  }

  public function beforeFilter(EventInterface $event) {
    parent::beforeFilter($event);

    $this->responseData = [
      'success' => true,
      'error_code' => ApiErrorCode::NO_ERROR,
      'data' => [],
    ];
  }

  public function beforeRender(EventInterface $event) {
    parent::beforeRender($event);

    if (!$this->responseData['success'] && $this->responseData['error_code'] === ApiErrorCode::NO_ERROR) {
      $this->responseData['error_code'] = ApiErrorCode::SYSTEM_ERROR;
    }

    if (empty($this->responseData['data'])) {
      $this->responseData['data'] = new stdClass();
    }

    $this->set($this->responseData);

    $this->viewBuilder()
        ->setOption('serialize', array_keys($this->responseData));
  }
}

