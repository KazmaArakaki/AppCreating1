<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Exception\Exception as AppException;
use Cake\Log\Log;

class StringUuidsController extends AdminController {
  public function initialize(): void {
    parent::initialize();

    $this->loadModel('Languages');
    $this->loadModel('LocalizedStrings');
  }

  public function create() {
    $stringUuid = null;

    if ($this->request->is(['post'])) {
      try {
        $stringUuid = $this->StringUuids->newEntity([
          'description' => $this->request->getData('description'),
        ]);

        $stringUuidSaved = $this->StringUuids->save($stringUuid);

        if (!$stringUuidSaved) {
          throw new AppException(sprintf('Failed to save StringUuid. (%s)', json_encode([
            'stringUuid' => $stringUuid,
          ])));
        }

        $this->Flash->success(__('テキストを保存しました。'));

        return $this->redirect([
          'controller' => 'LocalizedStrings',
          'action' => 'index',
          'stringUuidId' => $stringUuid['id'],
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('テキストを保存できませんでした。'));

        Log::error(sprintf('[Admin.StringUuidsController::create] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'stringUuid',
    ]));
  }

  public function index() {
    $session = $this->request->getSession();

    $searchQuery = $session->read('Admin.StringUuids.searchQuery');

    $targetLanguageId = $session->read('Admin.StringUuids.targetLanguageId');

    if ($this->request->is(['post'])) {
      if (!empty($this->request->getData('search_query'))) {
        $searchQuery = $this->request->getData('search_query');

        $session->write('Admin.StringUuids.searchQuery', $searchQuery);
      } else {
        $searchQuery = null;

        $session->delete('Admin.StringUuids.searchQuery');
      }

      if (!empty($this->request->getData('target_language_id'))) {
        $targetLanguageId = $this->request->getData('target_language_id');

        $session->write('Admin.StringUuids.targetLanguageId', $targetLanguageId);
      } else {
        $searchQuery = null;

        $session->delete('Admin.StringUuids.targetLanguageId');
      }

      return $this->redirect([]);
    }

    $stringUuidsQuery = $this->StringUuids->find();

    if (!empty($searchQuery)) {
      $stringUuidIds = $this->LocalizedStrings->find()
          ->where([
            ['LocalizedStrings.value LIKE' => sprintf('%%%s%%', $searchQuery)],
          ])
          ->extract('string_uuid_id')
          ->toList();

      $stringUuidIds = array_unique($stringUuidIds);

      if (empty($stringUuidIds)) {
        $stringUuidIds = [0];
      }

      $stringUuidsQuery->where([
        [
          'OR' => [
            ['StringUuids.id IN' => $stringUuidIds],
            ['StringUuids.description LIKE' => sprintf('%%%s%%', $searchQuery)],
          ],
        ],
      ]);
    }

    if (!empty($targetLanguageId)) {
      $stringUuidIds = $this->LocalizedStrings->find()
          ->where([
            ['LocalizedStrings.language_id' => $targetLanguageId],
          ])
          ->extract('string_uuid_id')
          ->toList();

      $stringUuids = array_unique($stringUuidIds);

      if (empty($stringUuidIds)) {
        $stringUuidIds = [0];
      }

      $stringUuidsQuery->where([
        ['StringUuids.id NOT IN' => $stringUuids],
      ]);
    }

    $stringUuids = $stringUuidsQuery
        ->contain([
          'LocalizedStrings',
        ])
        ->order([
          'StringUuids.id' => 'desc',
        ])
        ->toList();

    $languageCollection = $this->Languages->find();

    $stringUuidCount = $this->StringUuids->find()
        ->count();

    $localizedStringsQuery = $this->LocalizedStrings->find();

    $localizedStringCountMapByLanguageId = $localizedStringsQuery
        ->select([
          'language_id',
          'count' => $localizedStringsQuery->func()
              ->count('id'),
        ])
        ->group([
          'LocalizedStrings.language_id',
        ])
        ->enableHydration(false)
        ->indexBy('language_id')
        ->toArray();

    $this->set(compact([
      'languageCollection',
      'localizedStringCountMapByLanguageId',
      'searchQuery',
      'stringUuidCount',
      'stringUuids',
      'targetLanguageId',
    ]));
  }

  public function update($id) {
    $stringUuid = $this->StringUuids->find()
        ->where([
          ['StringUuids.id' => $id],
        ])
        ->first();

    if (empty($stringUuid)) {
      $this->Flash->error(__('テキストが見つかりませんでした。'));
    }

    if ($this->request->is(['put'])) {
      try {
        $this->StringUuids->patchEntity($stringUuid, [
          'description' => $this->request->getData('description'),
        ]);

        $stringUuidSaved = $this->StringUuids->save($stringUuid);

        if (!$stringUuidSaved) {
          throw new AppException(sprintf('Failed to save StringUuid. (%s)', json_encode([
            'stringUuid' => $stringUuid,
          ])));
        }

        $this->Flash->success(__('テキストを保存しました。'));

        return $this->redirect([
          'action' => 'index',
        ]);
      } catch (AppException $exception) {
        $this->Flash->error(__('テキストを保存できませんでした。'));

        Log::error(sprintf('[Admin.StringUuidsController::update] %s', $exception->getMessage()));
      }
    }

    $this->set(compact([
      'stringUuid',
    ]));
  }

  public function delete($id) {
    if ($this->request->is(['delete'])) {
      try {
        $stringUuid = $this->StringUuids->find()
            ->where([
              ['StringUuids.id' => $id],
            ])
            ->first();

        if (empty($stringUuid)) {
          throw new AppException(sprintf('Failed to find StringUuid. (%s)', json_encode([
            'id' => $id,
          ])));
        }

        $stringUuidDeleted = $this->StringUuids->delete($stringUuid);

        if (!$stringUuidDeleted) {
          throw new AppException(sprintf('Failed to delete StringUuid. (%s)', json_encode([
            'stringUuid' => $stringUuid,
          ])));
        }

        $this->Flash->success(__('テキストを削除しました。'));
      } catch (AppException $exception) {
        $this->Flash->error(__('テキストを削除できませんでした。'));

        Log::error(sprintf('[Admin.StringUuidsController::delete] %s', $exception->getMessage()));
      }
    }

    return $this->redirect([
      'action' => 'index',
    ]);
  }
}

