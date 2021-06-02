<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class RequestLogsController extends AdminController {
  public function initialize(): void {
    parent::initialize();
  }

  public function index() {
    $requestLogsQuery = $this->RequestLogs->find();

    $requestLogs = $this->paginate($requestLogsQuery, [
      'limit' => 300,
      'order' => [
        'RequestLogs.id' => 'desc',
      ],
    ]);

    $this->set(compact([
      'requestLogs',
    ]));
  }
}

