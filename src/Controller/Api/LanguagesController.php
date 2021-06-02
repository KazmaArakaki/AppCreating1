<?php
declare(strict_types=1);

namespace App\Controller\Api;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class LanguagesController extends ApiController {
  public function initialize(): void {
    parent::initialize();
  }

  public function index() {
    $languagesData = $this->Languages->find()
        ->order([
          'name' => 'asc',
        ])
        ->map(function ($language) {
          return [
            'short_key' => $language['short_key'],
            'name' => $language['name'],
          ];
        })
        ->toList();

    $this->responseData['data'] = [
      'languages' => $languagesData,
    ];
  }
}

