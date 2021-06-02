<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class LocalizedStringsController extends AdminController {
  public function initialize(): void {
    parent::initialize();

    $this->loadModel('Languages');
    $this->loadModel('StringUuids');
  }

  public function create($stringUuidId) {
    $stringUuid = $this->StringUuids->find()
        ->where([
          ['StringUuids.id' => $stringUuidId],
        ])
        ->first();

    if (empty($stringUuid)) {
      $this->Flash->error(__('テキストが見つかりませんでした。'));

      return $this->redirect([
        'controller' => 'StringUuids',
        'action' => 'index',
      ]);
    }

    $localizedString = null;

    $languageCollection = $this->Languages->find();

    if ($this->request->is(['post'])) {
      try {
        $language = $this->Languages->find()
            ->where([
              ['Languages.id' => $this->request->getData('language_id')],
            ])
            ->first();

        if (empty($language)) {
          throw new AppException(sprintf('Failed to find Language. (%s)', json_encode([
            'id' => $this->request->getData('language_id'),
          ])));
        }

        $localizedString = $this->LocalizedStrings->find()
            ->where([
              ['LocalizedStrings.string_uuid_id' => $stringUuid['id']],
              ['LocalizedStrings.language_id' => $language['id']],
            ])
            ->first();

        if (!empty($localizedString)) {
          $this->Flash->error(__('テキストローカライズが既に作成されています。'));

          return $this->redirect([
            'action' => 'update',
            'stringUuidId' => $stringUuid['id'],
            $localizedString['id'],
          ]);
        }

        $localizedString = $this->LocalizedStrings->newEntity([
          'string_uuid_id' => $stringUuid['id'],
          'language_id' => $language['id'],
          'value' => $this->request->getData('value'),
        ]);

        $localizedStringSaved = $this->LocalizedStrings->save($localizedString);

        if (!$localizedStringSaved) {
          throw new AppException(sprintf('Failed to save LocalizedString. (%s)', json_encode([
            'localizedString' => $localizedString,
          ])));
        }

        $this->Flash->success(__('テキストローカライズを保存しました。'));

        return $this->redirect([
          'action' => 'index',
          'stringUuidId' => $stringUuid['id'],
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('テキストローカライズを保存できませんでした。'));

        Log::error(sprintf('[Admin.LocalizedStringsController::create] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'stringUuid',
      'localizedString',
      'languageCollection',
    ]));
  }

  public function index($stringUuidId) {
    $stringUuid = $this->StringUuids->find()
        ->where([
          ['StringUuids.id' => $stringUuidId],
        ])
        ->first();

    if (empty($stringUuid)) {
      $this->Flash->error(__('テキストが見つかりませんでした。'));

      return $this->redirect([
        'controller' => 'StringUuids',
        'action' => 'index',
      ]);
    }

    $localizedStrings = $this->LocalizedStrings->find()
        ->contain([
          'Languages',
        ])
        ->where([
          ['LocalizedStrings.string_uuid_id' => $stringUuid['id']],
        ])
        ->order([
          'LocalizedStrings.language_id' => 'desc',
        ])
        ->toList();

    $this->set(compact([
      'stringUuid',
      'localizedStrings',
    ]));
  }

  public function update($stringUuidId, $id) {
    $stringUuid = $this->StringUuids->find()
        ->where([
          ['StringUuids.id' => $stringUuidId],
        ])
        ->first();

    if (empty($stringUuid)) {
      $this->Flash->error(__('テキストが見つかりませんでした。'));

      return $this->redirect([
        'controller' => 'StringUuids',
        'action' => 'index',
      ]);
    }

    $localizedString = $this->LocalizedStrings->find()
        ->contain([
          'Languages',
        ])
        ->where([
          ['LocalizedStrings.id' => $id],
        ])
        ->first();

    if (empty($localizedString)) {
      $this->Flash->error(__('テキストローカライズが見つかりませんでした。'));

      return $this->redirect([
        'action' => 'index',
        'stringUuidId' => $stringUuid['id'],
      ]);
    }

    if ($this->request->is(['put'])) {
      try {
        $this->LocalizedStrings->patchEntity($localizedString, [
          'value' => $this->request->getData('value'),
        ]);

        $localizedStringSaved = $this->LocalizedStrings->save($localizedString);

        if (!$localizedStringSaved) {
          throw new AppException(sprintf('Failed to save LocalizedString. (%s)', json_encode([
            'localizedString' => $localizedString,
          ])));
        }

        $this->Flash->success(__('テキストローカライズを保存しました。'));

        return $this->redirect([
          'action' => 'index',
          'stringUuidId' => $stringUuid['id'],
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('テキストローカライズを保存できませんでした。'));

        Log::error(sprintf('[Admin.LocalizedStringsController::update] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'stringUuid',
      'localizedString',
    ]));
  }

  public function delete($stringUuidId, $id) {
    $stringUuid = $this->StringUuids->find()
        ->where([
          ['StringUuids.id' => $stringUuidId],
        ])
        ->first();

    if (empty($stringUuid)) {
      $this->Flash->error(__('テキストが見つかりませんでした。'));

      return $this->redirect([
        'controller' => 'StringUuids',
        'action' => 'index',
      ]);
    }

    if ($this->request->is(['delete'])) {
      try {
        $localizedString = $this->LocalizedStrings->find()
            ->where([
              ['LocalizedStrings.id' => $id],
            ])
            ->first();

        if (empty($localizedString)) {
          throw new AppException(sprintf('Failed to find LocalizedString. (%s)', json_encode([
            'id' => $id,
          ])));
        }

        $localizedStringDeleted = $this->LocalizedStrings->delete($localizedString);

        if (!$localizedStringDeleted) {
          throw new AppException(sprintf('Failed to delete LocalizedString. (%s)', json_encode([
            'localizedString' => $localizedString,
          ])));
        }

        $this->Flash->success(__('テキストローカライズを削除しました。'));
      } catch (AppException $exception) {
        $this->Flash->error(__('テキストローカライズを削除できませんでした。'));

        Log::error(sprintf('[Admin.LocalizedStringsController::delete] %s', $exception->getMessage()));
      }
    }

    return $this->redirect([
      'action' => 'index',
      'stringUuidId' => $stringUuid['id'],
    ]);
  }
}

