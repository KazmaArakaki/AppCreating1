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
    $requestLogs = $this->RequestLogs->find()
        ->order([
          'RequestLogs.created' => 'desc',
        ])
        ->toList();

    $this->set(compact([
      'requestLogs',
    ]));
  }
}

