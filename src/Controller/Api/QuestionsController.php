<?php
declare(strict_types=1);

namespace App\Controller\Api;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class QuestionsController extends ApiController {
  public function initialize(): void {
    parent::initialize();
  }

  public function index() {
    $questionsData = $this->Questions->find()
        ->map(function ($question) {
          return [
            'uuid' => $question['uuid'],
            'title' => h($question['title']),
          ];
        })
        ->toList();

    $this->responseData['data'] = [
      'questions' => $questionsData,
    ];
  }
}

