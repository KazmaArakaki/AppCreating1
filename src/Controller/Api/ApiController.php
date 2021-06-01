<?php
declare(strict_types=1);

namespace App\Controller\Api;

use App\Utility\ApiErrorCode;
use Cake\Controller\Controller;
use Cake\Core\Configure;
use Cake\Event\EventInterface;
use Cake\Log\Log;
use stdClass;

class ApiController extends Controller {
  public function initialize(): void {
    parent::initialize();

    $this->loadModel('Devices');
    $this->loadModel('RequestLogs');

    $this->loadComponent('RequestHandler');
  }

  public function beforeFilter(EventInterface $event) {
    parent::beforeFilter($event);

    $this->responseData = [
      'success' => true,
      'error_code' => ApiErrorCode::NO_ERROR,
      'data' => [],
    ];

    $isValidRequest = true;
    $isValidRequest = $isValidRequest && !empty($this->request->getHeaderLine('X-Device-Uuid'));
    $isValidRequest = $isValidRequest && !empty($this->request->getHeaderLine('X-Device-Name'));
    $isValidRequest = $isValidRequest && !empty($this->request->getHeaderLine('X-Device-System'));
    $isValidRequest = $isValidRequest && !empty($this->request->getHeaderLine('X-Device-Timezone'));
    $isValidRequest = $isValidRequest && !empty($this->request->getHeaderLine('X-Forwarded-For'));
    $isValidRequest = $isValidRequest && !empty($this->request->getHeaderLine('X-App-Version'));

    if (!$isValidRequest && !Configure::read('debug')) {
      return $this->response
          ->withStatus(403)
          ->withStringBody('Invalid Request');
    }

    $this->device = $this->Devices->find()
        ->where([
          ['Devices.vendor_uuid' => $this->request->getHeaderLine('X-Device-Uuid')],
        ])
        ->first();

    if (empty($this->device)) {
      $this->device = $this->Devices->newEntity([
        'vendor_uuid' => $this->request->getHeaderLine('X-Device-Uuid'),
        'name' => $this->request->getHeaderLine('X-Device-Name'),
      ]);
    }

    $this->device['os'] = $this->request->getHeaderLine('X-Device-System');
    $this->device['timezone'] = $this->request->getHeaderLine('X-Device-Timezone');
    $this->device['ip'] = $this->request->getHeaderLine('X-Forwarded-For');

    $deviceSaved = $this->Devices->save($this->device);

    if (!$deviceSaved) {
      Log::error(sprintf('[Api.ApiController::beforeFilter] Failed to save Device. (%s)', json_encode([
        'device' => $this->device,
      ])));

      return $this->response
          ->withStatus(500)
          ->withStringBody('Internal Error');
    }

    $requestLog = $this->RequestLogs->newEntity([
      'device_id' => $this->device['id'],
      'name' => $this->request->getHeaderLine('X-Device-Name'),
      'os' => $this->request->getHeaderLine('X-Device-System'),
      'timezone' => $this->request->getHeaderLine('X-Device-Timezone'),
      'ip' => $this->request->getHeaderLine('X-Forwarded-For'),
      'app_version' => $this->request->getHeaderLine('X-App-Version'),
      'request_path' => $this->request->getPath(),
      'request_query' => json_encode($this->request->getQueryParams()),
      'request_data' => json_encode($this->request->getData()),
    ]);

    $requestLogSaved = $this->RequestLogs->save($requestLog);

    if (!$requestLogSaved) {
      Log::error(sprintf('[Api.ApiController::beforeFilter] Failed to save RequestLog. (%s)', json_encode([
        'request_log' => $requestLog,
      ])));
    }
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

