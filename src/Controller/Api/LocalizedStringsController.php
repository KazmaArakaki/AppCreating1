<?php
declare(strict_types=1);

namespace App\Controller\Api;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class LocalizedStringsController extends ApiController {
  public function initialize(): void {
    parent::initialize();

    $this->loadModel('Languages');
    $this->loadModel('StringUuids');
  }

  public function index() {
    try {
      $language = $this->Languages->find()
          ->where([
            ['Languages.short_key' => $this->request->getQuery('language_short_key', '')],
          ])
          ->first();

      if (empty($language)) {
        $language = $this->Languages->find()
            ->where([
              ['Languages.is_default' => true],
            ])
            ->first();
      }

      $localizedStringsData = $this->LocalizedStrings->find()
          ->contain([
            'StringUuids',
          ])
          ->where([
            ['LocalizedStrings.language_id' => $language['id']],
          ])
          ->combine('string_uuid.uuid', 'value');

      $this->responseData['data'] = [
        'localized_strings' => $localizedStringsData,
      ];
    } catch (AppException $exception) {
      Log::error(sprintf('[Api.LocalizedStringsController::index] %s', $exception->getMessage()));

      $this->responseData['success'] = false;
    }
  }
}

