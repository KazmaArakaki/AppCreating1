<?php
declare(strict_types=1);

namespace App\Controller\Api;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class TopicsController extends ApiController {
  public function initialize(): void {
    parent::initialize();
  }

  public function index() {
    $topicsData = $this->Topics->find()
        ->map(function ($topic) {
          return [
            'uuid' => $topic['uuid'],
            'title' => h($topic['title']),
          ];
        })
        ->toList();

    $this->responseData['data'] = [
      'topics' => $topicsData,
    ];
  }
}

